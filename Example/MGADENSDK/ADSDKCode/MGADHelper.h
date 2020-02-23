//
//  MGADHelper.h
//  MGADENSDK
//
//  Created by Mr.Song on 2020/1/20.
//  Copyright © 2020 Mr.Song. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MGADHelper : NSObject

+ (UIViewController*) topMostController;
+ (NSString *)signWithParams:(NSDictionary *)params;

+ (NSDictionary *)generalArguments;

@end

NS_ASSUME_NONNULL_END
