//
//  UIColor+Extension.h
//  LibTools
//
//  Created by 晃悠 on 2021/1/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Extension)


//16进制转颜色值
+ (UIColor *)colorWithRGB:(NSInteger)rgbValue;

//16进制转颜色值带Alpha值
+ (UIColor *)colorWithRGB:(NSInteger)rgbValue alpha:(CGFloat)alpha;

//16进制转颜色值带亮度
+ (UIColor *)colorWithBrightness:(UIColor *)color brightness:(CGFloat)brightness;

//混合色 factor：混合因子
+ (UIColor *)colorWithBlendedColor:(UIColor *)color blendedColor:(UIColor *)blendedColor factor:(CGFloat)factor;

//由颜色得到RGBA数值
+ (uint32_t)RGBAValue:(UIColor *)color;

//由颜色得到RGBA描述
+ (NSString *)stringValue:(UIColor *)color;




// 随机色
+ (UIColor *)randomColor;

//随机颜色值带Alpha值
+ (UIColor *)colorRandomWithAlpha:(CGFloat)alpha;

- (UIImage *)imageWithColor;
- (NSString *)hexFromColor;


+ (UIColor *)colorWithHexStr:(NSString *)color;
+ (UIColor *)colorWithHexStr:(NSString *)color alpha:(CGFloat)alpha;


@end

NS_ASSUME_NONNULL_END
