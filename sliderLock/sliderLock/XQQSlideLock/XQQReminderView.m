//
//  XQQReminderView.m
//  sliderLock
//
//  Created by XQQ on 2016/12/19.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import "XQQReminderView.h"

@implementation XQQReminderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    _resultView = [[XQQShowResultView alloc]initWithFrame:CGRectMake(0, 0, self.xqq_height * 0.6, self.xqq_height * 0.6)];
    _resultView.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.4);
    [self addSubview:_resultView];
    _reminderLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _resultView.xqq_bottom + 10, self.xqq_width, self.xqq_height * 0.2)];
    _reminderLabel.textAlignment = NSTextAlignmentCenter;
    _reminderLabel.font = [UIFont systemFontOfSize:17];
    //_reminderLabel.backgroundColor = [UIColor redColor];
    [self addSubview:_reminderLabel];
    
}

@end
