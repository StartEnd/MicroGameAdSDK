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

// 插页广告是否准备完成
@property (nonatomic, getter=isAdValid, readonly) BOOL adValid;

@property (nonatomic, copy, readonly) NSString *adid;


- (instancetype)initWithAdid:(NSString *)adid;

- (void)loadAd;

- (void)showAdFromRootViewController:(UIViewController *)rootViewController;


@end

@protocol MGInterstitialAdDelegate <NSObject>

@optional

// 插页广告加载成功
- (void)interstitialAdDidLoad:(MGInterstitialAd *)interstitialAd;

// 插页广告加载失败
- (void)interstitialAd:(MGInterstitialAd *)interstitialAd didFailWithError:(NSError *)error;

// 插页广告将要被关闭
- (void)interstitialAdWillClose:(MGInterstitialAd *)interstitialAd;

// 插页广告已经被关闭
- (void)interstitialAdDidClose:(MGInterstitialAd *)interstitialAd;

// 插页广告被点击
- (void)interstitialAdDidClick:(MGInterstitialAd *)interstitialAd;

// 插页广告被展示
- (void)interstitialPresentScreen:(MGInterstitialAd *)interstitialAd;

@end


NS_ASSUME_NONNULL_END
