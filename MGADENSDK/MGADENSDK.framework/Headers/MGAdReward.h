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

/// 奖励类型
@property(nonatomic, readonly, nonnull) NSString *type;

/// 奖励金额
@property(nonatomic, readonly, nonnull) NSString *amount;


- (nonnull instancetype)initWithRewardType:(nonnull NSString *)rewardType
                              rewardAmount:(nonnull NSString *)rewardAmount;

@end

NS_ASSUME_NONNULL_END
