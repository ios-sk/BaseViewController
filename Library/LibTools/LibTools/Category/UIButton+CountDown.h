//
//  UIButton+CountDown.h
//  LibTools
//
//  Created by 晃悠 on 2020/12/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (CountDown)

/// 倒计时结束的回调
@property (nonatomic, copy) void(^countDownStoppedCallback)(void);


/// 设置倒计时时间和文案
/// @param duration 倒计时时间
/// @param format 倒计时文案  默认 @"%zd秒"
- (void)countDownWithTimeInterval:(NSTimeInterval)duration countDownFormat:(NSString *)format;

/// 倒计时结束
- (void)cancelTimer;

@end

NS_ASSUME_NONNULL_END
