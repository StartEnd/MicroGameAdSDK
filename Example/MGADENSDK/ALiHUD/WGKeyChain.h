//
//  WGKeyChain.h
//  MicroGame
//
//  Created by Mr.Song on 23/01/2018.
//  Copyright © 2018 WeiYouHuDong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGKeyChain : NSObject

+ (void)save:(NSString *)service data:(id)data;

+ (id)load:(NSString *)service;

+ (void)deleteKeyData:(NSString *)service;

@end
