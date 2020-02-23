//
//  MGFBInsertAdController.m
//  MGADENSDK
//
//  Created by Mr.Song on 2020/1/21.
//  Copyright © 2020 Mr.Song. All rights reserved.
//

#import "MGFBInsertAdController.h"
#import <UIKit/UIKit.h>
#import "MGADHelper.h"
@import FBAudienceNetwork;

@interface MGFBInsertAdController()<FBInterstitialAdDelegate>

@property (nonatomic, strong) FBInterstitialAd *interstitialAd;
@property (nonatomic, strong) NSString          *adid;

@end

@implementation MGFBInsertAdController

- (void)cacheADWithID:(NSString *)id {
    self.adid = id;
    self.interstitialAd = [[FBInterstitialAd alloc] initWithPlacementID:@"YOUR_PLACEMENT_ID"];
    self.interstitialAd.delegate = self;
    // For auto play video ads, it's recommended to load the ad
    // at least 30 seconds before it is shown
    [self.interstitialAd loadAd];
}

- (void) showRewardedVideoAd  {
      if (self.interstitialAd && self.interstitialAd.isAdValid) {
      // You can now display the full screen ad using this code:
      [self.interstitialAd showAdFromRootViewController:[MGADHelper topMostController]];
    }
}

- (void)interstitialAdDidLoad:(FBInterstitialAd *)interstitialAd
{
  NSLog(@"Ad is loaded and ready to be displayed");

}

- (void)interstitialAdWillLogImpression:(FBInterstitialAd *)interstitialAd
{
  NSLog(@"The user sees the add");
  // Use this function as indication for a user's impression on the ad.
}

- (void)interstitialAdDidClick:(FBInterstitialAd *)interstitialAd
{
  NSLog(@"The user clicked on the ad and will be taken to its destination");
  // Use this function as indication for a user's click on the ad.
}

- (void)interstitialAdWillClose:(FBInterstitialAd *)interstitialAd
{
  NSLog(@"The user clicked on the close button, the ad is just about to close");
  // Consider to add code here to resume your app's flow
}

- (void)interstitialAdDidClose:(FBInterstitialAd *)interstitialAd
{
  NSLog(@"Interstitial had been closed");
  // Consider to add code here to resume your app's flow
}

- (void)interstitialAd:(FBInterstitialAd *)interstitialAd didFailWithError:(NSError *)error
{
  NSLog(@"Ad failed to load");
}

@end
