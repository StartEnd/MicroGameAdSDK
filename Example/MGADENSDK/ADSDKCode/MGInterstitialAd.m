//
//  MGInterstitialAd.m
//  MGADENSDK
//
//  Created by Mr.Song on 2020/2/13.
//  Copyright © 2020 Mr.Song. All rights reserved.
//

#import "MGInterstitialAd.h"
#import "MGADHelper.h"
#import "MGADProtocol.h"
#import "MGADStrategy.h"
#import "MGNetManager.h"
#import "MGNetAPI.h"
#import "NSObject+WHC_Model.h"
#import "MGADManager.h"

@import FacebookAdapter;
@import GoogleMobileAds;
@import FBAudienceNetwork;

@interface MGInterstitialAd()<FBInterstitialAdDelegate,GADInterstitialDelegate>

@property(nonatomic, strong) MGADStrategy       *adStrategy;

@property (nonatomic, strong) FBInterstitialAd  *fbInterstitialAd;
@property(nonatomic, strong) GADInterstitial    *gInterstitialAd;

@property(nonatomic, assign) NSUInteger         index;

@property(nonatomic, assign) MGADPlat           platform;

@property(nonatomic, assign)BOOL                fbAdEnd;
@property(nonatomic, assign)BOOL                gAdEnd;

@property(nonatomic, assign) NSInteger           testType;


@end

@implementation MGInterstitialAd

- (NSInteger)testType {
    return [[MGADManager manager] testType];
}

- (instancetype)initWithAdid:(NSString *)adid {
    if(self = [super init]) {
        _adid = adid;
        [self initialize];
    }
    return self;
}

- (void)initialize {
}

- (void)loadAd {
    //如果广告先前已经加载好了,又调用加载方法,忽略掉
    if(self.isAdValid) {
        [self adDidLoad];
        return;
    }
    self.index = -1;
    self.fbAdEnd = NO;
    self.gAdEnd = NO;
    //换取真实id
    __weak typeof(self) weakSelf = self;
    NSDictionary *params = @{@"app_key":@"1",@"platform":@"2",@"ad_id":@"a12",@"ad_type":@"3"};
    [MGNetManager requestApi:MGAPI_Strategy method:WGHTTPMethod_GET params:params success:^(NSDictionary *data) {
        weakSelf.adStrategy = [MGADStrategy whc_ModelWithJson:data];
        if(weakSelf.adStrategy.status == 1) {
            [weakSelf changeStrategy];
            [weakSelf cachedAd];
        }else {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"新浪游戏后台无数据返回" forKey:NSLocalizedDescriptionKey];
            NSError *error = [NSError errorWithDomain:@"com.sina.game.ads.sdk" code:1000 userInfo:userInfo];
            [weakSelf adLoadError:error];
        }
    } fail:^(NSError *error) {
        weakSelf.adStrategy = nil;
        [self adLoadError:error];
    }];
}

- (void)changeStrategy {
    if(self.testType == 1)  {
        self.adStrategy.order = @[@"google"];
        //self.adStrategy.google = @"ca-app-pub-3940256099942544/4411468910";
        self.adStrategy.google = @"ca-app-pub-4467542253883619/6526203456";

    } else if(self.testType == 2) {
        self.adStrategy.order = @[@"facebook"];
    }
}

- (void)cachedAd {
    self.index += 1;
    
    if(self.adStrategy.order.count < self.index + 1) {
        return;
    }
    NSString *plat = self.adStrategy.order[self.index];
    if([plat isEqualToString:@"facebook"]) {
        self.platform = MGADPlat_Facebook;
        [self cachedFacebookAd];
    }
    else if([plat isEqualToString:@"google"]) {
        self.platform = MGADPlat_Google;
        [self cachedGoogleAd];
    } else {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"未请求到广告数据" forKey:NSLocalizedDescriptionKey];
        NSError *error = [NSError errorWithDomain:@"com.sina.game.ads.sdk" code:1000 userInfo:userInfo];
        if([self.delegate respondsToSelector:@selector(interstitialAd:didFailWithError:)]) {
            [self.delegate interstitialAd:self didFailWithError:error];
        }
    }
}

- (BOOL)isAdValid {
    if(self.platform == MGADPlat_Google) {
        return self.gInterstitialAd.isReady;
    }
    else if(self.platform == MGADPlat_Facebook) {
        return self.fbInterstitialAd.isAdValid;
    }
    else {
        return NO;
    }
}

- (BOOL)isReward {
    if(self.platform == MGADPlat_Google) {
        return self.gAdEnd;
    }
    else if(self.platform == MGADPlat_Facebook) {
        return self.fbAdEnd;
    }
    else {
        return NO;
    }
}


// 广告事件
// 广告加载完成
- (void)adDidLoad {
    if([self.delegate respondsToSelector:@selector(interstitialAdDidLoad:)]) {
       [self.delegate interstitialAdDidLoad:self];
    }
}

//广告加载失败
- (void)adLoadError:(NSError *)error {
    if([self.delegate respondsToSelector:@selector(interstitialAd:didFailWithError:)]) {
        [self.delegate interstitialAd:self didFailWithError:error];
    }
}

// 广告将要被关闭
- (void)adWillClose {
    if([self.delegate respondsToSelector:@selector(interstitialAdWillClose:)]) {
        [self.delegate interstitialAdWillClose:self];
    }
}

//广告已经被关闭
- (void)adDidClose {
    if([self.delegate respondsToSelector:@selector(interstitialAdDidClose:)]) {
        [self.delegate interstitialAdDidClose:self];
    }
}

// 广告被点击
- (void)adDidClick {
    if([self.delegate respondsToSelector:@selector(interstitialAdDidClick:)]) {
        [self.delegate interstitialAdDidClick:self];
    }
}

// 广告将要被展示或已经展示了
- (void)adShow {
    if([self.delegate respondsToSelector:@selector(interstitialPresentScreen:)]) {
        [self.delegate interstitialPresentScreen:self];
    }
}


//当前应该显示那个
- (void)showAdFromRootViewController:(UIViewController *)rootViewController {
    if(self.platform == MGADPlat_Facebook) {
        if (self.fbInterstitialAd.isAdValid) {
         [self.fbInterstitialAd showAdFromRootViewController:rootViewController];
        } else {
            NSLog(@"Ad wasn't ready");
        }
    }
    else if(self.platform == MGADPlat_Google) {
        if (self.gInterstitialAd.isReady) {
            [self.gInterstitialAd presentFromRootViewController:rootViewController];
            } else {
              NSLog(@"Ad wasn't ready");
            }
    }
}


# pragma mark - FaceBook Ads
- (void)cachedFacebookAd {
    self.fbInterstitialAd = [[FBInterstitialAd alloc] initWithPlacementID:self.adStrategy.facebook];
    self.fbInterstitialAd.delegate = self;
    [self.fbInterstitialAd loadAd];
}



#pragma mark -  Facebook Delegate

- (void)interstitialAdDidLoad:(FBInterstitialAd *)interstitialAd
{
    [self adDidLoad];
}

- (void)interstitialAdWillLogImpression:(FBInterstitialAd *)interstitialAd
{
    [self adShow];
}

- (void)interstitialAdDidClick:(FBInterstitialAd *)interstitialAd
{
    [self adDidClick];
}

- (void)interstitialAdWillClose:(FBInterstitialAd *)interstitialAd
{
    [self adWillClose];
}

- (void)interstitialAdDidClose:(FBInterstitialAd *)interstitialAd
{
    self.fbInterstitialAd = nil;//解决Facebook的广告adVaid问题
    [self adDidClose];
}

- (void)interstitialAd:(FBInterstitialAd *)interstitialAd didFailWithError:(NSError *)error
{
    [self adLoadError:error];
}
      

#pragma mark - google Ads

- (void)cachedGoogleAd {
    self.gInterstitialAd = [self createAndLoadInterstitialAd];
}

- (GADInterstitial *)createAndLoadInterstitialAd {
    GADInterstitial *interstitial =
        [[GADInterstitial alloc] initWithAdUnitID:self.adStrategy.google];
    interstitial.delegate = self;
    [interstitial loadRequest:[GADRequest request]];
    return interstitial;
}


#pragma mark - google delegate


/// Tells the delegate an ad request succeeded.
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
    NSLog(@"Interstitial adapter class name: %@", ad.responseInfo.adNetworkClassName);
    [self adDidLoad];
}

/// Tells the delegate an ad request failed.
- (void)interstitial:(GADInterstitial *)ad
    didFailToReceiveAdWithError:(GADRequestError *)error {
    [self adLoadError:error];
}

/// Tells the delegate that an interstitial will be presented.
- (void)interstitialWillPresentScreen:(GADInterstitial *)ad {
    [self adShow];
}

/// Tells the delegate the interstitial is to be animated off the screen.
- (void)interstitialWillDismissScreen:(GADInterstitial *)ad {
    [self adWillClose];
}

/// Tells the delegate the interstitial had been animated off the screen.
- (void)interstitialDidDismissScreen:(GADInterstitial *)ad {
    [self adDidClose];
}

/// Tells the delegate that a user click will open another app
/// (such as the App Store), backgrounding the current app.
- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad {
    [self adDidClick];
}


@end
