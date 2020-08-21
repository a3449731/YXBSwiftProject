//
//  LYLWKWebView.h
//  LYLWKWebView
//
//  Created by YangXiaoBin on 2017/3/21.
//  Copyright © 2017年 YangXiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

typedef void(^LXWkFinishNavigation)(CGFloat contentHeight);

@interface LYLWKWebView : UIView

@property(nonatomic,strong)WKWebView *webView;

@property(nonatomic, strong)UIProgressView *progressView;

@property (nonatomic, copy) LXWkFinishNavigation webviewContentHeight;

@end
