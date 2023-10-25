//
//  SPPlayMP4ViewController.m
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/10/24.
//  Copyright © 2023 ShengChang. All rights reserved.
//

#import "SPPlayMP4ViewController.h"
#import "YXBSwiftProject-Swift.h"


@interface SPPlayMP4ViewController ()

@property (nonatomic, strong) PlayMP4View *joinPlayer;

//@property (nonatomic, strong) PlayVapView *joinPlayer;

@end

@implementation SPPlayMP4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    [button setTitle:@"播放" forState:(UIControlStateNormal)];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(50);
    }];
    [button addTarget:self action:@selector(playAction:) forControlEvents:(UIControlEventTouchUpInside)];
//
//    NSString *urlString = @"https://lanqi123.oss-cn-beijing.aliyuncs.com/lanqi/file/1697599934577.webp";
//    NSURL *imgUrl = [NSURL URLWithString:urlString];
////    [_imageView sd_setImageWithURL:imgUrl];
//    UIImageView *imageView = [[UIImageView alloc] init];
//    [imageView sd_setImageWithURL:imgUrl];
//    [self.view addSubview:imageView];
//    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(200);
//        make.width.height.mas_equalTo(100);
//        make.centerX.mas_equalTo(0);
//    }];
    
    self.joinPlayer = [[PlayMP4View alloc] init];
    self.joinPlayer.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.joinPlayer];
    [self.joinPlayer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    [self.joinPlayer startMP4WithUrlString:@"https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1697693633395.mp4"];

    
}

- (void)playAction:(UIButton *)button {
//    /Users/lanqihuyu/Desktop/YXBSwiftProject/YXBSwiftProject/Classes/首页/主页/video.mp4
    // 座驾
    // https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1698042378272.mp4
    
    // 座驾2
    // https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1697693633395.mp4
    
    // https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1697693633395.mp4
    
    // 入场特效
    // https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1698128757190.mp4

    
    // webp头像
    // https://lanqi123.oss-cn-beijing.aliyuncs.com/lanqi/file/1697599934577.webp
    
//    [self.joinPlayer startMP4WithUrlString:@"https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1698128757190.mp4"];
    
    [self.view makeToast:@"响应了button"];        
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
