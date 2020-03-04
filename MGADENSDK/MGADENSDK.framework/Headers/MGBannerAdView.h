//
//  MGADBannerView.h
//  MGADENSDK
//
//  Created by Mr.Song on 2020/2/15.
//  Copyright © 2020 Mr.Song. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MGBannerAdViewDelegate;

NS_ASSUME_NONNULL_BEGIN

// Banner类型
typedef NS_ENUM (NSInteger,MGBannerType) {
    MGBannerType_Standard = 0,      //标准横幅,高度50像素,
    MGBannerType_Large = 1,         //大型横幅,高度90像素或者100像素
    MGBannerType_Rectangle = 2      //中型矩形,高度250像素
};

@interface MGBannerAdView : UIView

/**
 广告位ID
*/
@property (nonatomic, copy, readonly) NSString *adid;

/**
 横幅广告尺寸
*/
@property (nonatomic, assign, readonly)CGSize   adSize;
@property (nonatomic, weak, readonly, nullable) UIViewController *rootViewController;

@property (nonatomic, weak, nullable) id<MGBannerAdViewDelegate> delegate;

/**
 广告名称
*/
@property (nonatomic, copy, readonly) NSString *adNetworkClassName;

/**
 初始化横幅广告

@param adid                     广告位id
@param bannerType               加载的横幅广告类型
@param rootViewController       用于展示横幅广告的根控制器
*/
- (instancetype)initWithAdid:(NSString *)adid
                  bannerType:(MGBannerType)bannerType
          rootViewController:(UIViewController *)rootViewController;

/**
 加载横幅广告
*/
- (void)loadAd;

@end

@protocol MGBannerAdViewDelegate <NSObject>

@optional

/// 横幅广告加载完成(广告每次自动刷新都会调用一次)
- (void)bannerAdViewDidLoad:(MGBannerAdView *)bannerAdView;

/// 横幅广告加载失败
- (void)bannerAdView:(MGBannerAdView *)bannerAdView didFailWithError:(NSError *)error;

/// 横幅广告被展示
- (void)bannerAdViewPresentScreen:(MGBannerAdView *)bannerAdView;

/// 横幅广告被点击
- (void)bannerAdViewDidClick:(MGBannerAdView *)bannerAdView;



@end


NS_ASSUME_NONNULL_END
