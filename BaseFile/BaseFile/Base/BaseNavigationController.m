//
//  BaseNavigationController.m
//  BaseFile
//
//  Created by 晃悠 on 2021/1/19.
//  Copyright © 2021  . All rights reserved.
//

#import "BaseNavigationController.h"
#import "SKProjectConfig.h"
#import "ViewController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (instancetype)initWithMainRootViewController{
    [self setNavigationBarStyle];
    ViewController *vc = [[ViewController alloc] init];
    return [self initWithRootViewController:vc];
}

/// 统一配置nav
- (void)setNavigationBarStyle{
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    /// nav背景颜色
    UIImage *naviBgImage = [UIImage imageWithColor:SKProjectConfig.navBgColor];
    naviBgImage = [naviBgImage resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
    [navBar setBackgroundImage:naviBgImage forBarMetrics:UIBarMetricsDefault];
    
    /// nav文字颜色
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName:SKProjectConfig.navTitleColor}];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count == 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    } else {
        viewController.hidesBottomBarWhenPushed = NO;
    }
    [super pushViewController:viewController animated:animated];
}

- (NSArray<__kindof UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    // 解决iOS 14 popToRootViewController tabbar不自动显示问题
    if (animated) {
        UIViewController *popController = self.viewControllers.lastObject;
        popController.hidesBottomBarWhenPushed = NO;
    }
    return [super popToRootViewControllerAnimated:animated];
}

@end
