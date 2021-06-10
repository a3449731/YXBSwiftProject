//
//  AgoraLogManager+Quick.h
//  EduSDK
//
//  Created by SRS on 2020/9/2.
//

#import <AgoraLog/AgoraLog.h>

NS_ASSUME_NONNULL_BEGIN

@interface AgoraLogManager (Quick)

+ (void)logMessageWithDescribe:(NSString *)describe message:(id _Nullable)messageObj;

+ (void)logErrMessageWithDescribe:(NSString *)describe message:(id _Nullable)messageObj;

@end

NS_ASSUME_NONNULL_END
