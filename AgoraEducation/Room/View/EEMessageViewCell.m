//
//  EEMessageViewCell.m
//  AgoraEducation
//
//  Created by yangmoumou on 2019/11/11.
//  Copyright © 2019 Agora. All rights reserved.
//

#import "EEMessageViewCell.h"
#import "UIView+Toast.h"

@interface EEMessageViewCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftViewWidthCon;
@property (weak, nonatomic) IBOutlet UILabel *leftContentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightViewWidthCon;
@property (weak, nonatomic) IBOutlet UILabel *rightContentLabel;
@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation EEMessageViewCell
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.leftView.layer.borderColor = [UIColor colorWithHexString:@"DBE2E5"].CGColor;
    self.leftView.layer.borderWidth = 1.f;
    self.leftView.layer.masksToBounds = YES;
    self.leftView.layer.cornerRadius = 4.f;

    self.rightView.layer.borderColor = [UIColor colorWithHexString:@"DBE2E5"].CGColor;
    self.rightView.layer.borderWidth = 1.f;
    self.rightView.layer.masksToBounds = YES;
    self.rightView.layer.cornerRadius = 4.f;
    self.rightView.backgroundColor = [UIColor colorWithHexString:@"E7F6FF"];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setMessageModel:(EETextMessage *)messageModel {
    _messageModel = messageModel;

    NSMutableAttributedString *contentString;

    if(messageModel.recordRoomUuid != nil) {
        contentString = [[NSMutableAttributedString alloc] initWithString:messageModel.message attributes:@{NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)}];
       
    } else {
        contentString = [[NSMutableAttributedString alloc] initWithString:messageModel.message];
    }

    WEAK(self);
    [AgoraEduManager.shareManager.roomManager getLocalUserWithSuccess:^(EduUser * _Nonnull user) {
        
        if([messageModel.fromUser.userUuid isEqualToString:user.userUuid]){
            CGSize size =  [weakself sizeWithContent:messageModel.message];
            weakself.rightViewWidthCon.constant = (size.width + 25) > weakself.cellWidth ? weakself.cellWidth : size.width + 25;
            [weakself.rightContentLabel setAttributedText:contentString];
            weakself.rightView.hidden = NO;
            weakself.rightContentLabel.hidden = NO;
            weakself.leftView.hidden = YES;
            weakself.leftContentLabel.hidden = YES;
            weakself.nameLabel.textAlignment = NSTextAlignmentRight;
        } else {
            CGSize size =  [weakself sizeWithContent: messageModel.message];
            weakself.leftViewWidthCon.constant = size.width + 25 > weakself.cellWidth ? weakself.cellWidth : size.width +25;
            [weakself.leftContentLabel setAttributedText:contentString];
            weakself.rightView.hidden = YES;
            weakself.rightContentLabel.hidden = YES;
            weakself.leftView.hidden = NO;
            weakself.leftContentLabel.hidden = NO;
            weakself.nameLabel.textAlignment = NSTextAlignmentLeft;
        }
        
    } failure:^(NSError * error) {
        [UIApplication.sharedApplication.keyWindow makeToast:error.description];
    }];
    
    NSString *roleString = @"";
    switch (messageModel.fromUser.role) {
        case EduRoleTypeTeacher:
            roleString = [NSString stringWithFormat:@"[%@]:", NSLocalizedString(@"TeacherText", nil)];
            break;
        case EduRoleTypeAssistant:
            roleString = [NSString stringWithFormat:@"[%@]:", NSLocalizedString(@"AssistantText", nil)];
            break;
        default:
            break;
    }
    
    NSString *nameString = [NSString stringWithFormat:@"%@%@", roleString, messageModel.fromUser.userName];
    [self.nameLabel setText:nameString];
}

- (CGSize)sizeWithContent:(NSString *)string {
    CGSize labelSize = [string boundingRectWithSize:CGSizeMake(self.cellWidth - 38, 1000) options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f]} context:nil].size;
    return labelSize;
}
@end
