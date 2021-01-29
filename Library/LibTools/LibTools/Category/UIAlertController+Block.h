//
//  UIAlertController+Block.h
//  LibTools
//
//  Created by 晃悠 on 2021/1/20.
//

#import <UIKit/UIKit.h>

typedef void(^UIAlertControllerCallBackBlock)(NSInteger buttonIndex);

@interface UIAlertAction (Index)

@property (nonatomic, assign) NSInteger index;

@end

@interface UIAlertController (Block)

@property (nonatomic, copy) UIAlertControllerCallBackBlock alertControllerCallBackBlock;



/// 中间弹窗样式
/// @param alertControllerCallBackBlock 点击回调
/// @param title 标题
/// @param message 内容
/// @param cancelButtonName 取消按钮
/// @param otherButtonTitles 其他按钮
+ (void)alertWithCallBackBlock:(UIAlertControllerCallBackBlock)alertControllerCallBackBlock title:(NSString *)title message:(NSString *)message  cancelButtonName:(NSString *)cancelButtonName otherButtonTitles:(NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION;

/// 底部弹窗样式
/// @param alertControllerCallBackBlock 点击回调
/// @param title 标题
/// @param message 内容
/// @param cancelButtonName 取消按钮
/// @param otherButtonTitles 其他按钮
+ (void)alertSheetWithCallBackBlock:(UIAlertControllerCallBackBlock)alertControllerCallBackBlock title:(NSString *)title message:(NSString *)message  cancelButtonName:(NSString *)cancelButtonName otherButtonTitles:(NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION;

@end

