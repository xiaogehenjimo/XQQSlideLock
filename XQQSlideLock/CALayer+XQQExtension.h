//
//  CALayer+XQQExtension.h
//  sliderLock
//
//  Created by XQQ on 2016/12/21.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

typedef void(^animationBlock)();
@interface CALayer (XQQExtension)<CAAnimationDelegate>


/** 震动动画 */
- (void)shakeComplete:(animationBlock)complete;

@end
