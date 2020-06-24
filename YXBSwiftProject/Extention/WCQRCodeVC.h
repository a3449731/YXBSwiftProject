//
//  WCQRCodeVC.h
//  SGQRCodeExample
//
//  Created by YangXiaoBin on 17/3/20.
//  Copyright © 2017年 YangXiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CodeBlock)(NSString *);

@interface WCQRCodeVC : UIViewController

@property (copy, nonatomic) CodeBlock codeBlock;

@end
