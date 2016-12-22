//
//  CALayer+XQQExtension.m
//  sliderLock
//
//  Created by XQQ on 2016/12/21.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import "CALayer+XQQExtension.h"

animationBlock block = nil;

@implementation CALayer (XQQExtension)


- (void)shakeComplete:(animationBlock)complete{
    block = complete;
    CAKeyframeAnimation *kfa = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    kfa.delegate = self;
    CGFloat s = 16;
    
    kfa.values = @[@(-s),@(0),@(s),@(0),@(-s),@(0),@(s),@(0)];
    
    //时长
    kfa.duration = .1f;
    
    //重复
    kfa.repeatCount =2;
    
    //移除
    kfa.removedOnCompletion = YES;
    
    [self addAnimation:kfa forKey:@"shake"];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (block) {
        block();
    }
}

@end
