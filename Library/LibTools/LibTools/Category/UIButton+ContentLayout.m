//
//  UIButton+ContentLayout.m
//  LibTools
//
//  Created by 晃悠 on 2020/12/17.
//

#import "UIButton+ContentLayout.h"
#import <objc/runtime.h>


static NSString * const kButtonContentLayoutStyleKey = @"ButtonContentLayoutStyleKey";
static NSString * const kButtonContentPaddingKey = @"ButtonContentPaddingKey";
static NSString * const kButtonContentPaddingInsetKey = @"ButtonContentPaddingInsetKey";

@implementation UIButton (ContentLayout)

- (void)setupButtonLayout{
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    CGFloat image_w = self.imageView.frame.size.width;
    CGFloat image_h = self.imageView.frame.size.height;
    
    CGFloat title_w = self.titleLabel.frame.size.width;
    CGFloat title_h = self.titleLabel.frame.size.height;
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0){
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        title_w = self.titleLabel.intrinsicContentSize.width;
        title_h = self.titleLabel.intrinsicContentSize.height;
    }
    
    UIEdgeInsets imageEdge = UIEdgeInsetsZero;
    UIEdgeInsets titleEdge = UIEdgeInsetsZero;
    
    if (self.buttonContentPaddingInset == 0){
        self.buttonContentPaddingInset = 5;
    }

    switch (self.buttonContentLayoutStyle) {
        case ButtonContentLayoutStyleNormal:{
            titleEdge = UIEdgeInsetsMake(0, self.buttonContentPadding, 0, 0);
            imageEdge = UIEdgeInsetsMake(0, 0, 0, self.buttonContentPadding);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        }
            break;
        case ButtonContentLayoutStyleCenterImageRight:{
            titleEdge = UIEdgeInsetsMake(0, -image_w - self.buttonContentPadding, 0, image_w);
            imageEdge = UIEdgeInsetsMake(0, title_w + self.buttonContentPadding, 0, -title_w);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        }
            break;
        case ButtonContentLayoutStyleCenterImageTop:{
            titleEdge = UIEdgeInsetsMake(0, -image_w, -image_h - self.buttonContentPadding, 0);
            imageEdge = UIEdgeInsetsMake(-title_h - self.buttonContentPadding, 0, 0, -title_w);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        }
            break;
        case ButtonContentLayoutStyleCenterImageBottom:{
            titleEdge = UIEdgeInsetsMake(-image_h - self.buttonContentPadding, -image_w, 0, 0);
            imageEdge = UIEdgeInsetsMake(0, 0, -title_h - self.buttonContentPadding, -title_w);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        }
            break;
        case ButtonContentLayoutStyleLeftImageLeft:{
            titleEdge = UIEdgeInsetsMake(0, self.buttonContentPadding + self.buttonContentPaddingInset, 0, 0);
            imageEdge = UIEdgeInsetsMake(0, self.buttonContentPaddingInset, 0, 0);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        }
            break;
        case ButtonContentLayoutStyleLeftImageRight:{
            titleEdge = UIEdgeInsetsMake(0, -image_w + self.buttonContentPaddingInset, 0, 0);
            imageEdge = UIEdgeInsetsMake(0, title_w + self.buttonContentPadding + self.buttonContentPaddingInset, 0, 0);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        }
            break;
        case ButtonContentLayoutStyleRightImageLeft:{
            imageEdge = UIEdgeInsetsMake(0, 0, 0, self.buttonContentPadding + self.buttonContentPaddingInset);
            titleEdge = UIEdgeInsetsMake(0, 0, 0, self.buttonContentPaddingInset);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        }
            break;
        case ButtonContentLayoutStyleRightImageRight:{
            titleEdge = UIEdgeInsetsMake(0, -self.frame.size.width / 2, 0, image_w + self.buttonContentPadding + self.buttonContentPaddingInset);
            imageEdge = UIEdgeInsetsMake(0, 0, 0, -title_w + self.buttonContentPaddingInset);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        }
            break;
        default:break;
    }
    self.imageEdgeInsets = imageEdge;
    self.titleEdgeInsets = titleEdge;
    [self setNeedsDisplay];
}


#pragma mark - 设置属性

- (void)setButtonContentLayoutStyle:(ButtonContentLayoutStyle)buttonContentLayoutStyle{
    [self willChangeValueForKey:kButtonContentLayoutStyleKey];
    objc_setAssociatedObject(self, &kButtonContentLayoutStyleKey,
                             @(buttonContentLayoutStyle),
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:kButtonContentLayoutStyleKey];
    [self setupButtonLayout];
}

- (ButtonContentLayoutStyle)buttonContentLayoutStyle{
    return [objc_getAssociatedObject(self, &kButtonContentLayoutStyleKey) integerValue];
}



- (void)setButtonContentPadding:(CGFloat)buttonContentPadding{
    [self willChangeValueForKey:kButtonContentPaddingKey];
    objc_setAssociatedObject(self, &kButtonContentPaddingKey,
                             @(buttonContentPadding),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:kButtonContentPaddingKey];
    [self setupButtonLayout];
}

- (CGFloat)buttonContentPadding{
    return [objc_getAssociatedObject(self, &kButtonContentPaddingKey) floatValue];
}

- (void)setButtonContentPaddingInset:(CGFloat)buttonContentPaddingInset{
    [self willChangeValueForKey:kButtonContentPaddingInsetKey];
    objc_setAssociatedObject(self, &kButtonContentPaddingInsetKey,
                             @(buttonContentPaddingInset),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:kButtonContentPaddingInsetKey];
    [self setupButtonLayout];
}

- (CGFloat)buttonContentPaddingInset{
    return [objc_getAssociatedObject(self, &kButtonContentPaddingInsetKey) floatValue];
}


@end
