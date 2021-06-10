//
//  MCStudentViewCell.h
//  AgoraEducation
//
//  Created by yangmoumou on 2019/11/15.
//  Copyright © 2019 Agora. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCStudentViewCell : UITableViewCell
@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, strong) EduStream *stream;
@property (weak, nonatomic) IBOutlet UIButton *muteAudioButton;
@property (weak, nonatomic) IBOutlet UIButton *muteVideoButton;
@property (weak, nonatomic) IBOutlet UIButton *muteWhiteButton;
@end

NS_ASSUME_NONNULL_END
