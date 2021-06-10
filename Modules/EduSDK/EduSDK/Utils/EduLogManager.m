//
//  EduLogManager.m
//  AFNetworking
//
//  Created by SRS on 2020/8/10.
//

#import "EduLogManager.h"
#import "EduConstants.h"
#import <YYModel/YYModel.h>
#import "AgoraLogManager+Quick.h"

@implementation EduLogManager

+ (NSError * _Nullable)logMessage:(NSString *)message level:(AgoraLogLevel)level {
    AgoraLogErrorType errType = [AgoraLogManager logMessage:message level:level];
    return [self getErrorTypeFromLog:errType];
}

+ (NSError * _Nullable)getErrorTypeFromLog:(AgoraLogErrorType)errType {
    EduErrorType errorType = EduErrorTypeNone;
    NSString *errorMessage = @"";
    
    switch (errType) {
        case AgoraLogErrorTypeInvalidParemeter:
            errorType = EduErrorTypeInvalidParemeter;
            errorMessage = @"general error indicating that a supplied parameter is invalid.";
            break;
        case AgoraLogErrorTypeNetworkError:
            errorType = EduErrorTypeNetworkError;
            errorMessage = @"an error occurred within an underlying network protocol.";
            break;
        case AgoraLogErrorTypeInternalError:
            errorType = EduErrorTypeInternalError;
            errorMessage = @"the operation failed due to an internal error.";
            break;
        default:
            return nil;
    }
    
    return LocalError(errorType, errorMessage);
}

+ (void)uploadDebugItem:(EduDebugItem)item appId:(NSString *)appId success:(void (^)(NSString *serialNumber)) successBlock failure:(EduFailureBlock _Nullable)failureBlock {

    AgoraLogUploadOptions *options = [AgoraLogUploadOptions new];
    options.appId = appId;
    
    AgoraLogErrorType errType1 = [AgoraLogManager uploadLogWithOptions:options progress:^(float progress) {
        
    } success:^(NSString *serialNumber) {
        if (successBlock != nil) {
            successBlock(serialNumber);
        }
    } failure:^(NSError *error) {
        if(failureBlock != nil) {
            failureBlock(error);
        }
    }];
    
    
    NSError *error = [self getErrorTypeFromLog:errType1];
    if(error != nil && failureBlock != nil) {
        failureBlock(error);
    }
}

@end
