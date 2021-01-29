//
//  UIView+Prompt.h
//  LibTools
//
//  Created by 晃悠 on 2020/12/17.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 显示样式
typedef NS_ENUM(NSInteger, PromptType) {
    /// 正常
    PromptTypeNormal = 1,
    /// 没有数据
    PromptTypeNoData = 2,
    /// 错误 有重新请求按钮
    PromptTypeError = 3,
    /// 加载中
    PromptTypeLoading
};

typedef void(^RetryBlock)(void);

@interface UIView (Prompt)

/// 显示什么样式
@property (nonatomic, assign) PromptType promptType;

@property (nonatomic, strong) NSArray <UIImage *>*proLoadingImgs;
@property (nonatomic, copy) NSString *proLoadingText;

@property (nonatomic, copy) NSString *proNoDataTitle;
@property (nonatomic, copy) NSString *proNoDataMsg;
@property (nonatomic, strong) UIImage *proNoDataImage;

@property (nonatomic, copy) NSString *proErrorTitle;
@property (nonatomic, copy) NSString *proErrorMsg;
@property (nonatomic, strong) UIImage *proErrorImage;

/// 垂直方向的偏移量 设置图片 Y 点的偏移
@property (nonatomic, assign) CGFloat proVerticalOffset;

/// tableView的真实高度
@property (nonatomic, assign) CGFloat proRealHeight;

/**
 *  重新请求数据Block
 */
@property (nonatomic, copy) RetryBlock retryBlock;

@property(nonatomic, weak) UIView *proView;
@property(nonatomic, weak) UILabel *proTitleLabel;
@property (nonatomic,weak) UILabel *proMsgLabel;
@property(nonatomic, weak) UIImageView *proImageView;
@property (nonatomic,weak) UIButton *retryButton;

@end

NS_ASSUME_NONNULL_END
