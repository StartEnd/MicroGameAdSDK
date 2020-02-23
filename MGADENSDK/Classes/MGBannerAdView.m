//
//  MGBannerAdView.m
//  MGADENSDK
//
//  Created by Mr.Song on 2020/2/15.
//  Copyright © 2020 Mr.Song. All rights reserved.
//

#import "MGBannerAdView.h"
#import "MGADStrategy.h"
#import "MGNetManager.h"
#import "NSObject+WHC_Model.h"
#import "MGNetAPI.h"
#import "MGADProtocol.h"
#import "MGADManager.h"

@import FBAudienceNetwork;
@import GoogleMobileAds;

@interface MGBannerAdView()<FBAdViewDelegate,GADBannerViewDelegate>

@property (nonatomic, strong) FBAdView          *fbAdView;
@property(nonatomic, strong) GADBannerView      *gAdView;
@property(nonatomic, strong) MGADStrategy       *adStrategy;

@property(nonatomic, assign) NSUInteger         index;
@property(nonatomic, assign) MGADPlat           platform;
@property(nonatomic, assign)MGBannerType        bannerType;

@property(nonatomic, assign) NSInteger           testType;


@end

@implementation MGBannerAdView

- (NSInteger)testType {
    return [[MGADManager manager] testType];
}

- (instancetype)initWithAdid:(NSString *)adid bannerType:(MGBannerType)bannerType rootViewController:(UIViewController *)rootViewController{
    if(self = [super init]) {
        _bannerType = bannerType;
        _adid = adid;
        _rootViewController = rootViewController;
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.backgroundColor = [UIColor clearColor];
}

- (void)resetData {
    self.index = -1;
    [self.fbAdView removeFromSuperview];
    [self.gAdView removeFromSuperview];
}

- (void)loadAd {
    [self resetData];
    //换取真实id
       __weak typeof(self) weakSelf = self;
       NSDictionary *params = @{@"app_key":@"1",@"platform":@"2",@"ad_id":@"a12",@"ad_type":@"1"};
       [MGNetManager requestApi:MGAPI_Strategy method:WGHTTPMethod_GET params:params success:^(NSDictionary *data) {
           weakSelf.adStrategy = [MGADStrategy whc_ModelWithJson:data];
           if(weakSelf.adStrategy.status == 1) {
               [weakSelf changeStrategy];
               [weakSelf cachedAd];
           }else {
               NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"新浪游戏后台无数据返回" forKey:NSLocalizedDescriptionKey];
               NSError *error = [NSError errorWithDomain:@"com.sina.game.ads.sdk" code:1000 userInfo:userInfo];
               [self.delegate bannerAdView:self didFailWithError:error];
           }
       } fail:^(NSError *error) {
           weakSelf.adStrategy = nil;
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
        if([self.delegate respondsToSelector:@selector(interstitialAd:didFailWithError:)]) {
            [self.delegate bannerAdView:self didFailWithError:error];
        }
    }
}

- (void)cachedGoogleAd {
    self.gAdView = [[GADBannerView alloc]
    initWithAdSize:[self googleAdSize]];
    self.gAdView.delegate = self;
    self.gAdView.adUnitID = self.adStrategy.google;
    self.gAdView.rootViewController = self.rootViewController;
    [self.gAdView loadRequest:[GADRequest request]];
}

- (void)cachedFacebookAd {
    self.fbAdView = [[FBAdView alloc] initWithPlacementID:self.adStrategy.facebook
                                                 adSize:[self facebookAdSize]
                                     rootViewController:self.rootViewController];
    self.fbAdView.delegate = self;
    [self.fbAdView loadAd];
}

- (GADAdSize)googleAdSize {
    switch (self.bannerType) {
        case MGBannerType_Standard:
            return kGADAdSizeBanner;
            break;
        case MGBannerType_Large:
            return kGADAdSizeLargeBanner;
            break;
        case MGBannerType_Rectangle:
            return kGADAdSizeMediumRectangle;
            break;
        default:
            break;
    }
}

- (FBAdSize)facebookAdSize {
    switch (self.bannerType) {
        case MGBannerType_Standard:
            return kFBAdSizeHeight50Banner;
            break;
        case MGBannerType_Large:
            return kFBAdSizeHeight90Banner;
            break;
        case MGBannerType_Rectangle:
            return kFBAdSizeHeight250Rectangle;
            break;
        default:
            break;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.fbAdView.frame = self.bounds;
    self.gAdView.frame = self.bounds;
}

- (CGSize)adSize {
    if(self.platform == MGADPlat_Google) {
        return self.gAdView.adSize.size;
    }else if(self.platform == MGADPlat_Facebook) {
        return [self currentFacebookAdSize];
    }else {
        return CGSizeZero;
    }
}

- (CGSize)currentFacebookAdSize {
    if(self.bannerType == MGBannerType_Standard) {
        return CGSizeMake(320, 50);
    }else if(self.bannerType == MGBannerType_Large) {
        return CGSizeMake(320, 90);
    }else if(self.bannerType == MGBannerType_Rectangle) {
        return CGSizeMake(320, 250);
    }else {
        return CGSizeZero;
    }
}

#pragma mark -  Facebook Delegate

- (void)adViewDidClick:(FBAdView *)adView
{
    NSLog(@"Banner ad was clicked.");
}

- (void)adViewDidFinishHandlingClick:(FBAdView *)adView
{
    NSLog(@"Banner ad did finish click handling.");
}

- (void)adViewWillLogImpression:(FBAdView *)adView
{
    NSLog(@"Banner ad impression is being captured.");
}

- (void)adView:(FBAdView *)adView didFailWithError:(NSError *)error
{
    [self cachedAd];
}

- (void)adViewDidLoad:(FBAdView *)adView
{
    [self showFacebookBanner];
   if([self.delegate respondsToSelector:@selector(bannerAdViewDidLoad:)]) {
       [self.delegate bannerAdViewDidLoad:self];
   }
}

- (void)showGoogleBanner
{
    [self addSubview:self.gAdView];
}

- (void)showFacebookBanner {
    if (self.fbAdView && self.fbAdView.isAdValid) {
      [self addSubview:self.fbAdView];
    }
}


#pragma mark - google delegate

/// Tells the delegate an ad request loaded an ad.
- (void)adViewDidReceiveAd:(GADBannerView *)adView {
    [self showGoogleBanner];
    if([self.delegate respondsToSelector:@selector(bannerAdViewDidLoad:)]) {
        [self.delegate bannerAdViewDidLoad:self];
    }
  NSLog(@"adViewDidReceiveAd");
}

/// Tells the delegate an ad request failed.
- (void)adView:(GADBannerView *)adView
    didFailToReceiveAdWithError:(GADRequestError *)error {
    [self cachedAd];
}

/// Tells the delegate that a full-screen view will be presented in response
/// to the user clicking on an ad.
- (void)adViewWillPresentScreen:(GADBannerView *)adView {
  NSLog(@"adViewWillPresentScreen");
}

/// Tells the delegate that the full-screen view will be dismissed.
- (void)adViewWillDismissScreen:(GADBannerView *)adView {
  NSLog(@"adViewWillDismissScreen");
}

/// Tells the delegate that the full-screen view has been dismissed.
- (void)adViewDidDismissScreen:(GADBannerView *)adView {
  NSLog(@"adViewDidDismissScreen");
}

/// Tells the delegate that a user click will open another app (such as
/// the App Store), backgrounding the current app.
- (void)adViewWillLeaveApplication:(GADBannerView *)adView {
  NSLog(@"adViewWillLeaveApplication");
}

@end
