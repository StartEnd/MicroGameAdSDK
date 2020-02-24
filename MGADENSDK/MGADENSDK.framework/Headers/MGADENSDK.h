//
//  MGADENSDK.h
//  MGADENSDK
//
//  Created by Mr.Song on 2020/1/17.
//  Copyright © 2020 Mr.Song. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MGADENSDK/MGBannerAdView.h>
#import <MGADENSDK/MGInterstitialAd.h>
#import <MGADENSDK/MGRewardedAd.h>
#import <MGADENSDK/MGAdReward.h>

@interface MGADENSDK : NSObject

/// 注册应用
+ (void)registSDKwithAppkey:(NSString *)appkey;

///
+ (void)testDeviceIdentifiers:(NSArray *)identifiers;

// 测试类型
+ (void)setTestType:(NSInteger)type;



@end
