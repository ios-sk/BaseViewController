//
// BaseViewController.m
//
// Created on 2021/1/20
//

#import "BaseViewController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "BaseNavBarItem.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)dealloc{
    NSLog(@"%@释放了", NSStringFromClass(self.class));
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enable = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _pageIndex = 0;
    [self requestData];
}

#pragma mark 导航条
/**
 * 设置标题
 */
- (void)setNavTitle:(NSString *)text{
    self.navigationItem.title = text;
}

/**
 * 设置标题和颜色
 */
- (void)setNavTitle:(NSString *)text color:(UIColor *)color{
    self.navigationItem.title = text;
    self.navigationController.navigationBar.titleTextAttributes= @{NSForegroundColorAttributeName:color};
    self.navigationController.navigationBar.tintColor = color;
    self.navigationController.navigationBar.barTintColor = color;
}

/// 设置导航栏的背景颜色
- (void)setNavBackgroundColor:(UIColor *)color{
    UIImage *image = [UIImage imageWithColor:color];
    [self setNavBackgroundImage:image];
}

/// 设置导航栏的背景颜色 透明度
- (void)setNavBackgroundColor:(UIColor *)color alpha:(CGFloat)alpha{
    UIImage *image = [UIImage imageWithColor:[color colorWithAlphaComponent:alpha]];
    self.navigationController.navigationBar.translucent = YES;
    [self setNavBackgroundImage:image];
}

/// 设置导航栏的背景图片
- (void)setNavBackgroundImage:(UIImage *)image{
    image = [image resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
    self.navigationController.navigationBar.backIndicatorImage = [UIImage new] ;
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage new];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
}

/// 设置左按钮
- (void)setNavLeftBtn:(NSString *)content{
    if (!content.length)  return;

    UIView *buttonView;
    if([content rangeOfString:@".png"].location == NSNotFound){
        buttonView = [BaseNavBarItem navItemTitle:content bgColor:UIColor.clearColor textColor:UIColor.whiteColor clickHandle:^{
            [self leftButtonTouch];
        }];
    } else {
        buttonView = [BaseNavBarItem navItemImageName:content clickHandle:^{
            [self leftButtonTouch];
        }];
    }
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonView];
}

/// 设置右按钮
- (void)setNavRightBtn:(NSString *)content{
    
    if (!content.length)  return;
    
    UIView *buttonView;
    if([content rangeOfString:@".png"].location == NSNotFound){
        buttonView = [BaseNavBarItem navItemTitle:content bgColor:UIColor.clearColor textColor:UIColor.whiteColor clickHandle:^{
            [self leftButtonTouch];
        }];
    } else {
        buttonView = [BaseNavBarItem navItemImageName:content clickHandle:^{
            [self leftButtonTouch];
        }];
    }
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonView];
}

/// 设置多个右按钮
/// @param contents 右按钮标题 可以是文字 图片 图片必须以 .png 结尾
/// @param callBack 点击事件 index 从 0 开始
- (void)setNavRightBtns:(NSArray *)contents callBack:(void (^)(NSInteger index))callBack;{
    
    NSMutableArray *btnArray = [NSMutableArray arrayWithCapacity:contents.count];
    for (int i = 0; i < contents.count; i++) {
        NSString *content = contents[i];

        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        btn.frame = CGRectMake(0, 0, 40, 40);
        btn.tag = 10000 + i;
        
        if([content rangeOfString:@".png"].location == NSNotFound){
            [btn setTitle:content forState:(UIControlStateNormal)];
        } else {
            [btn setImage:[UIImage imageNamed:content] forState:UIControlStateNormal];
        }
    
        [btn addTapActionWithBlock:^{
            if (callBack) {
                callBack(btn.tag - 10000);
            }
        }];

        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [btnArray addObject:[[UIBarButtonItem alloc] initWithCustomView:btn]];
    }
    self.navigationItem.rightBarButtonItems = btnArray;
}

/// nav底部的线
- (void)setBottomLineColor:(UIColor *)color{
    UIImage *lineImage = [UIImage imageWithColor:color];
    self.navigationController.navigationBar.shadowImage = lineImage;
}

#pragma mark - 导航栏左右item事件
- (void)leftButtonTouch{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightButtonTouch{
    
}

#pragma mark 公用方法
/**
 * 网络请求
 */
- (void)requestData{
    
}

#pragma mark - MJRefresh
- (MJRefreshNormalHeader *)setRefreshNormalHeaderParameter:(MJRefreshNormalHeader *)header{
    return header;
}
- (MJRefreshBackNormalFooter *)setRefreshBackNormalFooterParameter:(MJRefreshBackNormalFooter *)footer{
    return footer;
}
- (MJRefreshAutoNormalFooter *)setRefreshAutoNormalFooterParameter:(MJRefreshAutoNormalFooter *)footer{
    return footer;
}

/// 重写
- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action{
    return [[UIBarButtonItem alloc] initWithCustomView:[BaseNavBarItem navBackBtnTitle:@"返回" target:target action:action]];
}

@end
