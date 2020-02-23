//
//  MGGInsertAdController.m
//  MGADENSDK
//
//  Created by Mr.Song on 2020/1/21.
//  Copyright © 2020 Mr.Song. All rights reserved.
//

#import "MGGInsertAdController.h"
#import "MGADHelper.h"
@import GoogleMobileAds;
@import UIKit;


@interface MGGInsertAdController()<GADInterstitialDelegate>

@property(nonatomic, strong) GADInterstitial *interstitial;

@property(nonatomic, strong) NSString       *adid;

@end

@implementation MGGInsertAdController


- (void)cacheADWithID:(NSString *)id {
    self.adid = id;
    self.interstitial = [self createAndLoadInterstitial];
}

- (void) showRewardedVideoAd  {
    if (self.interstitial.isReady) {
      [self.interstitial presentFromRootViewController:[MGADHelper topMostController]];
    } else {
      NSLog(@"Ad wasn't ready");
    }
}


- (GADInterstitial *)createAndLoadInterstitial {
  GADInterstitial *interstitial =
      [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-3940256099942544/4411468910"];
  interstitial.delegate = self;
  [interstitial loadRequest:[GADRequest request]];
  return interstitial;
}

/// Tells the delegate an ad request succeeded.
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
  NSLog(@"interstitialDidReceiveAd");
}

/// Tells the delegate an ad request failed.
- (void)interstitial:(GADInterstitial *)ad
    didFailToReceiveAdWithError:(GADRequestError *)error {
  NSLog(@"interstitial:didFailToReceiveAdWithError: %@", [error localizedDescription]);
}

/// Tells the delegate that an interstitial will be presented.
- (void)interstitialWillPresentScreen:(GADInterstitial *)ad {
  NSLog(@"interstitialWillPresentScreen");
}

/// Tells the delegate the interstitial is to be animated off the screen.
- (void)interstitialWillDismissScreen:(GADInterstitial *)ad {
  NSLog(@"interstitialWillDismissScreen");
}

/// Tells the delegate the interstitial had been animated off the screen.
- (void)interstitialDidDismissScreen:(GADInterstitial *)ad {
  NSLog(@"interstitialDidDismissScreen");
  self.interstitial = [self createAndLoadInterstitial];
}

/// Tells the delegate that a user click will open another app
/// (such as the App Store), backgrounding the current app.
- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad {
  NSLog(@"interstitialWillLeaveApplication");
}

@end
