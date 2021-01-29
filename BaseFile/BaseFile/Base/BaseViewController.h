//
// BaseViewController.h
//
// Created on 2021/1/20
//

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

/// 列表页码
@property (nonatomic, assign) NSInteger pageIndex;

#pragma mark 导航条
/// 设置标题
- (void)setNavTitle:(NSString *)text;

/// 设置标题和颜色
- (void)setNavTitle:(NSString *)text color:(UIColor *)color;

/// 设置导航栏的背景颜色
- (void)setNavBackgroundColor:(UIColor *)color;

/// 设置导航栏的背景颜色 透明度
- (void)setNavBackgroundColor:(UIColor *)color alpha:(CGFloat)alpha;

/// 设置导航栏的背景图片
- (void)setNavBackgroundImage:(UIImage *)image;

/// 设置左按钮
- (void)setNavLeftBtn:(NSString *)content;

/// 设置右按钮
- (void)setNavRightBtn:(NSString *)content;

/// 设置多个右按钮
/// @param contents 右按钮标题 可以是文字 图片 图片必须以 .png 结尾
/// @param callBack 点击事件 index 从 0 开始
- (void)setNavRightBtns:(NSArray *)contents callBack:(void (^)(NSInteger index))callBack;

/// nav底部的线
- (void)setBottomLineColor:(UIColor *)color;

#pragma mark - 导航栏左右item事件
- (void)leftButtonTouch;

- (void)rightButtonTouch;

#pragma mark 公用方法

/// 网络请求
- (void)requestData;

#pragma mark - MJRefresh
- (MJRefreshNormalHeader *)setRefreshNormalHeaderParameter:(MJRefreshNormalHeader *)header;
- (MJRefreshBackNormalFooter *)setRefreshBackNormalFooterParameter:(MJRefreshBackNormalFooter *)footer;
- (MJRefreshAutoNormalFooter *)setRefreshAutoNormalFooterParameter:(MJRefreshAutoNormalFooter *)footer;


@end

NS_ASSUME_NONNULL_END
