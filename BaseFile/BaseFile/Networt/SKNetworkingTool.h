//
// SKNetworkingTool.h
//
// Created on 2021/1/20
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface SKNetworkingTool : NSObject

///单例请求管理
+ (AFHTTPSessionManager *)shareSessionManager;

@end

NS_ASSUME_NONNULL_END
