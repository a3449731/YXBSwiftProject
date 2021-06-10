
//
//  BigClassViewController.m
//  AgoraEducation
//
//  Created by yangmoumou on 2019/10/22.
//  Copyright © 2019 Agora. All rights reserved.
//

#import "BCViewController.h"
#import "BCSegmentedView.h"
#import "EEChatTextFiled.h"
#import "BCStudentVideoView.h"
#import "EETeacherVideoView.h"
#import "BCNavigationView.h"
#import "EEMessageView.h"
#import "UIView+Toast.h"
#import "WhiteBoardTouchView.h"
#import "HTTPManager.h"
#import "HandsUpModel.h"
#import <YYModel/YYModel.h>

@interface BCViewController ()<BCSegmentedDelegate, UITextFieldDelegate, RoomProtocol, EduClassroomDelegate, EduStudentDelegate, EduManagerDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chatTextFiledRelativeTeacherViewLeftCon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textFiledBottomConstraint;

@property (weak, nonatomic) IBOutlet EETeacherVideoView *teactherVideoView;
@property (weak, nonatomic) IBOutlet BCStudentVideoView *studentVideoView;
@property (weak, nonatomic) IBOutlet BCSegmentedView *segmentedView;
@property (weak, nonatomic) IBOutlet BCNavigationView *navigationView;
@property (weak, nonatomic) IBOutlet UIButton *handUpButton;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UIView *shareScreenView;
@property (weak, nonatomic) IBOutlet EEChatTextFiled *chatTextFiled;
@property (weak, nonatomic) IBOutlet EEMessageView *messageView;

// white
@property (weak, nonatomic) IBOutlet UIView *whiteboardView;

@property (nonatomic, assign) NSInteger segmentedIndex;
@property (nonatomic, assign) NSInteger unreadMessageCount;
@property (nonatomic, assign) SignalLinkState linkState;
@property (nonatomic, assign) BOOL isLandscape;
@property (nonatomic, assign) BOOL isRenderShare;

@end

@implementation BCViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
    [self initData];
    [self addNotification];
    
    [self handleDeviceOrientationChange];
}

- (void)initData {
    
    self.isRenderShare = NO;
    self.linkState = SignalLinkStateIdle;
    
    self.segmentedView.delegate = self;
    self.studentVideoView.delegate = self;
    self.navigationView.delegate = self;
    self.chatTextFiled.contentTextFiled.delegate = self;
    
    AgoraEduManager.shareManager.eduManager.delegate = self;

    [self.navigationView updateClassName: self.className];
}

- (void)lockViewTransform:(BOOL)lock {
    
    [AgoraEduManager.shareManager.whiteBoardManager  lockViewTransform:lock];
}
- (void)muteVideoStream:(BOOL)mute {
    [self setLocalStreamVideo:!mute audio:self.studentVideoView.hasAudio streamState:LocalStreamStateUpdate];
}
- (void)muteAudioStream:(BOOL)mute {
    [self setLocalStreamVideo:self.studentVideoView.hasVideo audio:!mute streamState:LocalStreamStateUpdate];
}
- (void)updateRoleViews:(EduUser *) user {
    
    if(user.role == EduRoleTypeTeacher){
        if (self.segmentedIndex == 0) {
            self.handUpButton.hidden = NO;
        }
        [self.teactherVideoView updateAndsetTeacherName: user.userName];
        
    } else if(user.role == EduRoleTypeStudent){
    }
}
- (void)removeRoleViews:(EduUser *) user {
    if (user.role == EduRoleTypeTeacher) {
        [self.teactherVideoView updateAndsetTeacherName: @""];
    }
}
- (void)updateRoleCanvas:(EduStream *)stream {
    
    if(stream.userInfo.role == EduRoleTypeTeacher) {
        if(stream.sourceType == EduVideoSourceTypeCamera) {
            [AgoraEduManager.shareManager.studentService setStreamView:(stream.hasVideo ? self.teactherVideoView.teacherRenderView : nil) stream:stream];
            
            self.teactherVideoView.defaultImageView.hidden = stream.hasVideo ? YES : NO;
            [self.teactherVideoView updateSpeakerImageWithMuted:!stream.hasAudio];
            
        } else if(stream.sourceType == EduVideoSourceTypeScreen) {
            EduRenderConfig *config = [EduRenderConfig new];
            config.renderMode = EduRenderModeFit;
            [AgoraEduManager.shareManager.studentService setStreamView:(stream.hasVideo ? self.shareScreenView : nil) stream:stream renderConfig:config];
            self.shareScreenView.hidden = NO;
            self.isRenderShare = YES;
        }
    } else if(stream.userInfo.role == EduRoleTypeStudent) {
        [AgoraEduManager.shareManager.studentService setStreamView:(stream.hasVideo ? self.studentVideoView.studentRenderView : nil) stream:stream];
        [self.studentVideoView updateVideoImageWithMuted:!stream.hasVideo];
        [self.studentVideoView updateAudioImageWithMuted:!stream.hasAudio];
        
        //
        self.studentVideoView.hidden = NO;
        [self.studentVideoView setButtonEnabled:YES];
        if(![self.localUser.userUuid isEqualToString: stream.userInfo.userUuid]) {
            [self.studentVideoView setButtonEnabled:NO];
        } else {
            self.linkState = SignalLinkStateTeaAccept;
            [self setLocalStreamVideo:stream.hasVideo audio:stream.hasAudio streamState:LocalStreamStateIdle];
        }
        [self.handUpButton setBackgroundImage:[UIImage imageNamed:@"icon-handup-x"] forState:(UIControlStateNormal)];
    }
}
- (void)removeRoleCanvas:(EduStream *)stream {
    [AgoraEduManager.shareManager.studentService setStreamView:nil stream:stream];

    if (stream.userInfo.role == EduRoleTypeTeacher) {
        if (stream.sourceType == EduVideoSourceTypeScreen) {
            self.shareScreenView.hidden = YES;
            self.isRenderShare = NO;
        } else if (stream.sourceType == EduVideoSourceTypeCamera) {
            self.teactherVideoView.defaultImageView.hidden = NO;
            [self.teactherVideoView updateSpeakerImageWithMuted:YES];
        }
    } else if (stream.userInfo.role == EduRoleTypeStudent) {
        
        if ([stream.userInfo.userUuid isEqualToString:self.localUser.userUuid]) {
            [self setLocalStreamVideo:NO audio:NO streamState:LocalStreamStateIdle];
        }
        
        [self.studentVideoView updateVideoImageWithMuted:YES];
        [self.studentVideoView updateAudioImageWithMuted:YES];
        
        self.studentVideoView.hidden = YES;
        [self.handUpButton setBackgroundImage:[UIImage imageNamed:@"icon-handup"] forState:(UIControlStateNormal)];
    }
}

- (void)updateChatViews {
    [self updateChatViews:self.chatTextFiled];
}

- (void)setupView {
    
    WhiteBoardManager *whiteBoardManager = AgoraEduManager.shareManager.whiteBoardManager;
    UIView *boardView = [whiteBoardManager getBoardView];
    [self.whiteboardView addSubview:boardView];
    self.boardView = boardView;
    [boardView equalTo:self.whiteboardView];
    
    self.handUpButton.layer.borderWidth = 1.f;
    self.handUpButton.layer.borderColor = [UIColor colorWithHexString:@"DBE2E5"].CGColor;
    self.handUpButton.layer.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"].CGColor;
    self.handUpButton.layer.cornerRadius = 6;
    
    self.tipLabel.layer.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.7].CGColor;
    self.tipLabel.layer.cornerRadius = 6;
    
    if(IsPad) {
        [self stateBarHidden:YES];
        self.chatTextFiled.hidden = NO;
        self.messageView.hidden = NO;
    }
}

- (void)handleDeviceOrientationChange {
    
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    switch (deviceOrientation) {
        case UIDeviceOrientationPortrait:
        {
            [self verticalScreenConstraints];
            [self.view layoutIfNeeded];
            [AgoraEduManager.shareManager.whiteBoardManager refreshViewSize];
        }
            break;
        case UIDeviceOrientationLandscapeLeft:
        case UIDeviceOrientationLandscapeRight:
        {
            [self landscapeScreenConstraints];
            [self.view layoutIfNeeded];
            [AgoraEduManager.shareManager.whiteBoardManager refreshViewSize];
        }
            break;
        default:
            break;
    }
}

- (void)stateBarHidden:(BOOL)hidden {
    self.isLandscape = hidden;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (IBAction)handUpEvent:(UIButton *)sender {
    
    WEAK(self);
    [AgoraEduManager.shareManager.roomManager getFullStreamListWithSuccess:^(NSArray<EduStream *> * _Nonnull streams) {
        
        for(EduStream *stream in streams) {
            if(stream.userInfo.role == EduRoleTypeStudent && ![stream.userInfo.userUuid isEqualToString:weakself.localUser.userUuid]) {
                
                return;
            }
        }
        
        switch (weakself.linkState) {
            case SignalLinkStateIdle:
            case SignalLinkStateTeaReject:
            case SignalLinkStateStuCancel:
            case SignalLinkStateStuClose:
            case SignalLinkStateTeaClose:
                [weakself coVideoStateChanged: SignalLinkStateApply];
                break;
            case SignalLinkStateApply:
                [weakself coVideoStateChanged: SignalLinkStateStuCancel];
                break;
            case SignalLinkStateTeaAccept:
                [weakself coVideoStateChanged: SignalLinkStateStuClose];
                break;
            default:
                break;
        }
    } failure:^(NSError * error) {
        [weakself showToast:error.description];
    }];
}

- (void)coVideoStateChanged:(SignalLinkState) linkState {
    switch (linkState) {
        case SignalLinkStateApply:
        case SignalLinkStateStuCancel:
        case SignalLinkStateStuClose: {
            WEAK(self);
            // find teacher
            [AgoraEduManager.shareManager.roomManager getFullUserListWithSuccess:^(NSArray<EduUser *> * _Nonnull users) {
                
                EduUser *teacher;
                for(EduUser *user in users) {
                    if(user.role == EduRoleTypeTeacher){
                        teacher = user;
                        break;
                    }
                }

                weakself.linkState = linkState;
                if(linkState == SignalLinkStateStuClose) {
                    [weakself setLocalStreamVideo:NO audio:NO streamState:LocalStreamStateRemove];
                }
                
                if(teacher != nil){
                    [weakself sendUserMessage:linkState toUser:teacher];
                }
                
            } failure:^(NSError * error) {
                [weakself showToast:error.description];
            }];

            if (linkState == SignalLinkStateStuCancel) {
                weakself.linkState = linkState;
                [weakself.handUpButton setBackgroundImage:[UIImage imageNamed:@"icon-handup"] forState:(UIControlStateNormal)];
            } else if (linkState == SignalLinkStateStuClose) {
                weakself.linkState = linkState;
                [AgoraEduManager.shareManager.roomManager getFullStreamListWithSuccess:^(NSArray<EduStream *> * _Nonnull streams) {
                    
                    for(EduStream *stream in streams) {
                        if([stream.userInfo.userUuid isEqualToString:weakself.localUser.userUuid]) {
                            [weakself removeRoleCanvas:stream];
                            break;
                        }
                    }
                    
                } failure:^(NSError * error) {
                    [weakself showToast:error.description];
                }];
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)sendUserMessage:(SignalLinkState) linkState toUser:(EduUser*)teacher {
    
    HandsUpDataModel *dataModel = [HandsUpDataModel new];
    dataModel.userUuid = self.localUser.userUuid;
    dataModel.userName = self.localUser.userName;
    dataModel.type = linkState;
    HandsUpModel *model = [HandsUpModel new];
    model.cmd = CMD_SIGNAL_LINK_STATE;
    model.data = dataModel;
    NSString *text = [model yy_modelToJSONString];
    
    WEAK(self);
    [AgoraEduManager.shareManager.studentService sendUserMessageWithText:text remoteUser:teacher success:^{
    } failure:^(NSError * error) {
        [weakself showToast:error.description];
    }];
}

- (void)landscapeScreenConstraints {
    if(!IsPad) {
        [self stateBarHidden:YES];
        self.chatTextFiled.hidden = NO;
        self.messageView.hidden = NO;
        self.handUpButton.hidden = NO;
//        [self resetHandUp];
    }
}

- (void)resetHandUp {
    
//    self.handUpButton.hidden = YES;
//
//    WEAK(self);
//    [AgoraEduManager.shareManager.roomManager getFullUserListWithSuccess:^(NSArray<EduUser *> * _Nonnull users) {
//
//        for(EduUser *user in users) {
//            if(user.role == EduRoleTypeTeacher){
//                weakself.handUpButton.hidden = NO;
//                break;
//            }
//        }
//
//    } failure:^(NSError * _Nullable error) {
//        [weakself showToast:error.description];
//    }];
}
- (void)verticalScreenConstraints {
    if(!IsPad) {
        [self stateBarHidden:NO];
        self.chatTextFiled.hidden = self.segmentedIndex == 0 ? YES : NO;
        self.messageView.hidden = self.segmentedIndex == 0 ? YES : NO;
//        [self resetHandUp];
        self.handUpButton.hidden = self.segmentedIndex == 0 ? NO: YES;
     
        if(self.isRenderShare) {
            self.shareScreenView.hidden = NO;
        }
    }
}

#pragma mark Notification
- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleDeviceOrientationChange) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)keyboardWasShow:(NSNotification *)notification {
    if (self.isChatTextFieldKeyboard) {
        self.chatTextFiledRelativeTeacherViewLeftCon.active = NO;
        
        CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        float bottom = frame.size.height;
        self.textFiledBottomConstraint.constant = bottom;
    }
}

- (void)keyboardWillHidden:(NSNotification *)notification {
    self.chatTextFiledRelativeTeacherViewLeftCon.active = YES;
    self.textFiledBottomConstraint.constant = 0;
}

- (void)setupWhiteBoard {
    
    WEAK(self);
    [self setupWhiteBoard:^{
        BOOL lock = weakself.boardState.follow;
        [weakself lockViewTransform:lock];
    }];
}

#pragma mark BCSegmentedDelegate
- (void)selectedItemIndex:(NSInteger)index {
    
    if (index == 0) {
        self.segmentedIndex = 0;
        self.messageView.hidden = YES;
        self.chatTextFiled.hidden = YES;
        self.handUpButton.hidden = NO;
//        [self resetHandUp];
        if(self.isRenderShare) {
            self.shareScreenView.hidden = NO;
        }
    } else {
        self.segmentedIndex = 1;
        self.messageView.hidden = NO;
        self.chatTextFiled.hidden = NO;
        self.handUpButton.hidden = YES;
        self.unreadMessageCount = 0;
        [self.segmentedView hiddeBadge];
        self.shareScreenView.hidden = YES;
    }
}

#pragma mark RoomProtocol
- (void)closeRoom {
    WEAK(self);
    [AlertViewUtil showAlertWithController:self title:NSLocalizedString(@"QuitClassroomText", nil) sureHandler:^(UIAlertAction * _Nullable action) {
        [AgoraEduManager releaseResource];
        [weakself dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (BOOL)prefersStatusBarHidden {
    return self.isLandscape;
}
- (BOOL)shouldAutorotate {
    return YES;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

#pragma mark EduClassroomDelegate
// User in or out
- (void)classroom:(EduClassroom * _Nonnull)classroom remoteUsersInit:(NSArray<EduUser*> *)users {
    for (EduUser *user in users) {
        [self updateRoleViews:user];
    }
}
- (void)classroom:(EduClassroom * _Nonnull)classroom remoteUsersJoined:(NSArray<EduUser*> *)users {
    for (EduUser *user in users) {
        [self updateRoleViews:user];
    }
}
- (void)classroom:(EduClassroom *)classroom remoteUserStateUpdated:(EduUserEvent *)event changeType:(EduUserStateChangeType)changeType {
    [self updateRoleViews:event.modifiedUser];
}
- (void)classroom:(EduClassroom * _Nonnull)classroom remoteUsersLeft:(NSArray<EduUserEvent*> *)events {
    for (EduUserEvent *event in events) {
        [self removeRoleViews:event.modifiedUser];
    }
}
// message
- (void)classroom:(EduClassroom * _Nonnull)classroom roomChatMessageReceived:(EduTextMessage *)textMessage {

    EETextMessage *message = [EETextMessage new];
    message.fromUser = textMessage.fromUser;
    message.message = textMessage.message;
    message.timestamp = textMessage.timestamp;
    [self.messageView addMessageModel:message];
    
    if (self.messageView.hidden) {
        self.unreadMessageCount = self.unreadMessageCount + 1;
        [self.segmentedView showBadgeWithCount:(self.unreadMessageCount)];
    }
}
// stream
- (void)classroom:(EduClassroom * _Nonnull)classroom remoteStreamsInit:(NSArray<EduStream*> *)streams {
    for (EduStream *stream in streams) {
        [self updateRoleCanvas:stream];
    }
}
- (void)classroom:(EduClassroom * _Nonnull)classroom remoteStreamsAdded:(NSArray<EduStreamEvent*> *)events {
    for (EduStreamEvent *event in events) {
        [self updateRoleCanvas:event.modifiedStream];
    }
}
- (void)classroom:(EduClassroom *)classroom remoteStreamUpdated:(EduStreamEvent *)event changeType:(EduStreamStateChangeType)changeType {
    [self updateRoleCanvas:event.modifiedStream];
}
- (void)classroom:(EduClassroom * _Nonnull)classroom remoteStreamsRemoved:(NSArray<EduStreamEvent*> *)events {
    for (EduStreamEvent *event in events) {
        [self removeRoleCanvas:event.modifiedStream];
    }
}
- (void)classroom:(EduClassroom * _Nonnull)classroom networkQualityChanged:(NetworkQuality)quality user:(EduBaseUser *)user {
    
    if([self.localUser.userUuid isEqualToString:user.userUuid]) {
        switch (quality) {
            case NetworkQualityHigh:
                [self.navigationView updateSignalImageName:@"icon-signal3"];
                break;
            case NetworkQualityMiddle:
                [self.navigationView updateSignalImageName:@"icon-signal2"];
                break;
            case NetworkQualityLow:
                [self.navigationView updateSignalImageName:@"icon-signal1"];
                break;
            default:
                break;
        }
    }
}

#pragma mark EduStudentDelegate
- (void)localUserStateUpdated:(EduUserEvent*)event changeType:(EduUserStateChangeType)changeType {
    [self updateChatViews];
}
- (void)localStreamAdded:(EduStreamEvent*)event {
    [self updateRoleCanvas:event.modifiedStream];
}
- (void)localStreamUpdated:(EduStreamEvent*)event changeType:(EduStreamStateChangeType)changeType {
    [self updateRoleCanvas:event.modifiedStream];
}
- (void)localStreamRemoved:(EduStreamEvent*)event {
    [self removeRoleCanvas:event.modifiedStream];
}
- (void)userMessageReceived:(EduTextMessage*)textMessage {
    
    HandsUpModel *model = [HandsUpModel yy_modelWithJSON:textMessage.message];
    if(model.cmd != CMD_SIGNAL_LINK_STATE) {
        return;
    }
    HandsUpDataModel *dataModel = model.data;
    switch (dataModel.type) {
        case SignalLinkStateTeaReject:
            [self showToast:NSLocalizedString(@"RejectRequestText", nil)];
            break;
        case SignalLinkStateTeaAccept:
            [self showToast:NSLocalizedString(@"AcceptRequestText", nil)];
            break;
        case SignalLinkStateTeaClose:
            [self showToast:NSLocalizedString(@"TeaCloseCoVideoText", nil)];
            break;
        default:
            break;
    }
    
    self.linkState = dataModel.type;
}

#pragma mark UITextFieldDelegate
- (void)onSendMessage:(EETextMessage *)message {
    [self.messageView addMessageModel:message];
}

#pragma mark onSyncSuccess
- (void)onSyncSuccess {
    [self setupWhiteBoard];
    [self updateChatViews];
}

#pragma mark onReconnected
- (void)onReconnected {
    
    [self updateChatViews];
    
    BOOL lock = self.boardState.follow;
    [self lockViewTransform:lock];
    
    WEAK(self);
    [AgoraEduManager.shareManager.roomManager getFullUserListWithSuccess:^(NSArray<EduUser *> * _Nonnull users) {
        for(EduUser *user in users){
            [weakself updateRoleViews:user];
        }
    } failure:^(NSError * error) {
        [weakself showToast:error.description];
    }];
    
    [AgoraEduManager.shareManager.roomManager getFullStreamListWithSuccess:^(NSArray<EduStream *> * _Nonnull streams) {
        for(EduStream *stream in streams){
            [weakself updateRoleCanvas:stream];
        }
    } failure:^(NSError * error) {
        [weakself showToast:error.description];
    }];
}

#pragma mark ClassRoom Update
- (void)onUpdateChatViews {
    [self updateChatViews];
}
- (void)onBoardFollowMode:(BOOL)enable {
    NSString *toastMessage;
    if(enable) {
        toastMessage = NSLocalizedString(@"LockBoardText", nil);
    } else {
        toastMessage = NSLocalizedString(@"UnlockBoardText", nil);
    }
    [self showToast:toastMessage];
    [self lockViewTransform:enable];
}
- (void)onEndRecord {
    EETextMessage *textMsg = [EETextMessage new];
    EduUser *fromUser = [EduUser new];
    [fromUser setValue:@"system" forKey:@"userName"];
    textMsg.fromUser = fromUser;
    textMsg.message = NSLocalizedString(@"ReplayRecordingText", nil);
    textMsg.recordRoomUuid = self.roomUuid;
    [self.messageView addMessageModel:textMsg];
    
    if (self.messageView.hidden) {
        self.unreadMessageCount = self.unreadMessageCount + 1;
        [self.segmentedView showBadgeWithCount:(self.unreadMessageCount)];
    }
}
@end
