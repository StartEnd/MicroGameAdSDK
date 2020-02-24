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

@property (nonatomic, copy, readonly) NSString *adid;
@property (nonatomic, assign, readonly)CGSize   adSize;
@property (nonatomic, weak, readonly, nullable) UIViewController *rootViewController;

@property (nonatomic, weak, nullable) id<MGBannerAdViewDelegate> delegate;

- (instancetype)initWithAdid:(NSString *)adid bannerType:(MGBannerType)bannerType rootViewController:(UIViewController *)rootViewController;

- (void)loadAd;

@end

@protocol MGBannerAdViewDelegate <NSObject>

- (void)bannerAdViewDidLoad:(MGBannerAdView *)adView;
- (void)bannerAdView:(MGBannerAdView *)adView didFailWithError:(NSError *)error;

@optional


@end


NS_ASSUME_NONNULL_END
