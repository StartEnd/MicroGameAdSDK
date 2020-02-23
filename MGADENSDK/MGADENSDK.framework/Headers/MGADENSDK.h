//
//  MGADENSDK.h
//  MGADENSDK
//
//  Created by Mr.Song on 2020/1/17.
//  Copyright © 2020 Mr.Song. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGADENSDK : NSObject

+ (void)registSDKwithAppkey:(NSString *)appkey;

// 测试类型
+ (void)setTestType:(NSInteger)type;

// 缓存插页广告
+ (void) loadInsertAD:(NSString *)adid;

// 是否缓存好了插页广告
+ (BOOL) isCachedInsertAD;

// 展示插页广告
+ (void) showInsertAD;



// 是否缓存好了奖励广告
+ (BOOL)isCachedRewardAD;

// 展示奖励广告
+ (void)showRewardAD;


@end
