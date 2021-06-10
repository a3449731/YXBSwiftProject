//
//  AgoraLogManager.m
//  AgoraLog
//
//  Created by SRS on 2020/7/1.
//  Copyright © 2020 agora. All rights reserved.
//

#import "AgoraLogManager.h"
#import <CocoaLumberjack/CocoaLumberjack.h>
#import "OSSManager.h"
#import "SSZipArchive.h"
#import "LogHttpManager.h"

#define AgoraLogError(frmt, ...)   DDLogError(frmt, ##__VA_ARGS__)
#define AgoraLogWarn(frmt, ...)    DDLogWarn(frmt, ##__VA_ARGS__)
#define AgoraLogInfo(frmt, ...)    DDLogInfo(frmt, ##__VA_ARGS__)
#define AgoraLogDebug(frmt, ...)   DDLogDebug(frmt, ##__VA_ARGS__)
#define AgoraLogVerbose(frmt, ...) DDLogVerbose(frmt, ##__VA_ARGS__)

// Error
#define LocalAgoraLogErrorCode 9990

static DDLogLevel ddLogLevel = DDLogLevelAll;
static DDLogLevel ddLogConsoleLevel = DDLogLevelAll;

#define APIVersion1 @"v1"

typedef NS_ENUM(NSInteger, ZipStateType) {
    ZipStateTypeOK              = 0,
    ZipStateTypeOnNotFound      = 1,
    ZipStateTypeOnRemoveError   = 2,
    ZipStateTypeOnZipError      = 3,
};

static NSString *logDirectoryPath = @"";

@implementation AgoraLogManager

+ (AgoraLogErrorType)setupLog:(AgoraLogConfiguration *)config {
    
    BOOL levelVerify = YES;
    switch (config.logFileLevel) {
        case AgoraLogLevelNone:
            ddLogLevel = DDLogLevelOff;
            break;
        case AgoraLogLevelInfo:
            ddLogLevel = DDLogLevelInfo;
            break;
        case AgoraLogLevelWarn:
            ddLogLevel = DDLogLevelWarning;
            break;
        case AgoraLogLevelError:
            ddLogLevel = DDLogLevelError;
            break;
        default:
            levelVerify = NO;
            break;
    }
    if (!levelVerify) {
        return AgoraLogErrorTypeInvalidParemeter;
    }
    
    switch (config.logConsoleLevel) {
        case AgoraLogLevelNone:
            ddLogConsoleLevel = DDLogLevelOff;
            break;
        case AgoraLogLevelInfo:
            ddLogConsoleLevel = DDLogLevelInfo;
            break;
        case AgoraLogLevelWarn:
            ddLogConsoleLevel = DDLogLevelWarning;
            break;
        case AgoraLogLevelError:
            ddLogConsoleLevel = DDLogLevelError;
            break;
        default:
            levelVerify = NO;
            break;
    }
    if (!levelVerify) {
        return AgoraLogErrorTypeInvalidParemeter;
    }
    
    logDirectoryPath = config.logDirectoryPath;
    
    #ifdef DEBUG
        NSLog(@"AgoraLog logDirectoryPath==>%@", logDirectoryPath);
    #endif
    
    BOOL isDirectory = NO;
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager fileExistsAtPath:logDirectoryPath isDirectory:&isDirectory];
    if(!isDirectory) {
        NSError *error;
        [manager createDirectoryAtPath:logDirectoryPath withIntermediateDirectories:YES attributes:nil error:&error];
        if (error != nil) {
            return AgoraLogErrorTypeInternalError;
        }
    }
    
    [DDLog addLogger:[DDOSLogger sharedInstance] withLevel:ddLogConsoleLevel];
    DDLogFileManagerDefault *logFileManager = [[DDLogFileManagerDefault alloc] initWithLogsDirectory:logDirectoryPath];
    DDFileLogger *fileLogger = [[DDFileLogger alloc] initWithLogFileManager:logFileManager];
    fileLogger.rollingFrequency = 60 * 60 * 24;
    fileLogger.maximumFileSize = 1024 * 1024;
    fileLogger.logFileManager.maximumNumberOfLogFiles = 5;
    [DDLog addLogger:fileLogger withLevel:ddLogLevel];
    
    return AgoraLogErrorTypeNone;
}

+ (AgoraLogErrorType)logMessage:(NSString *)message level:(AgoraLogLevel)level {

    BOOL levelVerify = YES;
    switch (level) {
        case AgoraLogLevelError:
            AgoraLogError(@"%@", message);
            break;
        case AgoraLogLevelWarn:
            AgoraLogWarn(@"%@", message);
            break;
        case AgoraLogLevelInfo:
            AgoraLogInfo(@"%@", message);
            break;
        default:
            levelVerify = NO;
            break;
    }
    if(message == nil || message.length == 0 || !levelVerify) {
        return AgoraLogErrorTypeInvalidParemeter;
    } else {
        return AgoraLogErrorTypeNone;
    }
}

+ (AgoraLogErrorType)uploadLogWithOptions:(AgoraLogUploadOptions*)options progress:(void (^ _Nullable) (float progress))progressBlock success:(void (^ _Nullable) (NSString *serialNumber))successBlock failure:(void (^ _Nullable) (NSError *error))failureBlock {

    if(options.appId == nil || options.appId.length == 0) {
        return AgoraLogErrorTypeInvalidParemeter;
    }

    NSString *logBaseDirectoryPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *zipDirectoryPath = [logBaseDirectoryPath stringByAppendingPathComponent:@"/AgoraLogZip/"];
    
    NSString *zipName = [AgoraLogManager generateZipName];
    NSString *zipPath = [NSString stringWithFormat:@"%@/%@", zipDirectoryPath, zipName];

    [AgoraLogManager zipFilesWithSourceDirectory:logDirectoryPath zipdirectoryPath:zipDirectoryPath zipPath:zipPath  completeBlock:^(ZipStateType zipCode) {
        
        if(zipCode != ZipStateTypeOK){
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *errMsg = [@"error during compressing file：" stringByAppendingString:@(zipCode).stringValue];
                NSError *error = LocalError(AgoraLogErrorTypeInternalError, errMsg);
                if(failureBlock != nil) {
                    failureBlock(error);
                }
            });
            return;
        }
        
        [AgoraLogManager checkZipCodeAndUploadWithZipCode:zipCode zipPath:zipPath logParams:options progress:progressBlock success:successBlock fail:^(NSError *error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSError *sdkError = LocalError(AgoraLogErrorTypeNetworkError, error.description);
                if(failureBlock != nil) {
                    failureBlock(sdkError);
                }
            });
        }];
    }];
    
    return AgoraLogErrorTypeNone;
}

+ (void)checkZipCodeAndUploadWithZipCode:(ZipStateType)zipCode zipPath:(NSString *)zipPath logParams:(AgoraLogUploadOptions *)logParams progress:(void (^ _Nullable) (float progress))progressBlock success:(void (^ _Nullable) (NSString *uploadSerialNumber))successBlock fail:(void (^ _Nullable) (NSError *error))failBlock {
    
    switch (zipCode) {
        case ZipStateTypeOnNotFound:
            if(failBlock != nil) {
                NSError *error = LocalError(LocalAgoraLogErrorCode, @"no log files found");
                dispatch_async(dispatch_get_main_queue(), ^{
                    failBlock(error);
                });
            }
            return;
            break;
        case ZipStateTypeOnRemoveError:
            if(failBlock != nil) {
                NSError *error = LocalError(LocalAgoraLogErrorCode, @"failed to clear log files");
                dispatch_async(dispatch_get_main_queue(), ^{
                    failBlock(error);
                });
            }
            return;
            break;
        case ZipStateTypeOnZipError:
            if(failBlock != nil) {
                NSError *error = LocalError(LocalAgoraLogErrorCode, @"log file compression failed");
                dispatch_async(dispatch_get_main_queue(), ^{
                    failBlock(error);
                });
            }
            return;
            break;
        default:
            break;
    }
    if (zipCode != ZipStateTypeOK){
        if(failBlock != nil) {
            NSError *error = LocalError(LocalAgoraLogErrorCode, @"log file compression failed");
            dispatch_async(dispatch_get_main_queue(), ^{
                failBlock(error);
            });
        }
        return;
    }
    
    [LogHttpManager getLogInfoWithAppId:logParams.appId ext:logParams.ext apiVersion:APIVersion1 completeSuccessBlock:^(LogModel * _Nonnull logModel) {
        
        if(logModel.code != 0){
            if(failBlock != nil) {
                NSError *error = LocalError(logModel.code, logModel.msg);
                dispatch_async(dispatch_get_main_queue(), ^{
                    failBlock(error);
                });
            }
            return;
        }
        
        LogInfoModel *model = logModel.data;
        
        [OSSManager uploadOSSWithAccess:model.accessKeyId secret:model.accessKeySecret token:model.securityToken bucketName:model.bucketName objectKey:model.ossKey callbackBody:model.callbackBody callbackBodyType:model.callbackContentType endpoint:model.ossEndpoint fileURL:[NSURL URLWithString:zipPath] progress:^(float progress) {

            if(progressBlock != nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    progressBlock(progress);
                });
            }
        } success:^(NSString * _Nonnull uploadSerialNumber) {

            if(successBlock != nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    successBlock(uploadSerialNumber);
                });
            }
        } fail:^(NSError * _Nonnull error) {
            if(failBlock != nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    failBlock(error);
                });
            }
        }];
        
    } completeFailBlock:^(NSError * _Nonnull error) {
        if(failBlock != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failBlock(error);
            });
        }
    }];
}

+ (void)zipFilesWithSourceDirectory:(NSString *)directoryPath zipdirectoryPath:(NSString *)zipDirectoryPath zipPath:(NSString *)zipPath completeBlock:(void (^) (NSInteger zipCode))block {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL isDirectoryExist = [fileManager fileExistsAtPath:directoryPath];
        if(!isDirectoryExist) {
            [fileManager createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        isDirectoryExist = [fileManager fileExistsAtPath:zipDirectoryPath];
        if(!isDirectoryExist) {
            [fileManager createDirectoryAtPath:zipDirectoryPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        NSDirectoryEnumerator *direnum = [fileManager enumeratorAtPath:zipDirectoryPath];
        NSString *filename;
        while (filename = [direnum nextObject]) {
            if ([[filename pathExtension] isEqualToString:@"zip"]) {
                
                NSString *logZipPath = [NSString stringWithFormat:@"%@/%@", zipDirectoryPath, filename];
                
                NSError *error;
                BOOL rmvSuccess = [fileManager removeItemAtPath:logZipPath error:&error];
                if (error || !rmvSuccess) {
                    block(ZipStateTypeOnRemoveError);
                    return;
                }
                break;
            }
        }
        
        BOOL zipSuccess = [SSZipArchive createZipFileAtPath:zipPath withContentsOfDirectory:directoryPath];
        
        if(zipSuccess){
            block(ZipStateTypeOK);
        } else {
            block(ZipStateTypeOnZipError);
        }
    });
}

+ (NSString *)generateZipName {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYYMMddHHmmss"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    NSString *zipName = [NSString stringWithFormat:@"%@.zip", currentTimeString];
    return zipName;
}

@end
