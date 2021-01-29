//
//  NSString+Size.h
//  LibTools
//
//  Created by 晃悠 on 2021/1/20.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Size)


/// 计算文字高度
/// @param font 文字大小
- (CGFloat)heightWithFont:(UIFont *)font;

/**
 *  @brief 计算文字的高度
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGFloat)heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;
/**
 *  @brief 计算文字的宽度
 *
 *  @param font   字体(默认为系统字体)
 *  @param height 约束高度
 */
- (CGFloat)widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

/**
 *  @brief 计算文字的大小
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGSize)sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;
/**
 *  @brief 计算文字的大小
 *
 *  @param font   字体(默认为系统字体)
 *  @param height 约束高度
 */
- (CGSize)sizeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

/**
 *  @brief  反转字符串
 *
 *  @param strSrc 被反转字符串
 *
 *  @return 反转后字符串
 */
+ (NSString *)reverseString:(NSString *)strSrc;

/**
 设置字符串行间距
 
 @param font 字体
 @param paragraph 行间距
 @param width 宽度
 @param textString 字符串
 @return CGSize
 */
- (CGSize)heightWithFont:(UIFont *)font paragraph:(CGFloat)paragraph constrainedToWidth:(CGFloat)width textString:(NSString *)textString;



/// 获取带有行间距的文字size
/// @param width  宽度
/// @param font 尺寸
/// @param lineSpacing 行间距
- (CGSize)contentSizeWithWidth:(CGFloat)width
                          font:(UIFont *)font
                   lineSpacing:(CGFloat)lineSpacing;


///是否只有一行
- (BOOL)contentHaveOneLinesWithWidth:(CGFloat)width
                                font:(UIFont *)font
                         lineSpacing:(CGFloat)lineSpacing;

@end

NS_ASSUME_NONNULL_END
