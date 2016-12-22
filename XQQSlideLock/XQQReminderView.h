//
//  XQQReminderView.h
//  sliderLock
//
//  Created by XQQ on 2016/12/19.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XQQSlideLockHeader.h"
#import "XQQShowResultView.h"
@interface XQQReminderView : UIView
/** 结果视图 */
@property(nonatomic, strong)  XQQShowResultView * resultView;
/** 中间提示的label */
@property(nonatomic, strong)  UILabel  *  reminderLabel;

@end
