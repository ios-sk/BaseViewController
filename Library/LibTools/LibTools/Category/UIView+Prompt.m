//
//  UIView+Prompt.m
//  LibTools
//
//  Created by 晃悠 on 2020/12/17.
//  Copyright © 2020 . All rights reserved.
//

#import "UIView+Prompt.h"
#import <objc/runtime.h>

@implementation UIView (Prompt)

static const CGFloat promptMargin = 10.0;

static const CGFloat proTitleLabelHeight = 25.0;
static const CGFloat proMsgLabelHeight = 25.0;

static const CGFloat proRetryButtonHeight = 40.0;
static const CGFloat proRetryButtonWidth = 140.0;

static NSString *proLoadingText = @"正在努力加载中...";
static NSString *proNoDataText = @"没有数据";

static NSString *proErrorTitleText = @"哎呀，没有连接到网络......";
static NSString *proErrorMsgText = @"检查下网络试试吧";

static NSString *proRetryBtnTitle = @"重新加载";

static NSString *proNoDataImageName = @"";
static NSString *proErrorImageName = @"";


static char proViewVerticalOffset;
static char proViewRealHeight;

- (void)retryClick {
    self.proView.hidden = YES;
    
    if ([self isMemberOfClass:[UIScrollView class]]) {
        ((UIScrollView *)self).scrollEnabled = YES;
    }

    if (self.retryBlock) {
        self.retryBlock();
    }
}

- (void)setPromptType:(PromptType)promptType{
    objc_setAssociatedObject(self, @selector(promptType), @(promptType), OBJC_ASSOCIATION_ASSIGN);
    if (self.proView == nil) {
        [self setupViews];
    }
    
    self.proView.hidden = NO;
    [self.proImageView stopAnimating];
    
    if ([self isMemberOfClass:[UIScrollView class]]) {
        ((UIScrollView *)self).scrollEnabled = NO;
    }
    
    if (promptType == PromptTypeError) {
        if ([self isMemberOfClass:[UITableView class]]) {
            if (((UITableView *)self).tableHeaderView) {
                [((UITableView *)self).tableHeaderView removeFromSuperview];
                ((UITableView *)self).tableHeaderView = nil;
            }
        }
        
        [self setBadNetWorkUI];
        [self settingFrame];
        
    } else if(promptType == PromptTypeNoData){
        if ([self isMemberOfClass:[UITableView class]]) {
            if (((UITableView *)self).tableHeaderView) {
                [((UITableView *)self).tableHeaderView removeFromSuperview];
                ((UITableView *)self).tableHeaderView = nil;
            }
        }
        
        [self setNoDataUI];
        [self settingFrame];

    }else if(promptType == PromptTypeLoading){

        [self setLoadingUI];
        [self settingFrame];

    }else{
        self.proView.hidden = YES;
    }
}

// 设置无网络Ui
- (void)setBadNetWorkUI{
    
    self.retryButton.hidden = NO;
    
    if (self.proErrorImage) {
        self.proImageView.image = self.proErrorImage;
    }else{
        self.proImageView.image = [UIImage imageNamed:proErrorImageName];
    }
    
    if (self.proErrorTitle.length) {
        self.proTitleLabel.text = self.proErrorTitle;
    }else{
        self.proTitleLabel.text = proErrorTitleText;
    }
    
    if (self.proErrorMsg .length) {
        self.proMsgLabel.text = self.proErrorMsg;
    }else{
        self.proMsgLabel.text = proErrorMsgText;
    }
    
}

// 设置无数据UI
- (void)setNoDataUI{
    self.retryButton.hidden = YES;
    
    if (self.proNoDataImage) {
        self.proImageView.image = self.proNoDataImage;
    }else{
        self.proImageView.image = [UIImage imageNamed:proNoDataImageName];
    }
    
    if (self.proNoDataTitle.length) {
        self.proTitleLabel.text = self.proNoDataTitle;
    }else{
        self.proTitleLabel.text = proNoDataText;
    }
    
    if (self.proNoDataMsg.length) {
        self.proMsgLabel.text = self.proNoDataMsg;
    }else{
        self.proMsgLabel.text = @"";
    }
    
}

// 设置加载中UI
- (void)setLoadingUI{
    self.retryButton.hidden = YES;
    self.proMsgLabel.text = @"";
    
    if (self.proLoadingText.length) {
        self.proTitleLabel.text = self.proLoadingText;
    }else{
        self.proTitleLabel.text = proLoadingText;
    }
    
#warning --sk-- loading图
    if (!self.proLoadingImgs.count) {
         NSMutableArray *tempArr = [NSMutableArray array];
           for (int i = 1; i<31; i++) {
               NSString *name = [@"loading" stringByAppendingFormat:@"%d", i];
               UIImage *image = [UIImage imageNamed:name];
               if (image) [tempArr addObject:image];
           }
        self.proLoadingImgs = tempArr;
    }
    
    [self startLodingAnimation];
}

- (void)startLodingAnimation{
    self.proImageView.animationImages = self.proLoadingImgs;
    self.proImageView.animationRepeatCount = 0;
    self.proImageView.animationDuration = 1.0f;
    [self.proImageView startAnimating];
}


- (void)settingFrame {
    self.proView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    CGSize size = self.proView.bounds.size;
    CGFloat realHeight = size.height;
    CGFloat realWidth = size.width;
    
    if (self.proRealHeight) {
        realHeight = self.proRealHeight;
    }
    
    CGFloat imageWidth = self.frame.size.width / 3;
    CGFloat imageHeight = self.frame.size.width / 3;
    
    if (self.promptType == PromptTypeLoading) {
        self.proImageView.frame = CGRectMake((realWidth - 38) / 2.0, (realHeight / 3) - (46 / 2) + self.proVerticalOffset, 38, 46);
    }else{
        self.proImageView.frame = CGRectMake((realWidth - imageWidth) / 2.0 , (realHeight / 3) - (imageHeight / 2) + self.proVerticalOffset, imageWidth, imageHeight);
    }
    
    self.proTitleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.proImageView.frame) + promptMargin*2, size.width, proTitleLabelHeight);
    
    self.proMsgLabel.frame = CGRectMake(0, CGRectGetMaxY(self.proTitleLabel.frame) + promptMargin, size.width, proMsgLabelHeight);
    
    self.retryButton.frame = CGRectMake((size.width - proRetryButtonWidth) / 2, CGRectGetMaxY(self.proMsgLabel.frame) + promptMargin * 2, proRetryButtonWidth, proRetryButtonHeight);
    
}

- (void)setupViews {
    UIView *proView = [[UIView alloc] init];
    proView.backgroundColor = [UIColor whiteColor];
    [self addSubview:proView];
    self.proView = proView;
    
    UILabel *proLabel = [[UILabel alloc] init];
    proLabel.textColor = [UIColor darkTextColor];
    proLabel.textAlignment = NSTextAlignmentCenter;
    proLabel.font = [UIFont systemFontOfSize:16];
    [proView addSubview:proLabel];
    self.proTitleLabel = proLabel;
    
    UILabel *proMsgLabel = [[UILabel alloc] init];
    proMsgLabel.textColor = [UIColor lightGrayColor];
    proMsgLabel.textAlignment = NSTextAlignmentCenter;
    proMsgLabel.font = [UIFont systemFontOfSize:14];
    [proView addSubview:proMsgLabel];
    self.proMsgLabel = proMsgLabel;
    
    UIImageView *proImageView = [[UIImageView alloc] init];
    proImageView.contentMode = UIViewContentModeScaleAspectFit;
    [proView addSubview:proImageView];
    self.proImageView = proImageView;
    

    UIButton *button = [[UIButton alloc]init];
    button.backgroundColor = UIColor.darkGrayColor;

    [button setTitle:proRetryBtnTitle forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    button.clipsToBounds = YES;
    button.layer.cornerRadius = 5;
//    [button setBorder:UIColor.lightGrayColor borderWidth:1];
    [proView addSubview:button];
    self.retryButton = button;
    [self.retryButton addTarget:self
                         action:@selector(retryClick)
               forControlEvents:UIControlEventTouchUpInside];
    self.proView.hidden = YES;

}


#pragma mark - 设置属性
- (PromptType)promptType{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (NSArray<UIImage *> *)proLoadingImgs{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setProLoadingImgs:(NSArray<UIImage *> *)proLoadingImgs{
    objc_setAssociatedObject(self, @selector(proLoadingImgs), proLoadingImgs, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)proLoadingText{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setProLoadingText:(NSString *)proLoadingText{
    objc_setAssociatedObject(self, @selector(proLoadingText), proLoadingText, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)proNoDataTitle{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setProNoDataTitle:(NSString *)proNoDataTitle{
    objc_setAssociatedObject(self, @selector(proNoDataTitle), proNoDataTitle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)proNoDataMsg{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setProNoDataMsg:(NSString *)proNoDataMsg{
    objc_setAssociatedObject(self, @selector(proNoDataMsg), proNoDataMsg, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)proErrorTitle{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setProErrorTitle:(NSString *)proErrorTitle{
    objc_setAssociatedObject(self, @selector(proErrorTitle), proErrorTitle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)proErrorMsg{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setProErrorMsg:(NSString *)proErrorMsg{
    objc_setAssociatedObject(self, @selector(proErrorMsg), proErrorMsg, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

// 提示图片
- (UIImage *)proNoDataImage{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setProNoDataImage:(UIImage *)proNoDataImage{
    objc_setAssociatedObject(self, @selector(proNoDataImage), proNoDataImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)proErrorImage{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setProErrorImage:(UIImage *)proErrorImage{
    objc_setAssociatedObject(self, @selector(proErrorImage), proErrorImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)proVerticalOffset{
    return [objc_getAssociatedObject(self, &proViewVerticalOffset) floatValue];
}

- (void)setProVerticalOffset:(CGFloat)proVerticalOffset{
    objc_setAssociatedObject(self, &proViewVerticalOffset,  [NSString stringWithFormat:@"%lf", proVerticalOffset], OBJC_ASSOCIATION_COPY);
}

- (CGFloat)proRealHeight{
    return [objc_getAssociatedObject(self, &proViewRealHeight) floatValue];
}

- (void)setProRealHeight:(CGFloat)proRealHeight{
    objc_setAssociatedObject(self, &proViewRealHeight, [NSString stringWithFormat:@"%lf", proRealHeight], OBJC_ASSOCIATION_COPY);
}

// 按钮
- (void)setRetryButton:(UIButton *)retryButton{
    objc_setAssociatedObject(self, @selector(retryButton), retryButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIButton *)retryButton{
    return objc_getAssociatedObject(self, _cmd);
}

// 提示界面
- (UIView *)proView{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setProView:(UIView *)proView{
    objc_setAssociatedObject(self, @selector(proView), proView,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 提示lable
- (UILabel *)proTitleLabel{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setProTitleLabel:(UILabel *)proTitleLabel{
    objc_setAssociatedObject(self, @selector(proTitleLabel), proTitleLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 无网络lable
- (UILabel *)proMsgLabel{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setProMsgLabel:(UILabel *)proMsgLabel{
    objc_setAssociatedObject(self, @selector(proMsgLabel), proMsgLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 提示imageView
- (UIImageView *)proImageView{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setProImageView:(UIImageView *)proImageView{
    objc_setAssociatedObject(self, @selector(proImageView), proImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 重新请求网络
- (RetryBlock)retryBlock{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setRetryBlock:(RetryBlock)retryBlock{
    objc_setAssociatedObject(self, @selector(retryBlock), retryBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self setupViews];
}


@end
