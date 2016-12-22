//
//  XQQSlideLockView.h
//  sliderLock
//
//  Created by XQQ on 2016/12/19.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^didSlideCompleteBlock)(NSString * password);
@interface XQQSlideLockView : UIView

/** 设置完密码 */
@property (nonatomic, copy)  didSlideCompleteBlock  completeBlock;

@end
