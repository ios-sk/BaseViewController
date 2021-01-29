//
//  UIView+Blokc.h
//  LibTools
//
//  Created by 晃悠 on 2021/1/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Blokc)

/// 添加手势
- (void)addTapActionWithBlock:(void(^ __nullable)(void))block;

- (void)addLongpressActionWithBlock:(void(^ __nullable)(void))block;

@end

NS_ASSUME_NONNULL_END
