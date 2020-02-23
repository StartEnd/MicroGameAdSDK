//
//  MGRewardedAd.m
//  MGADENSDK
//
//  Created by Mr.Song on 2020/2/13.
//  Copyright © 2020 Mr.Song. All rights reserved.
//

#import "MGRewardedAd.h"
#import "MGFBRewardAdController.h"
#import "MGGRewardAdController.h"
#import "MGNetManager.h"
#import "MGNetAPI.h"
#import "MGADStrategy.h"
#import "NSObject+WHC_Model.h"
#import "MGAdController.h"
#import "MGADProtocol.h"
#import "MGADManager.h"

@import FBAudienceNetwork;
@import GoogleMobileAds;

@interface MGRewardedAd()<FBRewardedVideoAdDelegate,GADRewardedAdDelegate>

@property(nonatomic, strong) MGADStrategy       *adStrategy;

@property(nonatomic, strong) FBRewardedVideoAd  *fbrewardAd;

@property(nonatomic, strong) GADRewardedAd      *grewardedAd;

@property(nonatomic, assign) NSUInteger         index;

@property(nonatomic, assign) MGADPlat           platform;

@property(nonatomic, assign)BOOL                fbAdEnd;
@property(nonatomic, assign)BOOL                gAdEnd;

@property(nonatomic, assign) NSInteger           testType;



@end

@implementation MGRewardedAd

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

// 还原数据
- (void)resetData {
    self.index = -1;
    self.fbAdEnd = NO;
    self.gAdEnd = NO;
}

- (void)loadAd {
    //如果广告先前已经加载好了,又调用加载方法,忽略掉
    if(self.isAdValid) {
        //成功的回调
        if([self.delegate respondsToSelector:@selector(rewardedAdDidLoad:)]) {
           [self.delegate rewardedAdDidLoad:self];
        }
        return;
    }
    [self resetData];
    //换取真实id
    __weak typeof(self) weakSelf = self;
    NSDictionary *params = @{@"app_key":@"1",@"platform":@"2",@"ad_id":@"a12",@"ad_type":@"2"};
    [MGNetManager requestApi:MGAPI_Strategy method:WGHTTPMethod_GET params:params success:^(NSDictionary *data) {
        weakSelf.adStrategy = [MGADStrategy whc_ModelWithJson:data];
        if(weakSelf.adStrategy.status == 1) {
            [weakSelf changeStrategy];
            [weakSelf cachedAd];
        }else {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"新浪游戏后台无数据返回" forKey:NSLocalizedDescriptionKey];
            NSError *error = [NSError errorWithDomain:@"com.sina.game.ads.sdk" code:1000 userInfo:userInfo];
            [self adLoadError:error];
        }
    } fail:^(NSError *error) {
        weakSelf.adStrategy = nil;
        [self adLoadError:error];
    }];
}

- (void)changeStrategy {
    if(self.testType == 1)  {
        self.adStrategy.order = @[@"google"];
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
        if([self.delegate respondsToSelector:@selector(rewardedAd:didFailWithError:)]) {
            [self.delegate rewardedAd:self didFailWithError:error];
        }
    }
}

- (BOOL)isAdValid {
    if(self.platform == MGADPlat_Google) {
        return self.grewardedAd.isReady;
    }
    else if(self.platform == MGADPlat_Facebook) {
        return self.fbrewardAd.isAdValid;
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

//当前应该显示那个
- (void)showAdFromRootViewController:(UIViewController *)rootViewController {
    if(self.platform == MGADPlat_Facebook) {
        if (self.fbrewardAd && self.fbrewardAd.isAdValid) {
         [self.fbrewardAd showAdFromRootViewController:rootViewController];
        }
    }
    else if(self.platform == MGADPlat_Google) {
        if (self.grewardedAd.isReady) {
              [self.grewardedAd presentFromRootViewController:rootViewController delegate:self];
            } else {
              NSLog(@"Ad wasn't ready");
            }
    }
}


// 广告事件
// 广告加载完成
- (void)adDidLoad {
    if([self.delegate respondsToSelector:@selector(rewardedAdDidLoad:)]) {
       [self.delegate rewardedAdDidLoad:self];
    }
}

//广告加载失败
- (void)adLoadError:(NSError *)error {
    if([self.delegate respondsToSelector:@selector(rewardedAd:didFailWithError:)]) {
        [self.delegate rewardedAd:self didFailWithError:error];
    }
}


//广告已经被关闭
- (void)adDidClose {
    if([self.delegate respondsToSelector:@selector(rewardedAdDidClose:)]) {
        [self.delegate rewardedAdDidClose:self];
    }
}
// 广告被点击
- (void)adDidClick {
    if([self.delegate respondsToSelector:@selector(rewardedAdDidClick:)]) {
        [self.delegate rewardedAdDidClick:self];
    }
}

// 广告将要被展示或已经展示了
- (void)adShow {
    if([self.delegate respondsToSelector:@selector(rewardedAdPresentScreen:)]) {
        [self.delegate rewardedAdPresentScreen:self];
    }
}


// 用户获得了奖励
- (void)userReward {
    if([self.delegate respondsToSelector:@selector(rewardedAd:userDidEarnReward:)]) {
        [self.delegate rewardedAd:self userDidEarnReward:self.reward];
    }
}

# pragma mark - FaceBook Ads
- (void)cachedFacebookAd {
    self.fbrewardAd = [[FBRewardedVideoAd alloc] initWithPlacementID:self.adStrategy.facebook];
    self.fbrewardAd.delegate = self;
    [self.fbrewardAd loadAd];
}



#pragma mark -  Facebook Delegate

- (void)rewardedVideoAd:(FBRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error
{
    [self adLoadError:error];
}

- (void)rewardedVideoAdDidLoad:(FBRewardedVideoAd *)rewardedVideoAd
{
    [self adDidLoad];
}

- (void)rewardedVideoAdDidClick:(FBRewardedVideoAd *)rewardedVideoAd
{
    [self adDidClick];
}

- (void)rewardedVideoAdVideoComplete:(FBRewardedVideoAd *)rewardedVideoAd;
{
    [self userReward];
}

- (void)rewardedVideoAdDidClose:(FBRewardedVideoAd *)rewardedVideoAd
{
    self.fbrewardAd = nil;//解决Facebook的广告adVaid问题
    [self adDidClose];
}
        
        
- (void)rewardedVideoAdWillClose:(FBRewardedVideoAd *)rewardedVideoAd
{
  
}

- (void)rewardedVideoAdWillLogImpression:(FBRewardedVideoAd *)rewardedVideoAd
{
    [self adShow];
}

#pragma mark - google Ads

- (void)cachedGoogleAd {
    self.grewardedAd = [self createAndLoadRewardedAd];
}


- (GADRewardedAd *)createAndLoadRewardedAd {
  GADRewardedAd *rewardedAd = [[GADRewardedAd alloc]
      initWithAdUnitID:self.adStrategy.google];
  GADRequest *request = [GADRequest request];
  __weak typeof(self) weakSelf = self;
  [rewardedAd loadRequest:request completionHandler:^(GADRequestError * _Nullable error) {
    if (error) {
      [weakSelf adLoadError:error];
    } else {
        [weakSelf adDidLoad];
    }
  }];
  return rewardedAd;
}


#pragma mark - google delegate


/// Tells the delegate that the user earned a reward.
- (void)rewardedAd:(GADRewardedAd *)rewardedAd userDidEarnReward:(GADAdReward *)reward {
    [self userReward];
}

/// Tells the delegate that the rewarded ad was presented.
- (void)rewardedAdDidPresent:(GADRewardedAd *)rewardedAd {
    [self adShow];
}

/// Tells the delegate that the rewarded ad failed to present.
- (void)rewardedAd:(GADRewardedAd *)rewardedAd didFailToPresentWithError:(NSError *)error {
    [self adLoadError:error];
}

/// Tells the delegate that the rewarded ad was dismissed.
- (void)rewardedAdDidDismiss:(GADRewardedAd *)rewardedAd {
    [self adDidClose];
}



@end
