//
//  UIView+Blokc.m
//  LibTools
//
//  Created by 晃悠 on 2021/1/20.
//

#import "UIView+Blokc.h"
#import <objc/runtime.h>

static char kActionHandlerTapBlockKey;
static char kActionHandlerLongPressBlockKey;
static char kActionHandlerLongPressGestureKey;

@implementation UIView (Blokc)

/// 添加手势
- (void)addTapActionWithBlock:(void(^ __nullable)(void))block{
    self.userInteractionEnabled = YES;
    __weak typeof(UIView *) weakSelf = self;
   
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:weakSelf action:@selector(viewWhenTapBlock)];
    tap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tap];
    
    objc_setAssociatedObject(weakSelf, &kActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)viewWhenTapBlock{
    __weak typeof(UIView *) weakSelf = self;
    void (^controlClick)(void) = objc_getAssociatedObject(weakSelf, &kActionHandlerTapBlockKey);
    if (controlClick) {
        controlClick();
    }
}

- (void)addLongpressActionWithBlock:(void(^ __nullable)(void))block{
    __weak typeof(UIView *) weakSelf = self;
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForLongPressGesture:)];
    [self addGestureRecognizer:gesture];
    objc_setAssociatedObject(weakSelf, &kActionHandlerLongPressBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)handleActionForLongPressGesture:(UITapGestureRecognizer *)gesture{
    __weak typeof(UIView *) weakSelf = self;
    if (gesture.state == UIGestureRecognizerStateRecognized){
        void(^ block)(void) = objc_getAssociatedObject(weakSelf, &kActionHandlerLongPressBlockKey);
        if (block){
            block();
        }
    }
}


@end
