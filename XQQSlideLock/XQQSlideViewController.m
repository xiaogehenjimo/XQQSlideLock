//
//  XQQSlideViewController.m
//  sliderLock
//
//  Created by XQQ on 2016/12/21.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import "XQQSlideViewController.h"
#import "XQQSlideView.h"

#define iphoneWidth  [UIScreen mainScreen].bounds.size.width
#define iphoneHeight [UIScreen mainScreen].bounds.size.height

@interface XQQSlideViewController ()<XQQSlideViewDelegate>

@end

@implementation XQQSlideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"滑动解锁";
    
    XQQSlideView * slideView = [XQQSlideView slideViewWithFrame:CGRectMake(0, 64, iphoneWidth, iphoneHeight - 64) completeBlock:^(NSString *password) {
        NSLog(@"一切OK---%@",password);
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    slideView.slideLockType = self.slideLockType;
    slideView.delegate = self;
    [self.view addSubview:slideView];
    
}

#pragma mark - XQQSlideViewDelegate
- (void)slideViewDidGetPassword:(NSString *)password{
    NSLog(@"每次滑动都会获取到的密码--%@",password);
}

@end
