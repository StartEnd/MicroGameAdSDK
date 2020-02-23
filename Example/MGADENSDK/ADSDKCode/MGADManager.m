//
//  MGADManager.m
//  MGADENSDK
//
//  Created by Mr.Song on 2020/1/17.
//  Copyright © 2020 Mr.Song. All rights reserved.
//

#import "MGADManager.h"
#import "MGFBRewardAdController.h"
#import "MGGRewardAdController.h"
#import "MGFBInsertAdController.h"
#import "MGGInsertAdController.h"
@import GoogleMobileAds;

@interface MGADManager()

@property(nonatomic, strong) MGFBRewardAdController     *fbRewardAD;
@property(nonatomic, strong) MGGRewardAdController      *gRewardAD;

@property(nonatomic, strong) MGFBInsertAdController     *fbIntertAD;
@property(nonatomic, strong) MGGInsertAdController      *gIntertAD;



@end

@implementation MGADManager

+ (instancetype)manager {
    static MGADManager *sharedSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^(void) {
        sharedSingleton = [[self alloc] init];
        [sharedSingleton initialize];
    });
    return sharedSingleton;
}

- (void)initialize {
    
}

- (void)setTestType:(NSInteger)type {
    _testType = type;
}

- (void)registSDKwithAppkey:(NSString *)appkey {
    [[GADMobileAds sharedInstance] startWithCompletionHandler:nil];
    GADMobileAds.sharedInstance.requestConfiguration.testDeviceIdentifiers = @[ @"5200c38fff8f46832d68361131817567",@"0e45f3d354beae8d815223b75bffc9ab",kGADSimulatorID ];
    /*
    [[GADMobileAds sharedInstance] startWithCompletionHandler:nil];
    self.gRewardAD = [[MGGRewardAdController alloc] init];
    [self.gRewardAD cacheADWithID:@""];
    
   self.fbRewardAD =  [[MGFBRewardAdController alloc] init];
   [self.fbRewardAD cacheADWithID:appkey];
     */
}

- (BOOL)isCachedInsertAD {
    return YES;
}

- (void)showInsertAD {
   // [self.fbRewardAD showRewardedVideoAd];
    [self.gRewardAD showRewardedVideoAd];
}

- (BOOL)isCachedRewardAD {
    return YES;
}

- (void)showRewardAD {
    [self.gRewardAD showRewardedVideoAd];
}

@end
