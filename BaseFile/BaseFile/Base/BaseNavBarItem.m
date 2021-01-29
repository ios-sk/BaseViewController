//
// BaseNavBarItem.m
//
// Created on 2021/1/29
//

#import "BaseNavBarItem.h"

@implementation BaseNavBarItem

+ (UIView *)navItemTitle:(NSString *)title bgColor:(UIColor *)bgColor textColor:(UIColor *)textColor clickHandle:(void (^)(void))handle{
    UIButton *btn = [UIButton buttonWithType:0];
    btn.layer.masksToBounds=YES;
    btn.layer.cornerRadius = 4.0;
    CGSize size = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    btn.frame = CGRectMake(0, 0, size.width+15, 18);
    btn.backgroundColor = bgColor?bgColor:[UIColor clearColor];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:textColor?textColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn addTapActionWithBlock:^{
        if(handle){
            handle();
        }
    }];
    return btn;
}

+ (UIView *)navItemImageName:(NSString *)imageName clickHandle:(void (^)(void))handle{
    UIButton *btn = [UIButton buttonWithType:0];
    [btn setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 40, 40);
    [btn setImageEdgeInsets:UIEdgeInsetsMake(6, 10, 6, 2)];
    [btn addTapActionWithBlock:^{
        if(handle){
            handle();
        }
    }];
    return btn;
}

+ (void)navbar:(UIViewController *)vc bgImage:(UIImage *)image foregroundColor:(UIColor *)color{
    
    UIImage *naviBgImage = image?image:[UIImage imageNamed:@"main-navbar-transparent"];
    naviBgImage = [naviBgImage resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
    /** 设置导航栏背景图片 */
    UINavigationController *nvc = [vc isKindOfClass:[UINavigationController class]]? (UINavigationController *)vc:vc.navigationController;
    
    [nvc.navigationBar setBackgroundImage:naviBgImage forBarMetrics:UIBarMetricsDefault];

    nvc.navigationBar.backIndicatorImage = nil;
    nvc.navigationBar.backIndicatorTransitionMaskImage = nil;
    nvc.navigationBar.titleTextAttributes= @{NSForegroundColorAttributeName:color?color:[UIColor whiteColor]};
}

+ (UIView *)navBackBtnImage:(UIImage *)image target:(id)target action:(SEL)action{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 40);
    [btn setImage:image forState:UIControlStateNormal];
    [btn setContentEdgeInsets:UIEdgeInsetsMake(14, 0, 14, 28)];
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

    return btn;
}

+ (UIView *)navBackBtnTitle:(NSString *)title target:(id)target action:(SEL)action{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 40);
    [btn setTitle:title forState:(UIControlStateNormal)];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setContentEdgeInsets:UIEdgeInsetsMake(14, 0, 14, 28)];
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

    return btn;
}

+(void)setNaviBarBackClear:(UINavigationController *)navi themeColor:(UIColor *)color{
    
    [navi.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [navi.navigationBar setShadowImage:[UIImage new]];
    if (color) {
    
        navi.navigationBar.titleTextAttributes= @{NSForegroundColorAttributeName:color};
        navi.navigationBar.tintColor = color;
        navi.navigationBar.barTintColor = color;
    }
    
}

@end
