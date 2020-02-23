//
//  MGAdReward.m
//  MGADENSDK
//
//  Created by Mr.Song on 2020/2/19.
//  Copyright © 2020 Mr.Song. All rights reserved.
//

#import "MGAdReward.h"

@implementation MGAdReward

- (nonnull instancetype)initWithRewardType:(nonnull NSString *)rewardType
                              rewardAmount:(nonnull NSDecimalNumber *)rewardAmount {
    if(self = [super init]) {
        _type = rewardType;
        _amount = rewardAmount;
    }
    return self;
}

@end
