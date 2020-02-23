//
//  MGAdReward.h
//  MGADENSDK
//
//  Created by Mr.Song on 2020/2/19.
//  Copyright © 2020 Mr.Song. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MGAdReward : NSObject

/// Type of the reward.
@property(nonatomic, readonly, nonnull) NSString *type;

/// Amount rewarded to the user.
@property(nonatomic, readonly, nonnull) NSDecimalNumber *amount;

/// Returns an initialized MGAdReward with the provided reward type and reward amount.
- (nonnull instancetype)initWithRewardType:(nonnull NSString *)rewardType
                              rewardAmount:(nonnull NSDecimalNumber *)rewardAmount;

@end

NS_ASSUME_NONNULL_END
