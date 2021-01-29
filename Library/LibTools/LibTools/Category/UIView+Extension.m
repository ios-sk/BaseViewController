//
//  UIView+Extension.m
//  LibTools
//
//  Created by 晃悠 on 2021/1/20.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)cornerRadii:(CGSize)size byRoundingCorners:(UIRectCorner)corners{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
-(void)startRotateAnimating:(CGFloat)duration{
    if([self.layer animationForKey:@"rotatianAnimKey"]){
    if (self.layer.speed == 1) {
            return;
        }
        self.layer.speed = 1;
        self.layer.beginTime = 0;
        CFTimeInterval pauseTime = self.layer.timeOffset;
        self.layer.timeOffset = 0;
        self.layer.beginTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pauseTime;
    }else{
        [self addRotateAnimation:duration];
    }
}
-(void)addRotateAnimation:(CGFloat)duration{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    animation.toValue =   [NSNumber numberWithFloat: M_PI *2];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.duration = duration;
    animation.autoreverses = NO;
    animation.cumulative = NO;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = FLT_MAX; //如果这里想设置成一直自旋转，可以设置为FLT_MAX，
    [self.layer addAnimation:animation forKey:@"rotatianAnimKey"];
    [self startRotateAnimating:duration];
}

-(void)stopRotateAnimating{
    if (self.layer.speed == 0) {
        return;
    }
    CFTimeInterval pausedTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.layer.speed = 0;
    self.layer.timeOffset = pausedTime;
}
- (void)addGradientColorWith:(NSArray *)gradientColors percentage:(NSArray *)percents{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.colors = gradientColors;
    gradientLayer.locations = percents;
    [self.layer addSublayer:gradientLayer];
}
- (UIImage *)generateToImage{
    CGSize s = self.bounds.size;
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


/// 设置圆角
/// @param radius 圆角大小
- (void)setCornerRadius:(CGFloat)radius{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius  = radius;
//    [self setCornerRadius:radius rectCorner:UIRectCornerAllCorners];
}

/// 设置圆角
/// @param radius 圆角大小
/// @param corners 圆角方位
- (void)setCornerRadius:(CGFloat)radius rectCorner:(UIRectCorner)corners{
    [self cornerRadii:CGSizeMake(radius, radius) byRoundingCorners:corners];
}

/// 设置边框
/// @param color 边框颜色
/// @param width 边框宽度
- (void)setBorderColor:(UIColor *)color borderWidth:(CGFloat)width{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
}



//振动动画－类心跳动画
- (void)showShakeAnimation{
    
    [UIView animateWithDuration:0.1 animations:^{
        self.transform=CGAffineTransformMakeScale(1.01f, 1.01f);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.transform=CGAffineTransformMakeScale(0.99f, 0.99f);
        } completion:^(BOOL finished) {
            self.transform=CGAffineTransformMakeScale(1.0f, 1.0f);
        }];
    }];
}

//振动动画－类app删除动画
- (void)shakeAnimation:(BOOL)shake
{
    if(shake) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.fromValue = [NSNumber numberWithFloat:-0.05];
        animation.toValue = [NSNumber numberWithFloat:+0.05];
        animation.duration = 0.1;
        animation.autoreverses = YES; //是否重复
        animation.repeatCount = MAXFLOAT;
        [self.layer addAnimation:animation forKey:@"shake"];
    }
    else {
        [self.layer removeAnimationForKey:@"shake"];
    }
}

// 左右晃动
- (void)shakeAction
{
    // 晃动次数
    static int numberOfShakes = 4;
    // 晃动幅度（相对于总宽度）
    static float vigourOfShake = 0.04f;
    // 晃动延续时常（秒）
    static float durationOfShake = 0.5f;
    
    CAKeyframeAnimation *shakeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    // 方法一：绘制路径
    CGRect frame = self.frame;
    // 创建路径
    CGMutablePathRef shakePath = CGPathCreateMutable();
    // 起始点
    CGPathMoveToPoint(shakePath, NULL, CGRectGetMidX(frame), CGRectGetMidY(frame));
    for (int index = 0; index < numberOfShakes; index++)
    {
        // 添加晃动路径 幅度由大变小
        CGPathAddLineToPoint(shakePath, NULL, CGRectGetMidX(frame) - frame.size.width * vigourOfShake*(1-(float)index/numberOfShakes),CGRectGetMidY(frame));
        CGPathAddLineToPoint(shakePath, NULL,  CGRectGetMidX(frame) + frame.size.width * vigourOfShake*(1-(float)index/numberOfShakes),CGRectGetMidY(frame));
    }
    // 闭合
    CGPathCloseSubpath(shakePath);
    shakeAnimation.path = shakePath;
    shakeAnimation.duration = durationOfShake;
    // 释放
    CFRelease(shakePath);
    
    [self.layer addAnimation:shakeAnimation forKey:kCATransition];
}

// 上下晃动
- (void)shakeAction_top_bottom
{
    // 晃动次数
    static int numberOfShakes = 4;
    // 晃动幅度（相对于总宽度）
    static float vigourOfShake = 0.2f;
    // 晃动延续时常（秒）
    static float durationOfShake = 0.5f;
    
    CAKeyframeAnimation *shakeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    // 方法一：绘制路径
    CGRect frame = self.frame;
    // 创建路径
    CGMutablePathRef shakePath = CGPathCreateMutable();
    // 起始点
    CGPathMoveToPoint(shakePath, NULL, CGRectGetMidX(frame), CGRectGetMidY(frame));
    for (int index = 0; index < numberOfShakes; index++){
        // 添加晃动路径 幅度由大变小
        CGPathAddLineToPoint(shakePath, NULL, CGRectGetMidX(frame), CGRectGetMidY(frame)- frame.size.height * vigourOfShake*(1-(float)index/numberOfShakes));
        CGPathAddLineToPoint(shakePath, NULL,  CGRectGetMidX(frame), CGRectGetMidY(frame)+ frame.size.height * vigourOfShake*(1-(float)index/numberOfShakes));
    }
    // 闭合
    CGPathCloseSubpath(shakePath);
    shakeAnimation.path = shakePath;
    shakeAnimation.duration = durationOfShake;
    // 释放
    CFRelease(shakePath);
    
    [self.layer addAnimation:shakeAnimation forKey:kCATransition];
    
}

//消失动画
- (void)dissAnimation{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

// 缩放动画
- (void)zoomAnimation{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue=[NSNumber numberWithFloat:1];
    animation.toValue=[NSNumber numberWithFloat:1.2];
    animation.duration = 0.8;
    animation.autoreverses=YES;
    animation.repeatCount = CGFLOAT_MAX;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    [self.layer addAnimation:animation forKey:@"kViewZoomAnimationKey"];
}

- (void)dissZoomAnimation{
    [self.layer removeAnimationForKey:@"kViewZoomAnimationKey"];
}

// 跳动动画
- (void)popJumpAnimation{
    
    CGFloat duration = 0.9f;
    CGFloat height = 10.f;
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    CGFloat currentTy = self.transform.ty;
    animation.duration = duration;
    animation.values = @[@(currentTy), @(currentTy - height/4), @(currentTy-height/4*2), @(currentTy-height/4*3), @(currentTy - height), @(currentTy-height/4*3), @(currentTy -height/4*2), @(currentTy - height/4), @(currentTy)];
    animation.keyTimes = @[@(0), @(0.025), @(0.085), @(0.2), @(0.5), @(0.8), @(0.915), @(0.975), @(1)];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.repeatCount = CGFLOAT_MAX;
    animation.removedOnCompletion = NO;
    [self.layer addAnimation:animation forKey:@"kViewPopJumpAnimationKey"];
}

- (void)dissPopJumpAnimation{
    [self.layer removeAnimationForKey:@"kViewPopJumpAnimationKey"];
}

//点赞动画
-(void)showGiveLikeAnimation;
{
    
    [self setup];
    
}

- (void)setup {
    // 粒子使用CAEmitterCell初始化
    CAEmitterCell *emitterCell   = [CAEmitterCell emitterCell];
    // 粒子的名字,在设置喷射个数的时候会用到
    emitterCell.name             = @"emitterCell";
    // 粒子的生命周期和生命周期范围
    emitterCell.lifetime         = 0.7;
    emitterCell.lifetimeRange    = 0.3;
    // 粒子的发射速度和速度的范围
    emitterCell.velocity         = 30.00;
    emitterCell.velocityRange    = 4.00;
    // 粒子的缩放比例和缩放比例的范围
    emitterCell.scale            = 0.1;
    emitterCell.scaleRange       = 0.02;
    
    // 粒子透明度改变范围
    emitterCell.alphaRange       = 0.10;
    // 粒子透明度在生命周期中改变的速度
    emitterCell.alphaSpeed       = -1.0;
    // 设置粒子的图片
    emitterCell.contents         = (id)[UIImage imageNamed:@"icon_eighteenth_yidianzan"].CGImage;
    
    /// 初始化粒子发射器
    CAEmitterLayer *layer        = [CAEmitterLayer layer];
    // 粒子发射器的 名称
    layer.name                   = @"emitterLayer";
    // 粒子发射器的 形状(可以想象成打仗时,你需要的使用的炮的形状)
    layer.emitterShape           = kCAEmitterLayerCircle;
    // 粒子发射器 发射的模式
    layer.emitterMode            = kCAEmitterLayerOutline;
    // 粒子发射器 中的粒子 (炮要使用的炮弹)
    layer.emitterCells           = @[emitterCell];
    // 定义粒子细胞是如何被呈现到layer中的
    layer.renderMode             = kCAEmitterLayerOldestFirst;
    // 不要修剪layer的边界
    layer.masksToBounds          = NO;
    // z 轴的相对坐标 设置为-1 可以让粒子发射器layer在self.layer下面
    layer.zPosition              = -1;
    layer.emitterPosition = CGPointMake(self.frame.size.width/2-6,self.frame.size.height/2 );
    // 添加layer
    [self.layer addSublayer:layer];
  
    // 创建关键帧动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
//    if (self.selected) {
        animation.values = @[@1.5 ,@0.8, @1.0,@1.2,@1.0];
        animation.duration = 0.5;
//        // 粒子发射器 发射
//        [self startFire];
        // 动画模式
        animation.calculationMode = kCAAnimationCubic;
    [((UIButton*)self).imageView.layer addAnimation:animation forKey:@"transform.scale"];
//    }else
//    {
//        animation.values = @[@0.8, @1.0];
//        animation.duration = 0.4;
//    }
 
    
    // 每秒喷射的80个
    [layer setValue:@80 forKeyPath:@"emitterCells.emitterCell.birthRate"];
    // 开始
    layer.beginTime = CACurrentMediaTime();
    // 执行停止
    [self performSelector:@selector(stopFire:) withObject:layer afterDelay:0.1];
    
}
- (void)stopFire:(NSObject*)layer {
    //每秒喷射的个数0个 就意味着关闭了
    [layer setValue:@0 forKeyPath:@"emitterCells.emitterCell.birthRate"];
}

@end
