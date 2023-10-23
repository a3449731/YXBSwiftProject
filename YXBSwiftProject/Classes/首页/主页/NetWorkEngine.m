//
//  NetWorkEngine.m
//  MVC
//
//  Created by Seven on 15/8/5.
//  Copyright (c) 2015年 Seven. All rights reserved.
//

#import "NetWorkEngine.h"
#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking-umbrella.h>
//#import <AdSupport/AdSupport.h>
//#import <CoreTelephony/CTTelephonyNetworkInfo.h>
//#import <CoreTelephony/CTCarrier.h>
//#import <PPNetworkHelper.h>
#import <MJExtension/MJExtension.h>
#import "IPNRSAUtil.h"

//输出
#ifdef DEBUG
# define YTLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#endif

#define RSAPublicKey @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCrj2AgOYTsIZyOwK5VusYe3AKiz0XFf5D0smWfKZGylOsnGC/L8R/S2Q/qSwevZAQQOlqLY+Si+6ekHnp+1pARwZ31TpHqWMC4Zrd+kIRwfO9vZtoQufnxZJEVLBa+omovaUrK8j1nWfdYO7gSfi5uQ3hvyS6R8n5NMOfp+aecxwIDAQAB"

#define RSAPrivateKey @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAKuPYCA5hOwhnI7ArlW6xh7cAqLPRcV/kPSyZZ8pkbKU6ycYL8vxH9LZD+pLB69kBBA6Wotj5KL7p6Qeen7WkBHBnfVOkepYwLhmt36QhHB8729m2hC5+fFkkRUsFr6iai9pSsryPWdZ91g7uBJ+Lm5DeG/JLpHyfk0w5+n5p5zHAgMBAAECgYEAhfK2ydI/DyKbGvYj57mhcHy07itJPY+BPRyArYmGQVl2VJrUzrXf8/8YJwUX5gAAEC+PfF+tJve3hzNoztl1t6uNV5z4mniiJj4vX7l+y8R4gEE35ktBV8WWpQ8ffu66rSPv4IPErIAehWKvw4JlYszR4yfbI/Gn2y7c98OvPRkCQQD3urKjWM1UDiTQBny97OMOL66UvHl/BU8+/qn7fuJWPDOjdPnB0vVm7mPFNLgsSF+rkjhucnKygtYS2mpV52zNAkEAsUmr7lZwW41TF8lY6TfVTL9CYCfjsNlKrJTkWCY90MRQrl71Oku8NJHOJhGSrFlUsJSuloEq2RS7PXNzwlqv4wJAagpDr0Iy2hkXzugH+3BsHMVyUH6A70tBibCO6HV+wvUQEZbf1gTMQNwoXuDbOTFdql5zw2tAB4OTyQwvWkguvQJAXWt6w76cukGANZqN1WbsaOKnsU+TtY7qwII8yQ5tqGKqORgklLFv3Suvu3OrHFJ+RAY08W3jDDzWZY0+xH1RDQJAX7uA8C8Gl/CCA36aUNenJriEnwX3mnQ7UK8iUtwAPR27o6WDsp5nKOy0n6XD47vBtvh+EMmcLdKWdXWIpR56gg=="

@interface NetWorkEngine()



@end

@implementation NetWorkEngine

//单例方法的实现
+ (NetWorkEngine *)shareNetWorkEngine{
    static NetWorkEngine *_netWorkEngine = nil;
    // GCD- 单例写法
    // 在每个线程下都执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _netWorkEngine = [[NetWorkEngine alloc]init];
    });
    return _netWorkEngine;
}

/*
- (void)getDataFromNetWithUrl:(NSString *)url withSuccess:(void (^)(id))success withFailure:(void (^)(NSError * error))fail{
    YTLog(@"请求连接url ==== %@",url)
     url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
     AFHTTPSessionManager *_manager=[AFHTTPSessionManager manager];
//     _manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    _manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
     _manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    NSString *adId = paramHandle([USER_D objectForKey:@"equipid"]);
    [_manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",paramHandle(UserToken)] forHTTPHeaderField:@"apptoken"];
    [_manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",paramHandle(adId)] forHTTPHeaderField:@"sensorNo"];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appversion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    [_manager.requestSerializer setValue:appversion forHTTPHeaderField:@"version"];
    [_manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"platform"];
//    [_manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",paramHandle(kanbaHeaderToken)] forHTTPHeaderField:@"token"];
//    [self setRequestHeaderWithMananger:_manager];
//    _manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
   
    [_manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [_manager.session finishTasksAndInvalidate];
        NSMutableDictionary *dic1 =  [[NSMutableDictionary alloc]initWithDictionary:[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil]];
        success(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          [_manager.session finishTasksAndInvalidate];
        fail(error);
        YTLog(@"请求失败----%@",error);
    }];
    
}
*/

//post
- (void)postRequestWithUrl:(NSString *)url WithParam:(NSDictionary *)dic withSuccess:(void (^)(id))success withFailure:(void (^)(NSError * error))fail{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 请求头
    [self makeHeader:manager];
    // 请求参数
    NSDictionary *param = [IPNRSAUtil signAndSecret:dic];
    
    // 发送请求
    [manager POST:url parameters:param headers: nil progress:^(NSProgress * _Nonnull uploadProgress) {
            
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        YTLog(@"请求参数 ==== %@ ==== %@, 加密参数==== %@",dic,url, param);
        [self responseObject:responseObject success:success withFailure:fail];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self failure:error withFailure:fail];
        YTLog(@"请求参数 ==== %@ ==== %@,返回错误:%@",dic,url,error);
    }];
}

- (void)makeHeader:(AFHTTPSessionManager *)manager {
    //[self.manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain",nil];
    manager.requestSerializer.timeoutInterval = 30.0;
//    NSString *adId = paramHandle([USER_D objectForKey:@"equipid"]);
//    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",paramHandle(UserToken)] forHTTPHeaderField:@"apptoken"];
//    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",paramHandle(adId)] forHTTPHeaderField:@"sensorNo"];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appversion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    [manager.requestSerializer setValue:appversion forHTTPHeaderField:@"version"];
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"platform"];
}

- (void)responseObject:(NSData *)responseObject success:(void (^)(id))success withFailure:(void (^)(NSError * error))fail {
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
    // 请求成功数据处理
    if (jsonDict) {
        NSString *jsonString = [IPNRSAUtil decryptString:jsonDict[@"data"] privateKey:RSAPrivateKey];
        NSDictionary *resultDic = [jsonString mj_JSONObject];
        success(resultDic);
//        YTLog(@"返回结果：%@",resultDic);
        
        [self statusCodeHandle:resultDic];
        
    } else {
        NSError *error = [NSError errorWithDomain:@"com.json.error" code:1001 userInfo:nil];
        fail(error);
    }
}

// 特殊状态码处理
- (void)statusCodeHandle:(NSDictionary *)resultDic {
    // 401: token过期，退出登录
    NSString *result = [NSString stringWithFormat:@"%@",resultDic[@"code"]];
    if ([result isEqualToString:@"401"]) {
//        [MyTool logoutLogin];
    }
}

- (void)failure:(NSError *)error withFailure:(void (^)(NSError * error))fail {
    dispatch_async(dispatch_get_main_queue(), ^{
        fail(error);
    });
}

@end

