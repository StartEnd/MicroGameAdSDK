//
//  MGADHelper.m
//  MGADENSDK
//
//  Created by Mr.Song on 2020/1/20.
//  Copyright © 2020 Mr.Song. All rights reserved.
//

#import "MGADHelper.h"
#import<CommonCrypto/CommonDigest.h>

@implementation MGADHelper

//获取当前屏幕显示的viewcontroller
+ (UIViewController*) topMostController
{
    UIWindow *mainWindow = nil;
    if ( @available(iOS 13.0, *) ) {
       mainWindow = [UIApplication sharedApplication].windows.firstObject;
    } else {
        mainWindow = [UIApplication sharedApplication].keyWindow;
    }
    
    UIViewController *topController = mainWindow.rootViewController;

    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }

    return topController;
}

+ (NSString *)signWithParams:(NSDictionary *)params {
    NSString *paraStr = [self ustringLogQuery:params];
    NSString *newpara = [paraStr stringByAppendingString:@"&0226cb9301bcsdffgh34f22ec3d0d815c"];
    return [self md5:newpara];
}

// 通用参数
+ (NSDictionary *)generalArguments {
    NSMutableDictionary *mudic = [NSMutableDictionary dictionary];
    [mudic setObject:[self currentTime] forKey:@"t"];

    return mudic;
}

+(NSString *)ustringLogQuery:(NSDictionary *)query
{
    NSMutableArray* pairs = [NSMutableArray array];
    
    for (int i = 0;i<[query count];i++) {
        NSArray *keys = [[query allKeys] sortedArrayUsingSelector:@selector(compare:)];
        NSString *key = [keys objectAtIndex:i];
        id aValue = [query objectForKey:key];
        NSString *value = nil;
       if (![aValue isKindOfClass:[NSString class]]) {
           
           value = [aValue description];
       } else {
           value = aValue;
       }
        NSString* pair = [NSString stringWithFormat:@"%@=%@", key, value];
        [pairs addObject:pair];
    }
    return  [pairs componentsJoinedByString:@"&"];
}

+ (NSString *) md5:(NSString *) input
{
 const char *cStr = [input UTF8String];
 unsigned char digest[16];
 CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );

 NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];

 for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
 [output appendFormat:@"%02x", digest[i]];

 return  output;

}

+ (NSString *)currentTimeStr{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970];// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}

     
+ (NSString *)currentTime{
     NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
     NSTimeInterval time=[date timeIntervalSince1970] *1000;// 是精确到毫秒，不乘就是精确到秒
     NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
     return timeString;
}



@end
