//
//  MGFBRewardAdController.h
//  WGADENSDK
//
//  Created by Mr.Song on 2020/1/15.
//  Copyright © 2020 Mr.Song. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGAdController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MGFBRewardAdController : MGAdController

- (void) cacheADWithID:(NSString *)id;
- (void) showRewardedVideoAd;

@end

NS_ASSUME_NONNULL_END
