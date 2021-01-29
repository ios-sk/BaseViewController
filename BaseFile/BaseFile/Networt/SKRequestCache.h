//
// SKRequestCache.h
//
// Created on 2021/1/20
//

#import <Foundation/Foundation.h>

/// 缓存类型
typedef NS_ENUM(NSInteger, SKRequestCacheType) {
    /// 正常类型 缓存7天
    SKRequestCacheTypeNormal,
    
};

@interface SKRequestCache : NSObject

/// 存入缓存数据 有效时间7天
/// @param obj 数据
/// @param key key
+ (void)setObject:(id)obj forkey:(NSString *)key;

/// 存入缓存数据 自定义有效时间
/// @param obj 数据
/// @param key key
/// @param validTime 有效时间
+ (void)setObject:(id)obj forkey:(NSString *)key validTime:(NSTimeInterval)validTime;

/// 获取缓存数据 会返回nil
/// @param key 根据key
+ (id)objectForKey:(NSString *)key;

/// 根据key移除缓存数据
/// @param key key
+ (void)removeObjectForKey:(NSString *)key;

/// 移除所有缓存数据
+ (void)removeAllObject;

@end


