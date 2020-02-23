//
//  MGGRewardAdController.h
//  MGADENSDK
//
//  Created by Mr.Song on 2020/1/20.
//  Copyright © 2020 Mr.Song. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGAdController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MGGRewardAdController : MGAdController

- (void) cacheADWithID:(NSString *)id;
- (void) showRewardedVideoAd;

@end

NS_ASSUME_NONNULL_END
