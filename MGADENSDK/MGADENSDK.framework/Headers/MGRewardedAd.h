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


// 广告是否有效
@property (nonatomic, getter=isAdValid, readonly) BOOL adValid;

// 广告id
@property (nonatomic, copy, readonly) NSString *adid;

// 奖励
@property (nonatomic, strong, readonly) MGAdReward    *reward;

- (instancetype)initWithAdid:(NSString *)adid;


- (void)loadAd;

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

/// 奖励广告被关闭
- (void)rewardedAdDidClose:(MGRewardedAd *)rewardAd;

/// 奖励广告被展示
- (void)rewardedAdPresentScreen:(MGRewardedAd *)rewardedAd;

/// 奖励广告展示失败
- (void)rewardedAd:(MGRewardedAd *)rewardedAd didFailToPresentWithError:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
