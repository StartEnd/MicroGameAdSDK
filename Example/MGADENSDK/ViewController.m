//
//  ViewController.m
//  WGADSDKDemo
//
//  Created by Mr.Song on 2020/1/15.
//  Copyright © 2020 Mr.Song. All rights reserved.
//

#import "ViewController.h"
#import <AdSupport/AdSupport.h>
#import "MGADENSDK.h"
#import "MGRewardedAd.h"
#import "MGInterstitialAd.h"
#import "NSObject+ALiHUD.h"
#import "MGBannerAdView.h"
#import "WGKeyChain.h"
#import "InsertViewController.h"
#import "RewardViewController.h"
#import "BannerViewController.h"
@import GoogleMobileAdsMediationTestSuite;


@interface ViewController ()<MGRewardedAdDelegate,MGInterstitialAdDelegate,MGBannerAdViewDelegate>

@property(nonatomic, strong) MGRewardedAd       *rewardedAd;
@property(nonatomic, strong) MGInterstitialAd   *interstitialAd;
@property(nonatomic, strong) MGBannerAdView     *bannerView;

@property (weak, nonatomic) IBOutlet UITextField *appidTxt;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *appid = [WGKeyChain load:@"appid"];
    if(appid) {
        self.appidTxt.text = appid;
    }
}

- (IBAction)regesitApp:(id)sender {
    if(self.appidTxt.text.length > 0) {
        [MGADENSDK registSDKwithAppkey:self.appidTxt.text];
        [WGKeyChain save:@"appid" data:self.appidTxt.text];
    }
    
}

- (IBAction)getIDFA:(id)sender {
    Boolean on = [[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled];
    if(on) {
        NSString
        *adid = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        if(adid) {
            UIPasteboard *pboard = [UIPasteboard generalPasteboard];
            pboard.string = adid;
            [self showSuccessText:@"成功获取idfa,并复制到了剪切板"];
        }else {
            [self showErrorText:@"未获取到idfa"];
        }
    } else {
        [self showErrorText:@"用户禁用了idfa"];
    }
}

//测试中介
- (IBAction)testMediation:(id)sender {
    NSString *appID = @"ca-app-pub-4467542253883619~9687949222";
    [GoogleMobileAdsMediationTestSuite presentWithAppID:appID onViewController:self delegate:nil];
}


- (IBAction)testRewardedAd:(id)sender {
   // modalPresentationStyle
}

- (IBAction)testBannerAd:(id)sender {
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)testType:(UISegmentedControl *)sender {
    NSInteger type = sender.selectedSegmentIndex;
    [MGADENSDK setTestType:type];
}



//加载插屏广告
- (IBAction)loadInsetAD:(id)sender {
    self.interstitialAd = [[MGInterstitialAd alloc] initWithAdid:@"11"];
    self.interstitialAd.delegate = self;
    [self.interstitialAd loadAd];
}


//展示插屏广告
- (IBAction)showInsetAD:(id)sender {
    [self.interstitialAd showAdFromRootViewController:self];
}

//加载奖励广告
- (IBAction)loadRewardAD:(id)sender {
    self.rewardedAd = [[MGRewardedAd alloc] initWithAdid:@"12345"];
    self.rewardedAd.delegate = self;
    [self.rewardedAd loadAd];
}

//展示奖励广告
- (IBAction)showRewardAD:(id)sender {
    
    [self.rewardedAd showAdFromRootViewController:self];
}

- (void)rewardedAd:(MGRewardedAd *)rewardAd didFailWithError:(NSError *)error {
    [self showErrorText:@"加载奖惩广告失败"];
}

- (void)rewardedAdDidLoad:(MGRewardedAd *)rewardAd {
    [self showSuccessText:@"加载奖励广告成功"];
}

- (void)rewardedAdDidClose:(MGRewardedAd *)rewardAd {

}

- (void)interstitialAd:(MGInterstitialAd *)rewardAd didFailWithError:(NSError *)error {
    [self showErrorText:@"加载插页广告失败"];
}

- (void)interstitialAdDidLoad:(MGInterstitialAd *)rewardAd {
   // [self showSuccessText:@"加载插页广告成功"];
    [self showInsetAD:nil];
}

- (void)interstitialAdDidClose:(MGInterstitialAd *)rewardAd {
    [self showSuccessText:@"关闭了插页广告"];
}

//展示横幅广告
- (IBAction)showBannerAD:(UIButton *)sender {
    if(self.bannerView) {
        [self.bannerView removeFromSuperview];
    }
    NSInteger tag = sender.tag;
    if(tag == 0) {
        self.bannerView = [[MGBannerAdView alloc] initWithAdid:@"11" bannerType:MGBannerType_Standard rootViewController:self];
    } else if(tag == 1) {
        self.bannerView = [[MGBannerAdView alloc] initWithAdid:@"11" bannerType:MGBannerType_Large rootViewController:self];
    }else {
        self.bannerView = [[MGBannerAdView alloc] initWithAdid:@"11" bannerType:MGBannerType_Rectangle rootViewController:self];
    }
    self.bannerView.delegate = self;
    [self.bannerView loadAd];
    
}

- (void)bannerAdViewDidLoad:(MGBannerAdView *)adView {
   [self showSuccessText:@"加载横幅广告成功"];
    
}

- (void)bannerAdView:(MGBannerAdView *)adView didFailWithError:(NSError *)error {
    [self showSuccessText:@"加载横幅广告失败"];
}

- (IBAction)showBanner:(id)sender {
    CGFloat kSWidth = [UIScreen mainScreen].bounds.size.width;
    CGSize bannerSize = self.bannerView.adSize;
    self.bannerView.frame = CGRectMake((kSWidth - bannerSize.width) / 2,100, bannerSize.width, bannerSize.height);
    [self.view addSubview:self.bannerView];
}

//销毁横幅广告
- (IBAction)destroyBannerAD:(id)sender {
    [self.bannerView removeFromSuperview];
}



@end
