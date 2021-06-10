//
//  EduLogManager.h
//  AFNetworking
//
//  Created by SRS on 2020/8/10.
//

#import <Foundation/Foundation.h>
#import "EduBaseTypes.h"
#import <AgoraLog/AgoraLog.h>

NS_ASSUME_NONNULL_BEGIN

@interface EduLogManager : NSObject

+ (NSError * _Nullable)logMessage:(NSString *)message level:(AgoraLogLevel)level;
+ (void)uploadDebugItem:(EduDebugItem)item appId:(NSString *)appId success:(void (^)(NSString *serialNumber)) successBlock failure:(EduFailureBlock _Nullable)failureBlock;

@end

NS_ASSUME_NONNULL_END
