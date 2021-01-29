//
//  AppDelegate.m
//  BaseFile
//
//  Created by 晃悠 on 2021/1/19.
//

#import "AppDelegate.h"
#import "BaseNavigationController.h"

#import "SKProjectConfig.h"
#import "SKProjectBaseConfig.h"
#import "SKProjectBlackConfig.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (AppDelegate *)shareDelegate{
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 项目的基本配置 
    [SKProjectConfig initProjectConfig:SKProjectBaseConfig.class];
//    [SKProjectConfig initProjectConfig:SKProjectBlackConfig.class];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self setRootVC];
    
    return YES;
}

- (void)setRootVC{
    self.window.rootViewController = [[BaseNavigationController alloc] initWithMainRootViewController];
}

@end
