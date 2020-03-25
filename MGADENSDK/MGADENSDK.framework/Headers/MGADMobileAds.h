//
//  MGADMobileAds.h
//  MGADENSDK
//
//  Created by Mr.Song on 2020/2/25.
//  Copyright © 2020 baixiaosheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface MGADMobileAds : NSObject

/// 测试设备
@property(nonatomic, copy, nullable) NSArray<NSString *> *testDeviceIdentifiers;

/// 是否接入新浪游戏的联运SDK
@property(nonatomic, assign) BOOL   existSinaUnionSDK;

/// 联运SDK登陆后的用户id
@property(nonatomic, copy, nullable) NSString   *userID;


+ (nonnull MGADMobileAds *)sharedInstance;

/// 开启广告SDK
- (void)startMobileAdsSDK;

@end

