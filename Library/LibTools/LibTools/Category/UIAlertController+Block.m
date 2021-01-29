//
//  UIAlertController+Block.m
//  LibTools
//
//  Created by 晃悠 on 2021/1/20.
//

#import "UIAlertController+Block.h"
#import <objc/runtime.h>

static NSString *UIAlertControllerKey = @"UIAlertControllerKey";

@implementation UIAlertAction (Index)
- (void)setIndex:(NSInteger)index{
    objc_setAssociatedObject(self, @selector(index), @(index), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)index{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

@end

@implementation UIAlertController (Block)

+ (void)alertSheetWithCallBackBlock:(UIAlertControllerCallBackBlock)alertControllerCallBackBlock title:(NSString *)title message:(NSString *)message  cancelButtonName:(NSString *)cancelButtonName otherButtonTitles:(NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    alertController.alertControllerCallBackBlock = alertControllerCallBackBlock;
    // 取消按钮
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:cancelButtonName style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        if (alertController.alertControllerCallBackBlock) {
            alertControllerCallBackBlock(0);
        }
    }];
    action1.index = 0;
    [alertController addAction:action1];
    
    NSString *other = nil;
    va_list args;
    if (otherButtonTitles) {
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitles style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            if (alertController.alertControllerCallBackBlock) {
                alertControllerCallBackBlock(action.index);
            }
        }];
        otherAction.index = alertController.actions.count;
        [alertController addAction:otherAction];
        
        va_start(args, otherButtonTitles);
        while ((other = va_arg(args, NSString*))) {
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:other style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                if (alertController.alertControllerCallBackBlock) {
                    alertControllerCallBackBlock(action.index);
                }
            }];
            otherAction.index = alertController.actions.count;
            [alertController addAction:otherAction];
        }
        va_end(args);
    }
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:^{}];
}

+ (void)alertWithCallBackBlock:(UIAlertControllerCallBackBlock)alertControllerCallBackBlock title:(NSString *)title message:(NSString *)message  cancelButtonName:(NSString *)cancelButtonName otherButtonTitles:(NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    alertController.alertControllerCallBackBlock = alertControllerCallBackBlock;
    // 取消按钮
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:cancelButtonName style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        if (alertController.alertControllerCallBackBlock) {
            alertControllerCallBackBlock(0);
        }
    }];
    action1.index = 0;
    [alertController addAction:action1];
    
    NSString *other = nil;
    va_list args;
    if (otherButtonTitles) {
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitles style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            if (alertController.alertControllerCallBackBlock) {
                alertControllerCallBackBlock(action.index);
            }
        }];
        otherAction.index = alertController.actions.count;
        [alertController addAction:otherAction];
        
        va_start(args, otherButtonTitles);
        while ((other = va_arg(args, NSString*))) {
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:other style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                if (alertController.alertControllerCallBackBlock) {
                    alertControllerCallBackBlock(action.index);
                }
            }];
            otherAction.index = alertController.actions.count;
            [alertController addAction:otherAction];
        }
        va_end(args);
    }
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:^{}];
}


- (void)setAlertControllerCallBackBlock:(UIAlertControllerCallBackBlock)alertControllerCallBackBlock{
    objc_setAssociatedObject(self, @selector(alertControllerCallBackBlock), alertControllerCallBackBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIAlertControllerCallBackBlock)alertControllerCallBackBlock{
    return objc_getAssociatedObject(self, _cmd);
}

@end
