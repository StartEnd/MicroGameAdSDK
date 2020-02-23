#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "MGAdController.h"
#import "MGADDefines.h"
#import "MGADENSDK.h"
#import "MGADHelper.h"
#import "MGADManager.h"
#import "MGADProtocol.h"
#import "MGAdReward.h"
#import "MGAdSize.h"
#import "MGADStrategy.h"
#import "MGBannerAdView.h"
#import "MGFBInsertAdController.h"
#import "MGFBRewardAdController.h"
#import "MGGInsertAdController.h"
#import "MGGRewardAdController.h"
#import "MGInterstitialAd.h"
#import "MGNetAPI.h"
#import "MGNetManager.h"
#import "MGRewardedAd.h"
#import "NSObject+WHC_Model.h"

FOUNDATION_EXPORT double MGADENSDKVersionNumber;
FOUNDATION_EXPORT const unsigned char MGADENSDKVersionString[];

