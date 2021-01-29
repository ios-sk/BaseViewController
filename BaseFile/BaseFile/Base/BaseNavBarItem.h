//
// BaseNavBarItem.h
//
// Created on 2021/1/29
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseNavBarItem : NSObject

///navigationbar上面的统一按钮
+ (UIView *)navItemTitle:(NSString *)title bgColor:(UIColor * __nullable)bgColor textColor:(UIColor * __nullable)textColor clickHandle:(void(^ __nullable)(void))handle;

///设定导航栏上带图片的按钮
+ (UIView *)navItemImageName:(NSString *)imageName clickHandle:(void(^ __nullable)(void))handle;

/// 设定导航栏背景图片
/// @param vc 控制起
/// @param image  不传图片默认为空白导航栏
/// @param color 不传文字颜色默认白色
+ (void)navbar:(UIViewController *)vc bgImage:(UIImage * _Nullable)image foregroundColor:(UIColor * __nullable)color;

///返回按钮
+ (UIView *)navBackBtnImage:(UIImage *)image target:(nullable id)target action:(SEL)action;
+ (UIView *)navBackBtnTitle:(NSString *)title target:(id)target action:(SEL)action;

///设置导航栏透明及字体颜色
+ (void)setNaviBarBackClear:(UINavigationController *)navi themeColor:(UIColor *)color;


@end

NS_ASSUME_NONNULL_END
