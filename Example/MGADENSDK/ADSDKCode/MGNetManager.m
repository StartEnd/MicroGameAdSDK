//
//  MGNetManager.m
//  OuterGameLib
//
//  Created by Mr.Song on 2018/6/11.
//  Copyright © 2018 WeiYouHuDong. All rights reserved.
//

#import "MGNetManager.h"
#import "MGADHelper.h"

//定义一个变量
static MGNetManager *helper = nil;

@interface MGNetManager()


@end

@implementation MGNetManager

//实例化对象
+ (instancetype)shareHelper
{
    @synchronized(self) {
        if (!helper) {
            helper = [[MGNetManager alloc] init];
        }
        return helper;
    }
}

+ (void)requestApi:(NSString *)api
            method:(WGHTTPMethod)method
            params:(NSDictionary*)params
           success:(SuccessBlock)success
              fail:(FailureBlock)fail {
    
    // 添加固定参数
    NSMutableDictionary *mudic = [NSMutableDictionary dictionaryWithDictionary:params];
    NSDictionary *defaultDic = [MGADHelper generalArguments];
    [mudic addEntriesFromDictionary:defaultDic];
    // 添加签名
    NSString *sign = [MGADHelper signWithParams:mudic];
    mudic[@"sign"] = sign;
    if(method == WGHTTPMethod_GET) {
        [self getWithUrlString:api parameters:mudic success:success failure:fail];
    }else {
        [self postWithUrlString:api parameters:mudic success:success failure:fail];
    }
}

//get请求
+ (void)getWithUrlString:(NSString *)url parameters:(id)parameters success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    NSMutableString *mutableUrl = [[NSMutableString alloc] initWithString:url];
    if ([parameters allKeys]) {
        [mutableUrl appendString:@"?"];
        for (id key in parameters) {
//            NSString *value = [[parameters objectForKey:key] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            NSString *value = [[parameters objectForKey:key] stringByAddingPercentEncodingWithAllowedCharacters:
            [NSCharacterSet characterSetWithCharactersInString:@"#%<>[\\]^`{|}\"]+"].invertedSet];
            [mutableUrl appendString:[NSString stringWithFormat:@"%@=%@&", key, value]];
        }
    }
    NSString *urlEnCode = [[mutableUrl substringToIndex:mutableUrl.length - 1] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlEnCode]];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.timeoutIntervalForRequest = 30.0;
    config.timeoutIntervalForResource = 60.0;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:[self shareHelper] delegateQueue:queue];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            failureBlock(error);
        } else {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            successBlock(dic);
        }
    }];
    [dataTask resume];
}

//post请求
+ (void)postWithUrlString:(NSString *)url parameters:(id)parameters success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    NSURL *nsurl = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:nsurl];
    //设置请求方式
    request.HTTPMethod = @"POST";
    NSString *postStr = [MGNetManager parseParams:parameters];
    //设置请求体
    request.HTTPBody = [postStr dataUsingEncoding:NSUTF8StringEncoding];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.timeoutIntervalForRequest = 30.0;
    config.timeoutIntervalForResource = 60.0;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:[self shareHelper] delegateQueue:queue];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            failureBlock(error);
        } else {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            successBlock(dic);
        }
    }];
    [dataTask resume];
}

//把NSDictionary解析成post格式的NSString字符串
+ (NSString *)parseParams:(NSDictionary *)params
{
    NSString *keyValueFormat;
    NSMutableString *result = [NSMutableString new];
    NSMutableArray *array = [NSMutableArray new];
    //实例化一个key枚举器用来存放dictionary的key
    NSEnumerator *keyEnum = [params keyEnumerator];
    id key;
    while (key = [keyEnum nextObject]) {
        NSString *value = [[params valueForKey:key] stringByAddingPercentEncodingWithAllowedCharacters:
        [NSCharacterSet characterSetWithCharactersInString:@"#%<>[\\]^`{|}\"]+"].invertedSet];
        keyValueFormat = [NSString stringWithFormat:@"%@=%@&", key, value];
        [result appendString:keyValueFormat];
        [array addObject:keyValueFormat];
    }
    return result;
}

#pragma mark - NSURLSessionDelegate 代理方法

//主要就是处理HTTPS请求的
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler
{
    NSURLProtectionSpace *protectionSpace = challenge.protectionSpace;
    if ([protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        SecTrustRef serverTrust = protectionSpace.serverTrust;
        completionHandler(NSURLSessionAuthChallengeUseCredential, [NSURLCredential credentialForTrust:serverTrust]);
    } else {
        completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
    }
}

@end

