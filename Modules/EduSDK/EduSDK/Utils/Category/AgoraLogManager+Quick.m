//
//  AgoraLogManager+Quick.m
//  EduSDK
//
//  Created by SRS on 2020/9/2.
//

#import "AgoraLogManager+Quick.h"
#import <YYModel/YYModel.h>

@implementation AgoraLogManager (Quick)
+ (void)logMessageWithDescribe:(NSString *)describe message:(id _Nullable)messageObj {
    
    NSString *string = [@"AgoraEudSDK " stringByAppendingString:describe];
    [AgoraLogManager logMessageWithLevel:AgoraLogLevelInfo describe:string message:messageObj];
}

+ (void)logErrMessageWithDescribe:(NSString *)describe message:(id _Nullable)messageObj {
    
    NSString *string = [@"AgoraEudSDK " stringByAppendingString:describe];
    [AgoraLogManager logMessageWithLevel:AgoraLogLevelError describe:string message:messageObj];
}

#pragma mark ---
+ (void)logMessageWithLevel:(AgoraLogLevel)logLevel describe:(NSString *)describe message:(id _Nullable)messageObj {
    
    NSString *message = @"";
    if (messageObj != nil) {
        message = [messageObj yy_modelToJSONString];
    }
    if(message == nil) {
        if([messageObj isKindOfClass:NSNumber.class]) {
            message = [(NSNumber *)messageObj stringValue];
            
        } else if([messageObj isKindOfClass:NSString.class]) {
            message = messageObj;
        }
    }
    
    message = [describe stringByAppendingString:message];
    [AgoraLogManager logMessage:message level:logLevel];
}

@end
