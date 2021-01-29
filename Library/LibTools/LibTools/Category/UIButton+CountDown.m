//
//  UIButton+CountDown.m
//  LibTools
//
//  Created by 晃悠 on 2020/12/17.
//

#import "UIButton+CountDown.h"
#import <objc/runtime.h>

@interface UIButton ()

@property (nonatomic, copy) NSString *normalTitle;
@property (nonatomic, copy) NSString *countDownFormat;
@property (nonatomic, assign) NSTimeInterval leaveTime;
@property (nonatomic, strong) dispatch_source_t timer;

@end

static NSString * const kCountDownTimer = @"CountDownTimer";
static NSString * const kCountDownLeaveTime = @"CountDownLeaveTime";
static NSString * const kCountDownFormat = @"CountDownFormat";
static NSString * const kCountDownStoppedCallback = @"CountDownStoppedCallback";
static NSString * const kCountDownNormalTitle = @"CountDownNormalTitle";


@implementation UIButton (CountDown)

- (void)setTimer:(dispatch_source_t)timer {
    [self willChangeValueForKey:kCountDownTimer];
    objc_setAssociatedObject(self, &kCountDownTimer,
                             timer,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:kCountDownTimer];
}

- (dispatch_source_t)timer {
    return objc_getAssociatedObject(self, &kCountDownTimer);
}

- (void)setLeaveTime:(NSTimeInterval)leaveTime {
    [self willChangeValueForKey:kCountDownLeaveTime];
    objc_setAssociatedObject(self, &kCountDownLeaveTime,
                             @(leaveTime),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:kCountDownLeaveTime];
}

- (NSTimeInterval)leaveTime {
    return [objc_getAssociatedObject(self, &kCountDownLeaveTime) doubleValue];
}

- (void)setCountDownFormat:(NSString *)countDownFormat {
    [self willChangeValueForKey:kCountDownFormat];
    objc_setAssociatedObject(self, &kCountDownFormat,
                             countDownFormat,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:kCountDownFormat];
}

- (NSString *)countDownFormat {
    return objc_getAssociatedObject(self, &kCountDownFormat);
}

- (void)setCountDownStoppedCallback:(void (^)(void))countDownStoppedCallback{
    
    [self willChangeValueForKey:kCountDownStoppedCallback];
    objc_setAssociatedObject(self, &kCountDownStoppedCallback,
                             countDownStoppedCallback,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:kCountDownStoppedCallback];
}

- (void (^)(void))countDownStoppedCallback{
    return objc_getAssociatedObject(self, &kCountDownStoppedCallback);
}


- (void)setNormalTitle:(NSString *)normalTitle {
    [self willChangeValueForKey:kCountDownNormalTitle];
    objc_setAssociatedObject(self, &kCountDownNormalTitle,
                             normalTitle,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:kCountDownNormalTitle];
}

- (NSString *)normalTitle {
    return objc_getAssociatedObject(self, &kCountDownNormalTitle);
}

/// 设置倒计时时间和文案
/// @param duration 倒计时时间
/// @param format 倒计时文案  默认 @"%zd秒"
- (void)countDownWithTimeInterval:(NSTimeInterval)duration countDownFormat:(NSString *)format{
    if (!format.length){
        self.countDownFormat = @"%zd秒";
    } else {
        self.countDownFormat = format;
    }
    self.userInteractionEnabled = NO;
    self.normalTitle = self.titleLabel.text;
    __block NSInteger timeOut = duration; //倒计时时间
    __weak typeof(self) weakSelf = self;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(self.timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(self.timer, ^{
        if (timeOut <= 0) { // 倒计时结束，关闭
            [weakSelf cancelTimer];
        } else {
            NSString *title = [NSString stringWithFormat:weakSelf.countDownFormat,timeOut];
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.titleLabel.text = title;
                [weakSelf setTitle:title forState:UIControlStateNormal];
            });
            timeOut--;
        }
    });
    dispatch_resume(self.timer);
}

/// 倒计时结束
- (void)cancelTimer{
    dispatch_source_cancel(self.timer);
    self.timer = nil;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.userInteractionEnabled = YES;
        if (self.countDownStoppedCallback) {
            self.countDownStoppedCallback();
        }else{
            // 设置界面的按钮显示 根据自己需求设置
            self.titleLabel.text = self.normalTitle;
            [self setTitle:self.normalTitle forState:UIControlStateNormal];
        }
    });
}

@end
