//
//  MGADManager.h
//  MGADENSDK
//
//  Created by Mr.Song on 2020/1/17.
//  Copyright © 2020 Mr.Song. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MGADManager : NSObject

@property(nonatomic, assign)NSInteger   testType;

+ (instancetype)manager;

- (void)initializeADSDK;

- (void)registSDKwithAppkey:(NSString *)appkey;

- (BOOL)isCachedInsertAD;

- (void)showInsertAD;

- (BOOL)isCachedRewardAD;

- (void)showRewardAD;

- (void)setTestType:(NSInteger)type;

@end

NS_ASSUME_NONNULL_END
