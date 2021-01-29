//
// SKRequestCache.m
//
// Created on 2021/1/20
//

#import "SKRequestCache.h"
#import <YYCache/YYCache.h>

// 过期时间标识
static NSString * const REQUEST_TIME = @"request_time_";

// 数据标识
static NSString * const REQUEST_DATA = @"request_data_";

// 默认有效时间 7 天
static double const VALID_TIME = 60 * 60 * 24 * 7;

@implementation SKRequestCache

+ (void)setObject:(id)obj forkey:(NSString *)key{
    [self setObject:obj forkey:key validTime:VALID_TIME];
}

+ (void)setObject:(id)obj forkey:(NSString *)key validTime:(NSTimeInterval)validTime{
    // 缓存数据
    YYCache *dataCache = [YYCache cacheWithName:REQUEST_DATA];
    [dataCache setObject:obj forKey:key withBlock:^{
            NSLog(@"setObject sucess");
    }];
    // 缓存时间
    YYCache *timeCache = [YYCache cacheWithName:REQUEST_TIME];
    [timeCache setObject:[self getTimeValueWithExpireTime:validTime] forKey:key];
}

+ (id)objectForKey:(NSString *)key{
    // 判断是否过期
    if ([self checkKeyIsExpire:key]) {
        // 已过期
        KLog(@"key = %@ 对应的数据已过期且已删除", key);
        return nil;
    }
    
    // 获取缓存数据
    YYCache *dataCache = [YYCache cacheWithName:REQUEST_DATA];
    BOOL isContains=[dataCache containsObjectForKey:key];
    if (isContains) {
        return [dataCache objectForKey:key];
    }
    KLog(@"key = %@ 没有对应的缓存数据", key);
    return nil;
}

// 移除所有
+ (void)removeAllObject{
    YYCache *cache = [YYCache cacheWithName:REQUEST_DATA];
    [cache removeAllObjects];
    
    YYCache *timeCache = [YYCache cacheWithName:REQUEST_TIME];
    [timeCache removeAllObjects];
}

// 根据key 移除缓存数据
+ (void)removeObjectForKey:(NSString *)key{
    YYCache *cache = [YYCache cacheWithName:REQUEST_DATA];
    [cache removeObjectForKey:key];
    
    YYCache *timeCache = [YYCache cacheWithName:REQUEST_TIME];
    [timeCache removeObjectForKey:key];
}

/// 获取存入数据的过期时间
/// @param expireTime 过期时间
+ (NSString *)getTimeValueWithExpireTime:(NSTimeInterval)expireTime{
    double nowTime = [[self getNowTimeTimestamp] doubleValue];
    return [NSString stringWithFormat:@"%.0lf",nowTime + expireTime];
}

/// 获取当前 秒的时间戳
+ (NSString *)getNowTimeTimestamp{
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%0.f", a];
    return timeString;
}

/// 检查数据是否过期 已过期就删除缓存数据
+ (BOOL)checkKeyIsExpire:(NSString *)key{
    YYCache *timeCache = [YYCache cacheWithName:REQUEST_TIME];
    id timeValue = [timeCache objectForKey:key];
    
    if(timeValue == nil){
        return NO;
    }
    
    NSString *expireTime = [NSString stringWithFormat:@"%@", timeValue];
    double expireTimeStamp = [expireTime doubleValue];
    
    double nowTime = [[self getNowTimeTimestamp] doubleValue];
    int t = nowTime - expireTimeStamp;
    if (t >= 0) {
        // 已经过期
        [self removeObjectForKey:key];
        return YES;
    }
    return NO;
}

@end
