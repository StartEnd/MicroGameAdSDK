//
//  MGFBRewardAdController.m
//  WGADENSDK
//
//  Created by Mr.Song on 2020/1/15.
//  Copyright © 2020 Mr.Song. All rights reserved.
//

#import "MGFBRewardAdController.h"
#import "MGADHelper.h"
@import FBAudienceNetwork;

@interface MGFBRewardAdController ()<FBRewardedVideoAdDelegate>

@property (nonatomic, strong) FBRewardedVideoAd *rewardedVideoAd;

@end

@implementation MGFBRewardAdController


- (void)cacheADWithID:(NSString *)id {
    self.rewardedVideoAd = [[FBRewardedVideoAd alloc] initWithPlacementID:@"296238964649890_463764524563999"];
    self.rewardedVideoAd.delegate = self;
    [self.rewardedVideoAd loadAd];
}


- (void)rewardedVideoAd:(FBRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error
{
  NSLog(@"Rewarded video ad failed to load");
}

- (void)rewardedVideoAdDidLoad:(FBRewardedVideoAd *)rewardedVideoAd
{
  NSLog(@"Video ad is loaded and ready to be displayed");
}

- (void)rewardedVideoAdDidClick:(FBRewardedVideoAd *)rewardedVideoAd
{
  NSLog(@"Video ad clicked");
}

- (void)rewardedVideoAdVideoComplete:(FBRewardedVideoAd *)rewardedVideoAd;
{
  NSLog(@"Rewarded Video ad video complete - this is called after a full video view, before the ad end card is shown. You can use this event to initialize your reward");
}

- (void)rewardedVideoAdDidClose:(FBRewardedVideoAd *)rewardedVideoAd
{
  NSLog(@"Rewarded Video ad closed - this can be triggered by closing the application, or closing the video end card");
}
        
- (void) showRewardedVideoAd
{
  if (self.rewardedVideoAd && self.rewardedVideoAd.isAdValid) {
    [self.rewardedVideoAd showAdFromRootViewController:[MGADHelper  topMostController]];
  }
}
        
- (void)rewardedVideoAdWillClose:(FBRewardedVideoAd *)rewardedVideoAd
{
  NSLog(@"The user clicked on the close button, the ad is just about to close");
}

- (void)rewardedVideoAdWillLogImpression:(FBRewardedVideoAd *)rewardedVideoAd
{
  NSLog(@"Rewarded Video impression is being captured");
}

@end
