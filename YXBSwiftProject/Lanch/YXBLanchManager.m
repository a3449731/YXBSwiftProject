//
//  YXBLanchManager.m
//  YXBProject
//
//  Created by 杨 on 2018/6/8.
//  Copyright © 2018年 杨. All rights reserved.
//

#import "YXBLanchManager.h"
#import <XHLaunchAd/XHLaunchAd.h>
#import <EAIntroView/EAIntroView.h>
#import "LanchAPI.h"

static NSString * const sampleDescription1 = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
static NSString * const sampleDescription2 = @"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore.";
static NSString * const sampleDescription3 = @"Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.";
static NSString * const sampleDescription4 = @"Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit.";

@interface YXBLanchManager()<XHLaunchAdDelegate,EAIntroDelegate>


@end


@implementation YXBLanchManager

//+ load 作为 Objective-C 中的一个方法，与其它方法有很大的不同。它只是一个在整个文件被加载到运行时，在 main 函数调用之前被 ObjC 运行时调用的钩子方法。其中关键字有这么几个：
//
//文件刚加载
//main 函数之前
//钩子方法
+ (void)load {
    [self shareManager];
}

+ (YXBLanchManager *)shareManager {
    static YXBLanchManager *instance = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken,^{
        instance = [[YXBLanchManager alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        //在UIApplicationDidFinishLaunching时初始化开屏广告,做到对业务层无干扰,当然你也可以直接在AppDelegate didFinishLaunchingWithOptions方法中初始化
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            
            BOOL isFirst = [self firstStart];
            BOOL isUpadate = [self isUpdataFirstRun];
            if (isFirst || isUpadate) {
//                [XHLaunchAd setWaitDataDuration:1];
//                [self showIntroWithCustomView];
            } else {
//                //初始化开屏广告
//                [self setupXHLaunchAd];
            }
        }];
    }
    return self;
}

// 判断程序第一次启动
- (BOOL)firstStart {
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"yxb_bus_firstStart"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"yxb_bus_firstStart"];
        return YES;
    }else{
        return NO;
    }
}

// 判断程序是否更新后第一次启动
- (BOOL)isUpdataFirstRun {
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary]
                                objectForKey:@"CFBundleShortVersionString"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastRunKey = [defaults objectForKey:@"yxb_last_run_version_key"];
    if (!lastRunKey) {
        [defaults setObject:currentVersion forKey:@"yxb_last_run_version_key"];
        return YES;
        // App is being run for first time
        //上次运行版本为空，说明程序第一次运行
    }
    else if (![lastRunKey isEqualToString:currentVersion]) {
        [defaults setObject:currentVersion forKey:@"yxb_last_run_version_key"];
        return YES;
        // App has been updated since last run
        //有版本号，但是和当前版本号不同，说明程序已经更新了版本
    }
    return NO;
}



#pragma mark ---------- 引导页 -------------
- (void)showIntroWithCustomView {
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"Hello world";
    page1.desc = sampleDescription1;
    page1.bgImage = [UIImage imageNamed:@"bg1"];
    page1.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title1"]];
    
    UIView *viewForPage2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    UILabel *labelForPage2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 300, kScreenWidth, 30)];
    labelForPage2.text = @"Some custom view";
    labelForPage2.font = [UIFont systemFontOfSize:32];
    labelForPage2.textColor = [UIColor whiteColor];
    labelForPage2.backgroundColor = [UIColor clearColor];
    labelForPage2.transform = CGAffineTransformMakeRotation(M_PI_2*3);
    [viewForPage2 addSubview:labelForPage2];
    EAIntroPage *page2 = [EAIntroPage pageWithCustomView:viewForPage2];
    page2.bgImage = [UIImage imageNamed:@"bg2"];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"This is page 3";
    page3.desc = sampleDescription3;
    page3.bgImage = [UIImage imageNamed:@"bg3"];
    page3.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title3"]];
    
    EAIntroPage *page4 = [EAIntroPage page];
    page4.title = @"This is page 4";
    page4.desc = sampleDescription4;
    page4.bgImage = [UIImage imageNamed:@"bg4"];
    page4.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title4"]];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) andPages:@[page1,page2,page3,page4]];
    [intro.skipButton setTitle:@"Skip now" forState:UIControlStateNormal];
    [intro setDelegate:self];
    intro.tapToNext = YES;
    [intro showFullscreenWithAnimateDuration:0.3];
}

//- (void)introWillFinish:(EAIntroView *)introView wasSkipped:(BOOL)wasSkipped;
//- (void)introDidFinish:(EAIntroView *)introView wasSkipped:(BOOL)wasSkipped;
//- (void)intro:(EAIntroView *)introView pageAppeared:(EAIntroPage *)page withIndex:(NSUInteger)pageIndex;
//- (void)intro:(EAIntroView *)introView pageStartScrolling:(EAIntroPage *)page withIndex:(NSUInteger)pageIndex;
//- (void)intro:(EAIntroView *)introView pageEndScrolling:(EAIntroPage *)page withIndex:(NSUInteger)pageIndex;
//
//// Called for every incremental scroll event.
//// Parameter offset is some fraction of the currentPageIndex, between currentPageIndex-1 and currentPageIndex+1
//// For example, scrolling left and right from page 2 will values in the range [1..3], exclusive
//- (void)intro:(EAIntroView *)introView didScrollWithOffset:(CGFloat)offset;


#pragma mark ------  启动页  --------------
-(void)setupXHLaunchAd {
    //设置你工程的启动页使用的是:LaunchImage 还是 LaunchScreen.storyboard(不设置默认:LaunchImage)
    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchScreen];
    
    //1.因为数据请求是异步的,请在数据请求前,调用下面方法配置数据等待时间.
    //2.设为3即表示:启动页将停留3s等待服务器返回广告数据,3s内等到广告数据,将正常显示广告,否则将不显示
    //3.数据获取成功,配置广告数据后,自动结束等待,显示广告
    //注意:请求广告数据前,必须设置此属性,否则会先进入window的的根控制器
    [XHLaunchAd setWaitDataDuration:3];
    [self requestLanchPage];
}

- (void)requestLanchPage {
    LanchAPI *network = [[LanchAPI alloc] init];
    [network startWithCompletionBlockWithSuccess:^(__kindof LanchAPI * _Nonnull request) {
        LanchPageModel *model = [request jsonForModel];
        if (model) {
            [self configurePageWithModel:model];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (void)configurePageWithModel:(LanchPageModel *)model {
    if ([model.type integerValue] == 1 || [model.type integerValue] == 2) {
        [self lanchImage:model];
    }
    
    if ([model.type integerValue] == 3) {
        [self lanchVideo:model];
    }
}


- (void)lanchImage:(LanchPageModel *)model {
    //配置广告数据
    XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration new];
    //广告停留时间
    imageAdconfiguration.duration = model.duration;
    //广告frame
    imageAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 0.8);
    //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
    imageAdconfiguration.imageNameOrURLString = model.content;
    //设置GIF动图是否只循环播放一次(仅对动图设置有效)
    imageAdconfiguration.GIFImageCycleOnce = NO;
    //缓存机制(仅对网络图片有效)
    //为告展示效果更好,可设置为XHLaunchAdImageCacheInBackground,先缓存,下次显示
    imageAdconfiguration.imageOption = XHLaunchAdImageDefault;
    //图片填充模式
    imageAdconfiguration.contentMode = UIViewContentModeScaleAspectFill;
    //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
    imageAdconfiguration.openModel = model.openUrl;
    //广告显示完成动画
    imageAdconfiguration.showFinishAnimate =ShowFinishAnimateLite;
    //广告显示完成动画时间
    imageAdconfiguration.showFinishAnimateTime = 0.8;
    //跳过按钮类型
    imageAdconfiguration.skipButtonType = SkipTypeTimeText;
    //后台返回时,是否显示广告
    imageAdconfiguration.showEnterForeground = NO;
    
    //图片已缓存 - 显示一个 "已预载" 视图 (可选)
    if([XHLaunchAd checkImageInCacheWithURL:[NSURL URLWithString:model.content]]){
        //设置要添加的自定义视图(可选)
        imageAdconfiguration.subViews = [self launchAdSubViews_alreadyView];
        
    }
    //显示开屏广告
    [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
}

-(NSArray<UIView *> *)launchAdSubViews_alreadyView {
    
    CGFloat y = XH_IPHONEX ? 46:22;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-140, y, 60, 30)];
    label.text  = @"已预载";
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = 5.0;
    label.layer.masksToBounds = YES;
    label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    return [NSArray arrayWithObject:label];
    
}

- (void)lanchVideo:(LanchPageModel *)model {
    //配置广告数据
    XHLaunchVideoAdConfiguration *videoAdconfiguration = [XHLaunchVideoAdConfiguration new];
    //广告停留时间
    videoAdconfiguration.duration = model.duration;
    //广告frame
    videoAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    //广告视频URLString/或本地视频名(请带上后缀)
    //注意:视频广告只支持先缓存,下次显示(看效果请二次运行)
    videoAdconfiguration.videoNameOrURLString = model.content;
    //是否关闭音频
    videoAdconfiguration.muted = NO;
    //视频缩放模式
    videoAdconfiguration.videoGravity = AVLayerVideoGravityResizeAspectFill;
    //是否只循环播放一次
    videoAdconfiguration.videoCycleOnce = NO;
    //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
    videoAdconfiguration.openModel = model.openUrl;
    //广告显示完成动画
    videoAdconfiguration.showFinishAnimate =ShowFinishAnimateFadein;
    //广告显示完成动画时间
    videoAdconfiguration.showFinishAnimateTime = 0.8;
    //后台返回时,是否显示广告
    videoAdconfiguration.showEnterForeground = NO;
    //跳过按钮类型
    videoAdconfiguration.skipButtonType = SkipTypeTimeText;
    //视频已缓存 - 显示一个 "已预载" 视图 (可选)
    if([XHLaunchAd checkVideoInCacheWithURL:[NSURL URLWithString:model.content]]){
        //设置要添加的自定义视图(可选)
        videoAdconfiguration.subViews = [self launchAdSubViews_alreadyView];
    }
    [XHLaunchAd videoAdWithVideoAdConfiguration:videoAdconfiguration delegate:self];
}


#pragma mark - XHLaunchAd delegate - 其他
/**
 广告点击事件回调
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd clickAndOpenModel:(id)openModel clickPoint:(CGPoint)clickPoint {
    
    NSLog(@"广告点击事件");
    
    /** openModel即配置广告数据设置的点击广告时打开页面参数(configuration.openModel) */
    if(openModel==nil) return;
    
}

/**
 *  图片本地读取/或下载完成回调
 *
 *  @param launchAd  XHLaunchAd
 *  @param image 读取/下载的image
 *  @param imageData 读取/下载的imageData
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd imageDownLoadFinish:(UIImage *)image imageData:(NSData *)imageData {
    
    NSLog(@"图片下载完成/或本地图片读取完成回调");
}

/**
 *  视频本地读取/或下载完成回调
 *
 *  @param launchAd XHLaunchAd
 *  @param pathURL  视频保存在本地的path
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd videoDownLoadFinish:(NSURL *)pathURL {
    
    NSLog(@"video下载/加载完成 path = %@",pathURL.absoluteString);
}

/**
 *  视频下载进度回调
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd videoDownLoadProgress:(float)progress total:(unsigned long long)total current:(unsigned long long)current {
    
    NSLog(@"总大小=%lld,已下载大小=%lld,下载进度=%f",total,current,progress);
}

/**
 *  广告显示完成
 */
-(void)xhLaunchAdShowFinish:(XHLaunchAd *)launchAd {
    
    NSLog(@"广告显示完成");
}

@end
