//
// SKProjectConfig.h
//
// Created on 2021/1/29
//

#import <Foundation/Foundation.h>
#import "SKProjectConfigInterface.h"
NS_ASSUME_NONNULL_BEGIN

/// 对外的使用
@interface SKProjectConfig : NSObject

///
+ (void)initProjectConfig:(Class<SKProjectConfigInterface>)projConfig;


+ (UIColor *)navTitleColor;
+ (UIColor *)navBgColor;

@end

NS_ASSUME_NONNULL_END
