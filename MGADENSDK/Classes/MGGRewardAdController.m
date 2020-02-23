//
//  MGGRewardAdController.m
//  MGADENSDK
//
//  Created by Mr.Song on 2020/1/20.
//  Copyright © 2020 Mr.Song. All rights reserved.
//

#import "MGGRewardAdController.h"
#import "MGADHelper.h"
@import GoogleMobileAds;
@import UIKit;


@interface MGGRewardAdController()<GADRewardedAdDelegate>

@property(nonatomic, strong) GADRewardedAd *rewardedAd;

@end

@implementation MGGRewardAdController

- (void)cacheADWithID:(NSString *)id {
    self.rewardedAd = [[GADRewardedAd alloc]
        initWithAdUnitID:@"ca-app-pub-3940256099942544/1712485313"];

    GADRequest *request = [GADRequest request];
    [self.rewardedAd loadRequest:request completionHandler:^(GADRequestError * _Nullable error) {
      if (error) {
        // Handle ad failed to load case.
      } else {
        // Ad successfully loaded.
      }
    }];
}

- (void) showRewardedVideoAd {
    if (self.rewardedAd.isReady) {
       [self.rewardedAd presentFromRootViewController:[MGADHelper topMostController] delegate:self];
     } else {
       NSLog(@"Ad wasn't ready");
     }
}

/// Tells the delegate that the user earned a reward.
- (void)rewardedAd:(GADRewardedAd *)rewardedAd userDidEarnReward:(GADAdReward *)reward {
  // TODO: Reward the user.
  NSLog(@"rewardedAd:userDidEarnReward:");
}

/// Tells the delegate that the rewarded ad was presented.
- (void)rewardedAdDidPresent:(GADRewardedAd *)rewardedAd {
  NSLog(@"rewardedAdDidPresent:");
}

/// Tells the delegate that the rewarded ad failed to present.
- (void)rewardedAd:(GADRewardedAd *)rewardedAd didFailToPresentWithError:(NSError *)error {
  NSLog(@"rewardedAd:didFailToPresentWithError");
}

/// Tells the delegate that the rewarded ad was dismissed.
- (void)rewardedAdDidDismiss:(GADRewardedAd *)rewardedAd {
  NSLog(@"rewardedAdDidDismiss:");
    self.rewardedAd = [self createAndLoadRewardedAd];
}

- (GADRewardedAd *)createAndLoadRewardedAd {
  GADRewardedAd *rewardedAd = [[GADRewardedAd alloc]
      initWithAdUnitID:@"ca-app-pub-3940256099942544/1712485313"];
  GADRequest *request = [GADRequest request];
  [rewardedAd loadRequest:request completionHandler:^(GADRequestError * _Nullable error) {
    if (error) {
      // Handle ad failed to load case.
    } else {
      // Ad successfully loaded.
    }
  }];
  return rewardedAd;
}

@end
