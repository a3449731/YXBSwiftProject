//
//  BaseViewController.h
//  AgoraEducation
//
//  Created by SRS on 2020/8/3.
//  Copyright © 2020 yangmoumou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EETextMessage.h"
#import "EENavigationView.h"
#import "EEChatTextFiled.h"
#import "HTTPManager.h"

typedef NS_ENUM(NSInteger, LocalStreamState) {
    LocalStreamStateIdle,
    LocalStreamStateCreate,
    LocalStreamStateUpdate,
    LocalStreamStateRemove
};

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

@property (nonatomic, assign) EduSceneType sceneType;
@property (nonatomic, strong) NSString *userUuid;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *className;
@property (nonatomic, strong) NSString *roomUuid;

@property (nonatomic, strong) WhiteBoardStateModel *boardState;
@property (nonatomic, strong) EduLocalUser *localUser;

#pragma mark --
@property (nonatomic, weak) UIView *boardView;
@property (nonatomic, assign) BOOL isChatTextFieldKeyboard;
- (void)showToast:(NSString *)title;
- (void)setupWhiteBoard:(void (^) (void))success;
- (void)updateTimeState:(EENavigationView *)navigationView;
- (void)updateChatViews:(EEChatTextFiled *)chatTextFiled;

- (void)setLocalStreamVideo:(BOOL)hasVideo audio:(BOOL)hasAudio streamState:(LocalStreamState)state;
@end

NS_ASSUME_NONNULL_END
