//
//  MGNetManager.h
//  OuterGameLib
//
//  Created by Mr.Song on 2018/6/11.
//  Copyright © 2018 WeiYouHuDong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CompletioBlock)(NSDictionary *dic, NSURLResponse *response, NSError *error);
typedef void (^SuccessBlock)(NSDictionary *data);
typedef void (^FailureBlock)(NSError *error);

//请求方法
typedef NS_ENUM(NSInteger,WGHTTPMethod) {
    WGHTTPMethod_GET,
    WGHTTPMethod_POST
};



@interface MGNetManager : NSObject

+ (void)requestApi:(NSString *)api
            method:(WGHTTPMethod)method
            params:(NSDictionary*)params
           success:(SuccessBlock)success
              fail:(FailureBlock)fail;



@end
