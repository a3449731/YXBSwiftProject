//
//  EduUserDelegate.h
//  EduSDK
//
//  Created by SRS on 2020/7/9.
//  Copyright © 2020 agora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EduUser.h"
#import "EduStream.h"
#import "EduBaseTypes.h"

NS_ASSUME_NONNULL_BEGIN

@protocol EduUserDelegate <NSObject>
@optional

// stream
- (void)localStreamAdded:(EduStreamEvent*)event;
- (void)localStreamRemoved:(EduStreamEvent*)event;
- (void)localStreamUpdated:(EduStreamEvent*)event changeType:(EduStreamStateChangeType)changeType;

// state
- (void)localUserStateUpdated:(EduUserEvent*)event changeType:(EduUserStateChangeType)changeType;

// property
- (void)localUserPropertyUpdated:(EduUser*)user cause:(NSDictionary * _Nullable)cause;
@end

@protocol EduStudentDelegate <EduUserDelegate>

@end

@protocol EduTeacherDelegate <EduUserDelegate>

@end

NS_ASSUME_NONNULL_END
