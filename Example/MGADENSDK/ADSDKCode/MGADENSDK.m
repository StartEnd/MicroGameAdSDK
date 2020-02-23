//
//  MGADENSDK.m
//  MGADENSDK
//
//  Created by Mr.Song on 2020/1/17.
//  Copyright © 2020 Mr.Song. All rights reserved.
//

#import "MGADENSDK.h"
#import "MGADManager.h"

@implementation MGADENSDK


+ (void)registSDKwithAppkey:(NSString *)appkey {
    [[MGADManager manager] registSDKwithAppkey:appkey];
}

+ (BOOL)isCachedInsertAD {
    return [[MGADManager manager] isCachedInsertAD];
}

+ (void)showInsertAD {
    [[MGADManager manager] showInsertAD];
}

+ (BOOL)isCachedRewardAD {
    return [[MGADManager manager] isCachedRewardAD];
}

+ (void)showRewardAD {
    [[MGADManager manager] showRewardAD];
}

+ (void)setTestType:(NSInteger)type {
    [[MGADManager manager] setTestType:type];
}

@end
