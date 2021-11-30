//
//  YXBTransitionDefine.h
//  MyProject
//
//  Created by YangXiaoBin on 2019/11/12.
//  Copyright © 2019 YangXiaoBin. All rights reserved.
//

#ifndef YXBTransitionDefine_h
#define YXBTransitionDefine_h

#import <UIKit/UIKit.h>
#import <MZFormSheetPresentationController/MZFormSheetPresentationViewController.h>


/**
 快捷方法
 参数传控制器标题即可
 */
#define AC_SETUP_NAVIGATION_ITEM(args) - (void)setupNavigationItem {\
    UINavigationItem *item = self.navigationItem;\
    item.title = args;\
    item.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return"] style:(UIBarButtonItemStylePlain) target:self action:@selector(backToPreviousViewController)];\
}\
AC_BACK_TO_PREVIOUS


/**
 返回上一级控制器
 */
#define AC_BACK_TO_PREVIOUS - (IBAction)backToPreviousViewController {\
    if (self.navigationController) {\
        if (self.navigationController.childViewControllers.count > 1) {\
            [self.navigationController popViewControllerAnimated:YES];\
        } else {\
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];\
        }\
    } else {\
        [self dismissViewControllerAnimated:YES completion:nil];\
    }\
}
#define PUSH(vc) [getCuttentViewController().navigationController pushViewController:vc animated:YES];
#define POP [getCuttentViewController().navigationController popViewControllerAnimated:YES];
#define POPTOROOT [getCuttentViewController().navigationController popToRootViewControllerAnimated:YES];
#define PRESENT(vc) [getCuttentViewController() presentViewController:vc animated:YES completion:nil];

NS_INLINE UIViewController * getCuttentViewController(){
    UIViewController *vc = nil;
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    if ([window.rootViewController isKindOfClass:[UINavigationController class]]){
        vc = [(UINavigationController *)window.rootViewController topViewController];
    }else if ([window.rootViewController isKindOfClass:[UITabBarController class]]){
        UITabBarController *tabVC = (UITabBarController*)window.rootViewController;
        vc = [(UINavigationController *)[tabVC selectedViewController] topViewController];
    }
    else{
        vc = window.rootViewController;
    }
    return vc;
}


NS_INLINE void InvalidateScrollViewAdjustBehavior(UIViewController *vc, UIScrollView *scrollView) {
    if (@available(iOS 11.0, *)) {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        vc.automaticallyAdjustsScrollViewInsets = NO;
    }
}

#pragma mark ---------- 模态推出的方法 ------------
NS_INLINE MZFormSheetPresentationViewController *SheetPresentVC(UIViewController *vc, CGRect rect) {
    MZFormSheetPresentationViewController *formSheetController = [[MZFormSheetPresentationViewController alloc] initWithContentViewController:vc];
    formSheetController.contentViewControllerTransitionStyle = MZFormSheetPresentationTransitionStyleSlideFromBottom;
    formSheetController.allowDismissByPanningPresentedView = YES;
    formSheetController.presentationController.shouldDismissOnBackgroundViewTap = YES;
    formSheetController.presentationController.frameConfigurationHandler = ^CGRect(UIView * _Nonnull presentedView, CGRect currentFrame, BOOL isKeyboardVisible) {
        return rect;
    };
    PRESENT(formSheetController);
    return formSheetController;
}


#endif /* YXBTransitionDefine_h */
