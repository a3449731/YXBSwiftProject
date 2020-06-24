//
//  YXBNetConfiger.h
//  YTKNetworkDemo
//
//  Created by YangXiaoBin on 2019/10/30.
//  Copyright © 2019 yuantiku.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YTKNetworkConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface YXBNetConfiger : NSObject <YTKUrlFilterProtocol>

#pragma mark ------- 由于后台返回的并非json文本， YTK又没有开发配置acceptableContentTypes接口 -------
// 所以在YTKNetworkAgent.m， - (AFJSONResponseSerializer *)jsonResponseSerializer 方法中添加:
//_jsonResponseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json",@"text/javascript",@"text/html",@"text/plain", nil];
#pragma mark ------- 改完之后 clean一下， 再编译 -------


/// 配置请求头, cdn,公共参数, 建议在AppDelegate中调用。
/// 请在初始化tabbar之前 配置。
+ (void)configer;

@end

NS_ASSUME_NONNULL_END
