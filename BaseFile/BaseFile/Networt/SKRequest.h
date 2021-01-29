//
// SKRequest.h
//
// Created on 2021/1/20
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SKRequestErrorType){
    /// 其他错误
    SKRequestErrorTypeOther = 1,
    /// 数据为空
    SKRequestErrorTypeNULL,
    /// 网络错误
    SKRequestErrorTypeError,
};

/**
 *  成功
 */
typedef void(^SKRequestSuccessBlock)(id responseObject);

/**
 *  失败
 */
typedef void(^SKRequestfailureBlock)(SKRequestErrorType type, NSString *errMsg, NSString *errCode);

/**
 *  进度
 *
 *  @param bytesRead              已下载或者上传进度的大小
 *  @param totalBytes            总下载或者上传进度的大小
 */
typedef void(^SKRequestUploadProgressBlock)(int64_t bytesRead, int64_t totalBytes);

@interface SKRequest : NSObject



@end

NS_ASSUME_NONNULL_END
