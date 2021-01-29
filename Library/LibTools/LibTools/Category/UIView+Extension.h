//
//  UIView+Extension.h
//  LibTools
//
//  Created by 晃悠 on 2021/1/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Extension)

- (void)cornerRadii:(CGSize)size byRoundingCorners:(UIRectCorner)corners;

/// 添加渐变色
- (void)addGradientColorWith:(NSArray *)gradientColors percentage:(NSArray *)percents;

/// 开始旋转动画
-(void)startRotateAnimating:(CGFloat)duration;

/// 结束旋转动画
-(void)stopRotateAnimating;

///通过view创建image
- (UIImage *)generateToImage;


/// 设置圆角
/// @param radius 圆角大小
- (void)setCornerRadius:(CGFloat)radius;

/// 设置圆角
/// @param radius 圆角大小
/// @param corners 圆角方位
- (void)setCornerRadius:(CGFloat)radius rectCorner:(UIRectCorner)corners;

/// 设置边框
/// @param color 边框颜色
/// @param width 边框宽度
- (void)setBorderColor:(UIColor *)color borderWidth:(CGFloat)width;


//设置图层抖动

/**
 视图是否晃动

 @param shake YES 开始晃动 NO停止晃动
 */
- (void)shakeAnimation:(BOOL)shake;


/**
 类似心脏跳动 跳一次
 */
- (void)showShakeAnimation;


/**
 左右晃动
 */
- (void)shakeAction;

// 上下晃动
- (void)shakeAction_top_bottom;

/**
 视图消失
 */
- (void)dissAnimation;

/**
* 缩放动画
*/
- (void)zoomAnimation;
- (void)dissZoomAnimation;

/**
 * 跳动动画
 */
- (void)popJumpAnimation;
- (void)dissPopJumpAnimation;

/**
 * 添加点赞动画
 */
-(void)showGiveLikeAnimation;

@end

NS_ASSUME_NONNULL_END
