//
//  EduActionConfig.h
//  EduSDK
//
//  Created by SRS on 2020/9/24.
//

#import <Foundation/Foundation.h>
#import "EduActionMessage.h"
#import "EduUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface EduStartActionConfig : NSObject
@property (nonatomic, assign) NSString *processUuid;
@property (nonatomic, assign) EduActionType action;
@property (nonatomic, copy) EduUser *toUser;
@property (nonatomic, assign) NSInteger timeout;
@property (nonatomic, copy) NSDictionary<NSString *, NSString *> *payload;
@end

@interface EduStopActionConfig : NSObject
@property (nonatomic, assign) NSString *processUuid;
@property (nonatomic, assign) EduActionType action;
@property (nonatomic, copy) NSDictionary<NSString *, NSString *> *payload;
@end

NS_ASSUME_NONNULL_END
