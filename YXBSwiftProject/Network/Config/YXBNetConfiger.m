//
//  YXBNetConfiger.m
//  YTKNetworkDemo
//
//  Created by YangXiaoBin on 2019/10/30.
//  Copyright © 2019 yuantiku.com. All rights reserved.
//

#import "YXBNetConfiger.h"
#import <AFNetworking/AFURLRequestSerialization.h>

#ifdef DEBUG
// Debug模式的代码...
#define kServerAddress @"http://192.168.16.69:8088"

#else

// Release模式的代码...
#define kServerAddress @"https://yxz.dysmgo.com"

#endif

@implementation YXBNetConfiger

/// 配置请求头, cdn,公共参数
+ (void)configer {
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.baseUrl = kServerAddress;
    config.cdnUrl = @"";
    
    [config addUrlFilter:[[self alloc] init]];
}

// 配置公用参数,遵循协议<YTKUrlFilterProtocol>
- (NSString *)filterUrl:(NSString *)originUrl withRequest:(YTKBaseRequest *)request {
    NSMutableDictionary *publicParameter = [NSMutableDictionary dictionary];
    // 公共参数
    [publicParameter setValue:@"12363748" forKey:@"token"];
    
    return [YXBNetConfiger urlStringWithOriginUrlString:originUrl appendParameters:publicParameter];
}

+ (NSString *)urlStringWithOriginUrlString:(NSString *)originUrlString appendParameters:(NSDictionary *)parameters {
    NSString *paraUrlString = AFQueryStringFromParameters(parameters);

    if (!(paraUrlString.length > 0)) {
        return originUrlString;
    }

    BOOL useDummyUrl = NO;
    static NSString *dummyUrl = nil;
    NSURLComponents *components = [NSURLComponents componentsWithString:originUrlString];
    if (!components) {
        useDummyUrl = YES;
        if (!dummyUrl) {
            // 这好像是随便写的
            dummyUrl = kServerAddress;
        }
        components = [NSURLComponents componentsWithString:dummyUrl];
    }

    NSString *queryString = components.query ?: @"";
    NSString *newQueryString = [queryString stringByAppendingFormat:queryString.length > 0 ? @"&%@" : @"%@", paraUrlString];

    components.query = newQueryString;

    if (useDummyUrl) {
        return [components.URL.absoluteString substringFromIndex:dummyUrl.length - 1];
    } else {
        return components.URL.absoluteString;
    }
}


@end
