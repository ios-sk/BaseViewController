//
//  AppDelegate.h
//  BaseFile
//
//  Created by 晃悠 on 2021/1/19.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;

+ (AppDelegate *)shareDelegate;

- (void)setRootVC;

@end

