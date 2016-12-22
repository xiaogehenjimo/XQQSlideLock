//
//  mainViewController.m
//  sliderLock
//
//  Created by XQQ on 2016/12/15.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import "mainViewController.h"
#import "XQQSlideViewController.h"

@interface mainViewController ()

@end

@implementation mainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"滑动解锁Demo";
    
    NSArray * titleArr = @[@"设置密码",@"验证密码",@"重置密码"];
    for (NSInteger i = 0; i < 3; i ++) {
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(50, i * 80 + 80, 80, 44)];
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor yellowColor];
        button.tag = 10087 + i;
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonDidPress:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    
}

- (void)buttonDidPress:(UIButton*)button{
    
    XQQSlideViewController * slideVC = [[XQQSlideViewController alloc]init];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:slideVC];
    slideVC.slideLockType = button.tag - 10087;
    [self presentViewController:nav animated:YES completion:nil];
}


@end
