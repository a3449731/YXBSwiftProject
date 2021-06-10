//
//  LogUploadConfiguration.h
//  AgoraLog
//
//  Created by SRS on 2020/7/1.
//  Copyright © 2020 agora. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, AgoraLogLevel) {
    AgoraLogLevelNone,
    AgoraLogLevelInfo,
    AgoraLogLevelWarn,
    AgoraLogLevelError,
};

typedef NS_ENUM(NSInteger, AgoraLogErrorType) {
    // No error.
    AgoraLogErrorTypeNone                        = 0,

    // General error indicating that a supplied parameter is invalid.
    AgoraLogErrorTypeInvalidParemeter,

    // An error occurred within an underlying network protocol.
    AgoraLogErrorTypeNetworkError,

    // The operation failed due to an internal error.
    AgoraLogErrorTypeInternalError,
};

NS_ASSUME_NONNULL_BEGIN

@interface AgoraLogConfiguration : NSObject
@property (nonatomic, assign) AgoraLogLevel logConsoleLevel;
@property (nonatomic, assign) AgoraLogLevel logFileLevel;
@property (nonatomic, copy) NSString *logDirectoryPath;
@end

@interface AgoraLogUploadOptions : NSObject
// rtc/rtm AppId
@property(nonatomic, copy) NSString *appId;
// 自定义参数
@property(nonatomic, copy) NSDictionary<NSString *, NSString *> *ext;
@end

NS_ASSUME_NONNULL_END
