//
//  MCStudentViewCell.m
//  AgoraEducation
//
//  Created by yangmoumou on 2019/11/15.
//  Copyright © 2019 Agora. All rights reserved.
//

#import "MCStudentViewCell.h"


@interface MCStudentViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *micButton;
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;

@end

@implementation MCStudentViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization cod
    self.muteVideoButton.selected = YES;
    self.muteAudioButton.selected = YES;
    self.muteWhiteButton.selected = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)muteAction:(UIButton *)sender {
}

- (void)setStream:(EduStream *)stream {
    _stream = stream;
    
    [self.nameLabel setText:stream.userInfo.userName];
    
    self.muteVideoButton.enabled = NO;
    self.muteAudioButton.enabled = NO;
    self.muteWhiteButton.enabled = NO;
    if ([stream.userInfo.userUuid isEqualToString:self.uuid]) {
        self.muteVideoButton.enabled = YES;
        self.muteAudioButton.enabled = YES;
        self.muteWhiteButton.enabled = YES;
    }
    
    if(stream.sourceType == EduVideoSourceTypeCamera) {
        
        NSString *videoImageName = stream.hasVideo ? @"roomCameraOn" : @"roomCameraOff";
        [self.muteVideoButton setImage:[UIImage imageNamed:videoImageName] forState:(UIControlStateNormal)];
        self.muteVideoButton.selected = stream.hasVideo ? YES : NO;
    }
    
    NSString *audioImageName = stream.hasAudio ? @"icon-speaker3-max" : @"icon-speakeroff-dark";
    [self.muteAudioButton setImage:[UIImage imageNamed:audioImageName] forState:(UIControlStateNormal)];
    self.muteAudioButton.selected = stream.hasAudio ? YES : NO;

}

@end
