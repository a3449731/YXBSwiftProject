//
//  EduTeacherService.m
//  Demo
//
//  Created by SRS on 2020/6/19.
//  Copyright © 2020 agora. All rights reserved.
//

#import "EduTeacherService.h"
#import "EduConstants.h"
#import "EduMessageHandle.h"
#import "EduStream+ConvenientInit.h"
#import "EduChannelMessageHandle.h"

@interface EduTeacherService ()
@property (nonatomic, strong) EduChannelMessageHandle *messageHandle;
@end

@implementation EduTeacherService

- (void)setDelegate:(id<EduTeacherDelegate>)delegate {
    _delegate = delegate;
    self.messageHandle.userDelegate = delegate;
}
@end
