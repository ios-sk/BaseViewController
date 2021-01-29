//
// IPhoneInfo.h
//
// Created on 2021/1/20
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IPhoneInfo : NSObject

+ (NSString *)appVersionNO;

+ (NSString *)appVersionBuild;

+ (NSString *)systemVersion;

+ (NSString *)ipAddress;

+ (NSString *)appBundleIdentifier;

@end

NS_ASSUME_NONNULL_END
