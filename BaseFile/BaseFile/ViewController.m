//
//  ViewController.m
//  BaseFile
//
//  Created by 晃悠 on 2021/1/19.
//

#import "ViewController.h"
#import "SKRequestCache.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavTitle:@"首页"];
    
    [self.view addTapActionWithBlock:^{
        NSLog(@"点击");

    }];
    
    [self.view addLongpressActionWithBlock:^{
        NSLog(@"长按");
        [SKRequestCache setObject:@"aaa" forkey:@"fjaksj" validTime:90];
    }];
    
}


@end
