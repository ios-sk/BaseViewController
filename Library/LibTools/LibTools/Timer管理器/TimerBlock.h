//
//  TimerBlock.h
//  LibTools
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

//时间倒数
@interface TimerBlock : NSObject


/**
 设定总时间，设定间隔时间

 @param totalTime 总时间
 @param intervalTime 间隔多长时间
 @param progress 每一个间隔时间返回一次
 @param finish 完成回调
 */
- (void)startTimerForTotalTime:(CGFloat)totalTime
                  IntervalTime:(NSTimeInterval)intervalTime
                      progress:(void (^) (CGFloat progress))progress
                        finish:(void (^) (void))finish;

/**
 不设定总时间

 @param progress 每秒钟返回一次
 */
- (void)startTimerForSecondBlock:(void (^)(CGFloat progress))progress;

/**
不设定总时间
@param intervalTime 间隔多长时间
@param progress 每一个间隔时间返回一次
*/
- (void)startTimerForIntervalTime:(NSTimeInterval)intervalTime progress:(void (^)(CGFloat progress))progress;



- (void)stopTimer;

- (void)pause;

- (void)resume;

- (void)restart;

@end

NS_ASSUME_NONNULL_END
