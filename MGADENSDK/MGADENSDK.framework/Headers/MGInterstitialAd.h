//
//  MGInterstitialAd.h
//  MGADENSDK
//
//  Created by Mr.Song on 2020/2/13.
//  Copyright © 2020 Mr.Song. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MGInterstitialAdDelegate;

@interface MGInterstitialAd : NSObject

@property (nonatomic, weak, nullable) id<MGInterstitialAdDelegate> delegate;

/**
 当前广告是否有效
*/
@property (nonatomic, getter=isAdValid, readonly) BOOL adValid;

/**
 广告位ID
*/
@property (nonatomic, copy, readonly) NSString *adid;

/**
 广告名称
*/
@property (nonatomic, copy, readonly) NSString *adNetworkClassName;

/**
 初始化插页式广告

@param adid     广告位id
*/
- (instancetype)initWithAdid:(NSString *)adid;

/**
 加载插页式广告
*/
- (void)loadAd;

/**
 展示插页式广告

@param rootViewController     用于展示奖励广告的控制器
*/
- (void)showAdFromRootViewController:(UIViewController *)rootViewController;


@end

@protocol MGInterstitialAdDelegate <NSObject>

@optional

/// 插页广告加载成功
- (void)interstitialAdDidLoad:(MGInterstitialAd *)interstitialAd;

/// 插页广告加载失败
- (void)interstitialAd:(MGInterstitialAd *)interstitialAd didFailWithError:(NSError *)error;

/// 插页广告被展示
- (void)interstitialPresentScreen:(MGInterstitialAd *)interstitialAd;

/// 插页广告被关闭
- (void)interstitialAdDidClose:(MGInterstitialAd *)interstitialAd;

/// 插页广告被点击
- (void)interstitialAdDidClick:(MGInterstitialAd *)interstitialAd;


@end


NS_ASSUME_NONNULL_END
