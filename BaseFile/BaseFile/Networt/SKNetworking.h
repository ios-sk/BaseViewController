//
// SKNetworking.h
//
// Created on 2021/1/20
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SKNetworking : NSObject

+ (void)processServiceRequestGet:(NSDictionary *)dictReqParameters
                      requestURL:(NSString *)requestURL
                    successBlock:(void (^)(id responseObject))successBlock
                    failureBlock:(void (^) (NSError *error))failureBlock;

+(void)processServiceRequestPost:(NSDictionary *)dictReqParameters
                      requestURL:(NSString *)requestURL
                    successBlock:(void (^)(id responseObject))successBlock
                    failureBlock:(void (^)(NSError *error))failureBlock;

+ (void)processServiceRequestImage:(NSDictionary *)dictReqParameters
                   requestImageKey:(NSString *)requestImageKey
                  requestImageData:(NSArray *)requestImageData
                        requestURL:(NSString *)requestURL
                     progressBlock:(void (^)(NSProgress *uploadProgress))progressBlock
                      successBlock:(void (^)(id responseObject))successBlock
                      failureBlock:(void (^)(NSError *error))failureBlock;

/**
 *  取消所有请求
 */
+ (void)cancelAllRequest;

/**
 *  根据url取消请求
 *
 *  @param url 请求url
 */
+ (void)cancelRequestWithURL:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
