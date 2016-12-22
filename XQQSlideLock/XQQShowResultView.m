//
//  XQQShowResultView.m
//  sliderLock
//
//  Created by XQQ on 2016/12/19.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import "XQQShowResultView.h"
#import "XQQSlideLockHeader.h"
@interface XQQShowResultView ()
/*item数组*/
@property (nonatomic, strong) NSMutableArray * items;

@end

@implementation XQQShowResultView

- (instancetype)initWithFrame:(CGRect)frame{
    //CGFloat WH  = MIN(frame.size.width, frame.size.height);
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

- (void)initialize{
    CGFloat space = self.xqq_width / 34.0 * 16 / 4;
    CGFloat itemWH = (self.xqq_width - 4 * space) / 3.0;
    for (NSUInteger i = 0; i < 9; i ++) {
        NSUInteger row = i / 3;
        NSUInteger colum = i % 3;
        CGFloat pointX = space * (colum + 1) + itemWH * colum;
        CGFloat pointY = space * (row + 1) + itemWH * row;
        UIView * item = [[UIView alloc]initWithFrame:CGRectMake(pointX, pointY, itemWH, itemWH)];
        item.backgroundColor = [UIColor whiteColor];
        item.layer.cornerRadius = itemWH * 0.5;
        item.layer.masksToBounds = YES;
        [self addSubview:item];
        [self.items addObject:item];
    }
}

/*结果view重置*/
- (void)resetResuleView{
    for (UIView * view in self.items) {
        view.backgroundColor = [UIColor whiteColor];
    }
}

/*显示滑动结果小视图*/
- (void)showResultView:(NSString*)resultPwd{
    [self resetResuleView];
    for (NSInteger i = 0; i < resultPwd.length; i ++) {
        NSInteger index = [[resultPwd substringWithRange:NSMakeRange(i,1)] integerValue];
        UIView * item = self.items[index];
        item.backgroundColor = XQQLockItemSelectedColor;
    }
}



- (NSMutableArray *)items{
    if (!_items) {
        _items = @[].mutableCopy;
    }
    return _items;
}

@end
