//
//  MGRewardedAd.h
//  MGADENSDK
//
//  Created by Mr.Song on 2020/2/13.
//  Copyright © 2020 Mr.Song. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MGAdReward.h"


NS_ASSUME_NONNULL_BEGIN

@protocol MGRewardedAdDelegate;

@interface MGRewardedAd : NSObject

@property (nonatomic, weak, nullable) id<MGRewardedAdDelegate> delegate;


// 广告是否有效(是否加载完成)
@property (nonatomic, getter=isAdValid, readonly) BOOL adValid;

// 广告位id
@property (nonatomic, copy, readonly) NSString *adid;

// 奖励
@property (nonatomic, strong, readonly) MGAdReward    *reward;

/**
 初始化奖励广告

@param adid     广告位id
*/
- (instancetype)initWithAdid:(NSString *)adid;

/**
 广告名称
*/
@property (nonatomic, copy, readonly) NSString *adNetworkClassName;

/**
 初始化奖励广告并配置奖励类型和奖励金额

@param adid     广告位id
@param type     奖励类型
@param currency 奖励金额
*/
- (instancetype)initWithAdid:(NSString *)adid
                    withType:(nullable NSString *)type
                withCurrency:(nullable NSString *)currency;

/**
 加载奖励广告
*/
- (void)loadAd;

/**
 展示奖励广告

@param rootViewController     用于展示奖励广告的Controller
*/
- (void)showAdFromRootViewController:(UIViewController *)rootViewController;

@end

@protocol MGRewardedAdDelegate <NSObject>

@required

/// 用户获得了奖励
- (void)rewardedAd:(MGRewardedAd *)rewardedAd userDidEarnReward:(MGAdReward *)reward;

@optional

/// 奖励广告加载失败
- (void)rewardedAd:(MGRewardedAd *)rewardAd didFailWithError:(NSError *)error;

/// 奖励广告加载完成
- (void)rewardedAdDidLoad:(MGRewardedAd *)rewardAd;

/// 奖励广告被展示
- (void)rewardedAdPresentScreen:(MGRewardedAd *)rewardedAd;

/// 奖励广告展示失败
- (void)rewardedAd:(MGRewardedAd *)rewardedAd didFailToPresentWithError:(NSError *)error;

/// 奖励广告被关闭
- (void)rewardedAdDidClose:(MGRewardedAd *)rewardAd;


@end

NS_ASSUME_NONNULL_END
