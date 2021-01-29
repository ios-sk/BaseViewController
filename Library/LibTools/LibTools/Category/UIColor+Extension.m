//
//  UIColor+Extension.m
//  LibTools
//
//  Created by 晃悠 on 2021/1/20.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)


// 随机色
+ (UIColor *)randomColor{
    return [self colorRandomWithAlpha:1.0f];
}

//随机颜色值带Alpha值
+ (UIColor *)colorRandomWithAlpha:(CGFloat)alpha{
    CGFloat red =  (CGFloat)random() / (CGFloat)RAND_MAX;
    CGFloat blue = (CGFloat)random() / (CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)random() / (CGFloat)RAND_MAX;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

//16进制转颜色值
+ (UIColor *)colorWithRGB:(NSInteger)rgbValue{
    return [UIColor colorWithRGB:rgbValue alpha:1.0];
}

//16进制转颜色值带Alpha值
+ (UIColor *)colorWithRGB:(NSInteger)rgbValue alpha:(CGFloat)alpha{
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alpha];
}

//16进制转颜色值带亮度
+ (UIColor *)colorWithBrightness:(UIColor *)color brightness:(CGFloat)brightness{
    brightness = MAX(brightness, 0.0f);
    
    CGFloat rgba[4];
    [UIColor getRGBAComponents:color rgba:rgba];
    
    return [UIColor colorWithRed:rgba[0] * brightness
                           green:rgba[1] * brightness
                            blue:rgba[2] * brightness
                           alpha:rgba[3]];
}

//混合色 factor：混合因子
+ (UIColor *)colorWithBlendedColor:(UIColor *)color blendedColor:(UIColor *)blendedColor factor:(CGFloat)factor{
    factor = MIN(MAX(factor, 0.0f), 1.0f);
    
    CGFloat fromRGBA[4], toRGBA[4];
    [UIColor getRGBAComponents:color rgba:fromRGBA];
    [UIColor getRGBAComponents:blendedColor rgba:toRGBA];
    
    return [UIColor colorWithRed:fromRGBA[0] + (toRGBA[0] - fromRGBA[0]) * factor
                           green:fromRGBA[1] + (toRGBA[1] - fromRGBA[1]) * factor
                            blue:fromRGBA[2] + (toRGBA[2] - fromRGBA[2]) * factor
                           alpha:fromRGBA[3] + (toRGBA[3] - fromRGBA[3]) * factor];
}

//由颜色得到RGBA数值
+ (void)getRGBAComponents:(UIColor *)color rgba:(CGFloat[4])rgba{
    CGColorSpaceModel model = CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor));
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    switch (model)
    {
        case kCGColorSpaceModelMonochrome:
        {
            rgba[0] = components[0];
            rgba[1] = components[0];
            rgba[2] = components[0];
            rgba[3] = components[1];
            break;
        }
        case kCGColorSpaceModelRGB:
        {
            rgba[0] = components[0];
            rgba[1] = components[1];
            rgba[2] = components[2];
            rgba[3] = components[3];
            break;
        }
        case kCGColorSpaceModelCMYK:
        case kCGColorSpaceModelDeviceN:
        case kCGColorSpaceModelIndexed:
        case kCGColorSpaceModelLab:
        case kCGColorSpaceModelPattern:
        case kCGColorSpaceModelUnknown:
        case kCGColorSpaceModelXYZ:
        {
            
#ifdef DEBUG
            //unsupported format
            NSLog(@"Unsupported color model: %i", model);
#endif
            rgba[0] = 0.0f;
            rgba[1] = 0.0f;
            rgba[2] = 0.0f;
            rgba[3] = 1.0f;
            break;
        }
    }
}

//由颜色得到RGBA数值
+ (uint32_t)RGBAValue:(UIColor *)color
{
    CGFloat rgba[4];
    [UIColor getRGBAComponents:color rgba:rgba];
    uint8_t red = rgba[0]*255;
    uint8_t green = rgba[1]*255;
    uint8_t blue = rgba[2]*255;
    uint8_t alpha = rgba[3]*255;
    return (red << 24) + (green << 16) + (blue << 8) + alpha;
}

//由颜色得到RGBA描述
+ (NSString *)stringValue:(UIColor *)color
{
    //include alpha component
    return [NSString stringWithFormat:@"#%.8x", [UIColor RGBAValue:color] ];
}


- (NSString *)hexFromColor{
    
    UIColor *color = self;
    
    if(CGColorGetNumberOfComponents(color.CGColor) < 4) {
        
        const CGFloat *components =CGColorGetComponents(color.CGColor);
        
        color = [UIColor colorWithRed:components[0]
                 
                               green:components[0]
                 
                                blue:components[0]
                 
                               alpha:components[1]];
        
    }
    
    if(CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) !=kCGColorSpaceModelRGB) {
        
        return [NSString stringWithFormat:@"#FFFFFF"];
        
    }
    
    NSString *r,*g,*b;
    
    (int)((CGColorGetComponents(color.CGColor))[0]*255.0) == 0?(r =[NSString stringWithFormat:@"0%x",(int)((CGColorGetComponents(color.CGColor))[0]*255.0)]):(r= [NSString stringWithFormat:@"%x",(int)((CGColorGetComponents(color.CGColor))[0]*255.0)]);
    
    (int)((CGColorGetComponents(color.CGColor))[1]*255.0)== 0?(g = [NSString stringWithFormat:@"0%x",(int)((CGColorGetComponents(color.CGColor))[1]*255.0)]):(g= [NSString stringWithFormat:@"%x",(int)((CGColorGetComponents(color.CGColor))[1]*255.0)]);
    
    (int)((CGColorGetComponents(color.CGColor))[2]*255.0)== 0?(b = [NSString stringWithFormat:@"0%x",(int)((CGColorGetComponents(color.CGColor))[2]*255.0)]):(b= [NSString stringWithFormat:@"%x",(int)((CGColorGetComponents(color.CGColor))[2]*255.0)]);
    
    return [NSString stringWithFormat:@"#%@%@%@",r,g,b];
    
    
}

+ (UIColor *)colorWithHexStr:(NSString *)color {
    return [self colorWithHexStr:color alpha:1.0f];
}

+ (UIColor *)colorWithHexStr:(NSString *)color alpha:(CGFloat)alpha {
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    // 删除字符串中的空格，并转化为大写字母
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // 如果是 # 开头的，那么截取字符串，字符串从索引为 1 的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    // 如果是 0x 开头的，那么截取字符串，字符串从索引为 2 的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }
    
    NSUInteger lenght = [cString length];
    // RGB  RGBA  RRGGBB  RRGGBBAA
    if (lenght != 3 &&
        lenght != 4 &&
        lenght != 6 &&
        lenght != 8) {
        return [UIColor clearColor];
    }
    
    // 将相应的字符串转换为数字
    if (lenght < 5) {
        red = hexStrToInt([cString substringWithRange:NSMakeRange(0, 1)]) / 255.0f;
        green = hexStrToInt([cString substringWithRange:NSMakeRange(1, 1)]) / 255.0f;
        blue = hexStrToInt([cString substringWithRange:NSMakeRange(2, 1)]) / 255.0f;
    } else {
        red = hexStrToInt([cString substringWithRange:NSMakeRange(0, 2)]) / 255.0f;
        green = hexStrToInt([cString substringWithRange:NSMakeRange(2, 2)]) / 255.0f;
        blue = hexStrToInt([cString substringWithRange:NSMakeRange(4, 2)]) / 255.0f;
    }
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

// 內联函数，
static inline NSUInteger hexStrToInt(NSString *colorStr) {
    unsigned int result;
    [[NSScanner scannerWithString:colorStr] scanHexInt:&result];
    return result;
}

- (UIImage *)imageWithColor{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,self.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}

@end
