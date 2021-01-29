//
//  UIButton+ContentLayout.h
//  LibTools
//
//  Created by 晃悠 on 2020/12/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ButtonContentLayoutStyle) {
    /// 内容居中-图左文右
    ButtonContentLayoutStyleNormal = 0,
    /// 内容居中-图右文左
    ButtonContentLayoutStyleCenterImageRight,
    /// 内容居中-图上文下
    ButtonContentLayoutStyleCenterImageTop,
    /// 内容居中-图下文上
    ButtonContentLayoutStyleCenterImageBottom,
    /// 内容居左-图左文右
    ButtonContentLayoutStyleLeftImageLeft,
    /// 内容居左-图右文左
    ButtonContentLayoutStyleLeftImageRight,
    /// 内容居右-图左文右
    ButtonContentLayoutStyleRightImageLeft,
    /// 内容居右-图右文左
    ButtonContentLayoutStyleRightImageRight
};

@interface UIButton (ContentLayout)

/// button 的布局样式，文字、字体大小、图片等参数一定要在其之前设置，方便计算
@property(nonatomic, assign) ButtonContentLayoutStyle buttonContentLayoutStyle;

/// 图文间距，默认为：0
@property (nonatomic, assign) CGFloat buttonContentPadding;

/// 图文边界的间距，默认为：5
@property (nonatomic, assign) CGFloat buttonContentPaddingInset;

@end

NS_ASSUME_NONNULL_END
