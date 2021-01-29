//
//  TimerBlock.m
//  LibTools
//

#import "TimerBlock.h"

@interface TimerBlock ()
@property (nonatomic, assign) CGFloat totalTime;   //总时间
@property (nonatomic, assign) CGFloat changeTime;   //减少的时间
@property (nonatomic, copy) NSTimer *playTimer;

@property (nonatomic, copy) void (^finishBlock)(void);
@property (nonatomic, copy) void (^timeBlock)(CGFloat);

///设定timer调用的时间间隔   默认1s
@property (nonatomic, assign)NSTimeInterval intervalTime;

@end

@implementation TimerBlock

- (void)dealloc
{
    
}


- (void)startTimerForTotalTime:(CGFloat)totalTime IntervalTime:(NSTimeInterval)intervalTime progress:(void (^)(CGFloat))progress finish:(void (^)(void))finish{
    _timeBlock = progress;
    _finishBlock = finish;
    _totalTime = totalTime;
    _changeTime = 0;
    _intervalTime = intervalTime;
    if (totalTime > 0) {
        [self startTimer];
    }else{
        [_playTimer invalidate];
        _playTimer = nil;
        if (_finishBlock) {
            _finishBlock();
        }
    }
}

- (void)startTimerForSecondBlock:(void (^)(CGFloat))progress{
    _timeBlock = progress;
    _totalTime = -1;
    _changeTime = 0;
    _intervalTime = 1.0;
    [self startTimer];
}

- (void)startTimerForIntervalTime:(NSTimeInterval)intervalTime progress:(void (^)(CGFloat))progress{
    _timeBlock = progress;
    _totalTime = -1;
    _changeTime = 0;
    _intervalTime = intervalTime;
    [self startTimer];
}


- (void)startTimer{
    if (_playTimer) {
        [_playTimer invalidate];
        _playTimer = nil;
    }

    _playTimer = [NSTimer timerWithTimeInterval:_intervalTime>0?_intervalTime:1.0 target:self selector:@selector(timerRunloop) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_playTimer forMode:NSDefaultRunLoopMode];
    [self judgeTimeBlock];
}

- (void)timerRunloop{
    _changeTime += (_intervalTime>0?_intervalTime:1.0);
    [self judgeTimeBlock];
}

- (void)judgeTimeBlock{
    if (_timeBlock) {
        _timeBlock(_changeTime);
    }
    if (_changeTime >= _totalTime && _totalTime > 0) {
        [_playTimer invalidate];
        _playTimer = nil;
        if (_finishBlock) {
            _finishBlock();
        }
    }
}


- (void)stopTimer{
    _changeTime= 0;
    [_playTimer invalidate];
    _playTimer = nil;
}

- (void)pause{
    [_playTimer invalidate];
    _playTimer = nil;
}

- (void)resume{
    [self startTimer];
}

- (void)restart{
    _changeTime = 0;
    [self startTimer];
}

@end
