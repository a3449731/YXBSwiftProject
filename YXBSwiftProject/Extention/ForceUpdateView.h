//
//  ForceUpdateView.h
//  NIM
//
//  Created by Alex on 2020/4/10.
//  Copyright © 2020 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ForceUpdateView : UIView

@property(nonatomic, weak) IBOutlet UILabel *lblTitle;
@property(nonatomic, weak) IBOutlet UITextView *textContent;
@property(nonatomic, weak) IBOutlet UIButton *btnUpdateNow;
@property(nonatomic, weak) IBOutlet UIButton *btnClose;

@end

NS_ASSUME_NONNULL_END
