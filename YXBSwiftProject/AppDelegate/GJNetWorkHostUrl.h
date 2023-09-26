//
//  NetWorkHostUrl.h
//  GJHearlthStore
//
//  Created by DL on 2018/4/27.
//  Copyright © 2018年 GJHearlth. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, kNetWorkType) {
    kNetWorkTypeWithTest = 1, //测试
    kNetWorkTypeWithStage,    //预发
    kNetWorkTypeWithRelease,  //线上
    kNetWorkTypeWithRap,      //RAP环境
};


@interface GJNetWorkHostUrl : NSObject

/// 设置默认的开发环境
+ (void)setDefaultstNetWorkBaseURLWithType:(kNetWorkType)type;

/// 获取接口，根据环境。
/// 如果设置过默认的环境，会优先取设置过的值。 配合DebugToolKit切换网络环境 ( ***** 注意仅在开发环境下可以切换 ******)
/// @param isDevelop 0, 1, 2 .  0: 开发环境   1：预发环境     2：线上环境
+ (NSString *)getHostURLWithIsDevelop:(int)isDevelop;
//+ (NSString *)setHostURLWithIsDevelop:(BOOL)isDevelop;


/**
 * 当前环境

 @return 环境名称
 */
+ (NSString *)currentNetworkEnvironment;

/**
 当前环境Host

 @return host
 */
+ (NSString *)currentHost;

///**
// H5 Host
//
// @return host
// */
//+ (NSString *)currentHTMLHost;
//
//+ (NSString *)currentDoctorHTMLHost;
///**
// 埋点统计URL
// */
//+ (NSString *)statisticalAnalysisHostURL;
//
///// 登录相关URL
//+ (NSString *)loginBaseURL;
//
///// websocket URL
//+ (NSString *)websocketURL;

@end
