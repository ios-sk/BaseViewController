//
// SKProjectConfig.m
//
// Created on 2021/1/29
//

#import "SKProjectConfig.h"
#import "RTRootNavigationController.h"

@interface SKProjectConfig ()

@property (nonatomic, copy) Class<SKProjectConfigInterface> config;

@end

@implementation SKProjectConfig

static SKProjectConfig *_instence = nil;

+ (instancetype)shareInstence{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instence = [[self alloc] init];
    });
    return _instence;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instence = [super allocWithZone:zone];
    });
    return _instence;
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    return _instence;
}

- (nonnull id)mutableCopyWithZone:(nullable NSZone *)zone {
    return _instence;
}

+ (void)initProjectConfig:(Class<SKProjectConfigInterface>)projConfig{
    [SKProjectConfig shareInstence].config = projConfig;
}


+ (UIColor *)navTitleColor{
    return [SKProjectConfig shareInstence].config.navTitleColor;
}

+ (UIColor *)navBgColor{
    return [SKProjectConfig shareInstence].config.navBgColor;
}








+ (UIViewController *)windowRootC{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    
    if ([window subviews].count == 0) {
        return nil;
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]]){
        result = nextResponder;
    } else {
        result = window.rootViewController;
    }
    
    if ([result isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarVC = (UITabBarController *)result;
        result = tabBarVC.selectedViewController;
    }
    
    if ([result isKindOfClass:[RTRootNavigationController class]]) {
        RTRootNavigationController *rtNVC = (RTRootNavigationController *)result;
        result = rtNVC.rt_viewControllers.lastObject;
    }
    
    return result;
}

+ (UITabBarController *)tabbarC{
    id vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([vc isKindOfClass:[UINavigationController class]]) {
        if ([vc isKindOfClass:[UITabBarController class]]) {
            return vc;
        }else{
            return nil;
        }
    }
    if ([vc isKindOfClass:[UITabBarController class]]) {
        return vc;
    }
    return nil;
}

///当前nvc中的vc的数组
+ (NSArray<UIViewController *> *)currentVCList {
   return [self windowRootC].rt_navigationController.rt_viewControllers;
}

+ (void)removeViewController:(UIViewController *)controller{
    [[self windowRootC].rt_navigationController removeViewController:controller];
}

@end
