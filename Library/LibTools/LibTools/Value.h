//
//  Value.h
//  BaseFile
//
//  Created by 晃悠 on 2021/1/20.
//  Copyright © 2021  . All rights reserved.
//

#ifndef Value_h
#define Value_h

#define kISiPhone        (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kScreenMaxLength (MAX(kScreenWidth, kScreenHeight))
#define kScreenMinLength (MIN(kScreenWidth, kScreenHeight))

//是否为iphoneX以后机型
#define kISiPhoneXX (kISiPhone && kScreenMaxLength > 811.0)

//#gragma mark - 屏幕宽高
#define kScreenWidth           [UIScreen mainScreen].bounds.size.width
#define kScreenHeight          [UIScreen mainScreen].bounds.size.height

#define kScrenScale            (((kScreenWidth/375.0) < 1) ? 0.95 : (kScreenWidth / 375.0))
#define kScale(num)            (kScrenScale * num)

//字体适配
#define kScaleFont(fontSize)   [UIFont systemFontOfSize:kScale(fontSize)]

//状态栏高度
#define kStatusBarHeight       [[UIApplication sharedApplication] statusBarFrame].size.height

//导航栏高度
#define kNavBarHeight          (kStatusBarHeight + 44.0)

//标签栏高度
#define kTabBarHeight          (49.0 + kSafeAreaBottom)

//底部安全区高度
#define kSafeAreaBottom        (kISiPhoneXX ? 34.0 : 0)
#define NearkSafeAreaBottom    (kISiPhoneXX ? 34.0 : 10)

#define kWeakSelf(type)    __weak typeof(type) weak##type = type
#define kStrongSelf(type)  __strong typeof(type) type = weak##type


#define KLog(...) NSLog(@"\n\n<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< \n所在类和方法:%s \n所在行数:%d \n打印:%@ \n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n", __PRETTY_FUNCTION__, __LINE__, [NSString stringWithFormat:__VA_ARGS__])

#define kiOS(N)   @available(iOS N, *)

#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#else
#define NSLog(...)
#define debugMethod()
#endif

#endif /* Value_h */
