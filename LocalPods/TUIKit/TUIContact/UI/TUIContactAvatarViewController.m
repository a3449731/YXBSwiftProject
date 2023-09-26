#import "TUIContactAvatarViewController.h"
#import "ReactiveObjC/ReactiveObjC.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "UIView+TUILayout.h"
#import "TUICommonModel.h"
#import "TUIDefine.h"

@interface TUIContactAvatarViewController ()<UIScrollViewDelegate>
@property UIImageView *avatarView;

@property TUIScrollView *avatarScrollView;

@property UIImage *saveBackgroundImage;
@property UIImage *saveShadowImage;

@end

@implementation TUIContactAvatarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.saveBackgroundImage = [self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault];
    self.saveShadowImage = self.navigationController.navigationBar.shadowImage;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];

    //Fix  translucent = NO;
    CGRect rect = self.view.bounds;
    if (![UINavigationBar appearance].isTranslucent && [[[UIDevice currentDevice] systemVersion] doubleValue]<15.0) {
        rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height - TabBar_Height - NavBar_Height );
    }
    self.avatarScrollView = [[TUIScrollView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.avatarScrollView];
    self.avatarScrollView.backgroundColor = [UIColor blackColor];
    self.avatarScrollView.frame = rect;

    self.avatarView = [[UIImageView alloc] initWithImage:self.avatarData.avatarImage];
    self.avatarScrollView.imageView = self.avatarView;
    self.avatarScrollView.maximumZoomScale = 4.0;
    self.avatarScrollView.delegate = self;

    self.avatarView.image = self.avatarData.avatarImage;
    TUICommonContactProfileCardCellData *data = self.avatarData;
    /*
     @weakify(self)
    [RACObserve(data, avatarUrl) subscribeNext:^(NSURL *x) {
        @strongify(self)
        [self.avatarView sd_setImageWithURL:x placeholderImage:self.avatarData.avatarImage];
    }];
    */
    @weakify(self)
    [RACObserve(data, avatarUrl) subscribeNext:^(NSURL *x) {
        @strongify(self)
        [self.avatarView sd_setImageWithURL:x placeholderImage:self.avatarData.avatarImage];
        [self.avatarScrollView setNeedsLayout];
    }];

}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.avatarView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
}

- (void)willMoveToParentViewController:(UIViewController *)parent
{
    if (parent == nil) {
        [self.navigationController.navigationBar setBackgroundImage:self.saveBackgroundImage
                                                      forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.shadowImage = self.saveShadowImage;
    }
}

@end
