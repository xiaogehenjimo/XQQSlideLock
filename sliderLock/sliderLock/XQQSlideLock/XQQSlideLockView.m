//
//  XQQSlideLockView.m
//  sliderLock
//
//  Created by XQQ on 2016/12/19.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import "XQQSlideLockView.h"
#import "XQQSlideItem.h"
#import "XQQSlideLockHeader.h"
#import <AudioToolbox/AudioToolbox.h>

@interface XQQSlideLockView ()
/** itemArr */
@property(nonatomic, strong)  NSMutableArray <XQQSlideItem*> * items;
/** 选中的数组 */
@property(nonatomic, strong)  NSMutableArray <XQQSlideItem*> *  selectedArr;
/** 当前触摸的点  */
@property(nonatomic, assign)  CGPoint   currentPoint;

@end

@implementation XQQSlideLockView


#pragma mark - 初始化方法

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}
- (void)initialize{
    //self.backgroundColor = [UIColor yellowColor];
    self.clearsContextBeforeDrawing = YES;
    [self initUI];
}

- (void)initUI{
    CGFloat space = self.xqq_width / 34.0 * 16 / 4;
    CGFloat itemWH = (self.xqq_width - 4 * space) / 3.0;
    for (NSUInteger i = 0; i < 9; i ++) {
        NSUInteger row = i / 3;
        NSUInteger colum = i % 3;
        CGFloat pointX = space * (colum + 1) + itemWH * colum;
        CGFloat pointY = space * (row + 1) + itemWH * row;
        XQQSlideItem * item = [XQQSlideItem itemWithFrame:CGRectMake(pointX, pointY, itemWH, itemWH)];
        item.index = i;
        item.itemType = XQQSlideViewItemNormal;
        [self addSubview:item];
        [self.items addObject:item];
    }
}

#pragma mark - activity

/*密码长度小于4位*/
- (void)wrongPassWord{
    NSLog(@"密码长度小于4位");
}

#pragma mark - 触摸方法

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    CGPoint touchPoint = [self getTouchPoint:event];
    [self scanfItemWithPoint:touchPoint];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    CGPoint touchPoint = [self getTouchPoint:event];
    [self scanfItemWithPoint:touchPoint];
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    //拿到当前密码
    NSString * currentPassWord = [self getCurrentPassWord];
    if (self.completeBlock) {
        self.completeBlock(currentPassWord);
//        currentPassWord.length < passwordLenth ? [self wrongPassWord]: self.completeBlock(currentPassWord);
    }
    [self resetItem];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
    [self resetItem];
}

#pragma mark - 画图

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (self.selectedArr.count <= 0)  return;
    
     UIBezierPath * bezierPath = [UIBezierPath bezierPath];
    
    for (NSInteger i = 0; i < self.selectedArr.count; i ++) {
        //取出item
        XQQSlideItem * item = self.selectedArr[i];
        //取出每个item的中心点
        CGPoint itemCenter = [self getItemCenter:item];
        if (i == 0) {
            [bezierPath moveToPoint:itemCenter];
        }else{
            [bezierPath addLineToPoint:itemCenter];
            //计算前一个item的箭头相对于当前item的角度
            XQQSlideItem * previousItem = self.selectedArr[i - 1];
            [previousItem adjustAngleFromPoint:[self getItemCenter:previousItem] toPoint:itemCenter];
        }
    }
    //当前点
    [bezierPath addLineToPoint:self.currentPoint];
    bezierPath.lineWidth = 10;
    bezierPath.lineCapStyle = kCGLineCapRound;
    bezierPath.lineJoinStyle = kCGLineJoinRound;
    [XQQLockItemSelectedColor setStroke];
    [bezierPath stroke];
}

#pragma mark - setter&getter

/*获取当前滑动的密码*/
- (NSString*)getCurrentPassWord{
    NSMutableString * passwordStr = @"".mutableCopy;
    for (XQQSlideItem * item in self.selectedArr) {
        [passwordStr appendString:[NSString stringWithFormat:@"%ld",item.index]];
    }
    return passwordStr;
}

/*扫描当前的触摸点在哪个item上*/
- (void)scanfItemWithPoint:(CGPoint)touchPoint{
    for (XQQSlideItem * item in self.items) {
        //如果当前触摸点在item的范围内 且item的状态是默认未选中的,且选中item的数组里没有包含这个item  添加到选中的数组里
        if (CGRectContainsPoint(item.frame, touchPoint)&& ![self.selectedArr containsObject:item] && item.itemType == XQQSlideViewItemNormal) {
            //修改item的状态为选中状态
            item.itemType = XQQSlideViewItemSelectd;
            //播放音频
            [self playMusic];
            //震动
             //AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            [self.selectedArr addObject:item];
        }
    }
}

/*播放音频*/
- (void)playMusic{
    static SystemSoundID soundIDTest = 0;
    NSString * path = [[NSBundle mainBundle] pathForResource:@"music" ofType:@"wav"];
    if (path) {
        AudioServicesCreateSystemSoundID( (__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundIDTest );
    }
    AudioServicesPlaySystemSound(soundIDTest);
}

/*重置所有的item为初始状态*/
- (void)resetItem{
    for (XQQSlideItem * item in self.items) {
        item.itemType = XQQSlideViewItemNormal;
    }
    [self.selectedArr removeAllObjects];
    [self setNeedsDisplay];
}

/* 获取触摸点*/
- (CGPoint)getTouchPoint:(UIEvent*)event{
    NSSet * allTouches = [event allTouches];
    UITouch *touch = [allTouches anyObject];
    CGPoint point = [touch locationInView:self];
    self.currentPoint = point;
    return point;
}

/*获取到item的中心点*/
- (CGPoint)getItemCenter:(XQQSlideItem*)item{
    return CGPointMake(item.xqq_centerX, item.xqq_centerY);
}

- (NSMutableArray<XQQSlideItem *> *)items{
    if (_items == nil) {
        _items = @[].mutableCopy;
    }
    return _items;
}

- (NSMutableArray<XQQSlideItem *> *)selectedArr{
    if (!_selectedArr) {
        _selectedArr = @[].mutableCopy;
    }
    return _selectedArr;
}


@end
