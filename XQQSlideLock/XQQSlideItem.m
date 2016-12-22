//
//  XQQSlideItem.m
//  sliderLock
//
//  Created by XQQ on 2016/12/16.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import "XQQSlideItem.h"
#import "XQQSlideLockHeader.h"




@interface XQQSlideItem ()
/** 外圆 */
@property(nonatomic, strong)  CAShapeLayer  *  outCircle;
/** 内圆 */
@property(nonatomic, strong)  CAShapeLayer  *  insideCircle;
/** 三角箭头 */
@property(nonatomic, strong)  CAShapeLayer  *  triangle;

@end

@implementation XQQSlideItem

+ (instancetype)itemWithFrame:(CGRect)frame{
    return [[self alloc]initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    //外圆
    UIBezierPath * outPath = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    _outCircle = [[CAShapeLayer alloc]init];
    _outCircle.path = outPath.CGPath;
    _outCircle.lineWidth = 3.5f;
    //_outCircle.strokeColor = XQQLockItemNormalColor.CGColor;
    _outCircle.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:_outCircle];
    //内实心圆
    CGPoint centerPoint;
    centerPoint.x = self.bounds.size.width * 0.5;
    centerPoint.y = self.bounds.size.height * 0.5;
    CGFloat WH = self.bounds.size.width * 0.5;
    CGRect rectss = CGRectMake(centerPoint.x - WH * 0.5, centerPoint.y - WH * 0.5, WH, WH);
    UIBezierPath * insidePath = [UIBezierPath bezierPathWithOvalInRect:rectss];
    _insideCircle = [[CAShapeLayer alloc]init];
    _insideCircle.path = insidePath.CGPath;
    //_insideCircle.fillColor = XQQLockItemNormalColor.CGColor;
    _insideCircle.strokeColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:_insideCircle];
    //方向的三角
    UIBezierPath * trianglePath = [UIBezierPath bezierPath];
    [trianglePath moveToPoint:CGPointMake(self.bounds.size.width * 0.5, self.bounds.origin.y)];
    [trianglePath addLineToPoint:CGPointMake(self.bounds.size.width * 0.35, centerPoint.y - rectss.size.height * 0.5 - 2)];
    [trianglePath addLineToPoint:CGPointMake(self.bounds.size.width * 0.65, centerPoint.y - rectss.size.height * 0.5 - 2)];
    _triangle = [[CAShapeLayer alloc]init];
    _triangle.path = trianglePath.CGPath;
    _triangle.fillColor = XQQLockItemSelectedColor.CGColor;
    [self.layer addSublayer:_triangle];
}

- (void)setItemType:(XQQSlideViewItemType)itemType{
    _itemType = itemType;
    switch (itemType) {
        case XQQSlideViewItemNormal:{//未选中状态
            _insideCircle.fillColor = XQQLockItemNormalColor.CGColor;
            _outCircle.strokeColor = XQQLockItemNormalColor.CGColor;
            _triangle.hidden = YES;
        }
            break;
        case XQQSlideViewItemSelectd:{//选中状态
            _insideCircle.fillColor = XQQLockItemSelectedColor.CGColor;
            _outCircle.strokeColor = XQQLockItemSelectedColor.CGColor;
        }
            break;
        case XQQSlideViewItemWrong:{//失败状态
            _insideCircle.fillColor = XQQLockItemWrongColor.CGColor;
            _outCircle.strokeColor = XQQLockItemWrongColor.CGColor;
            _triangle.hidden = YES;
        }
            break;
        default:
            break;
    }
}

/*调整箭头的方向*/
- (void)adjustAngleFromPoint:(CGPoint)fp toPoint:(CGPoint)tp{
     _triangle.hidden = NO;
    CGFloat h = tp.y - fp.y;
    CGFloat w = tp.x - fp.x;
    CGFloat angle = atan(h / w)  + M_PI_2 + ((w < 0 ) ? M_PI : 0) ;
    self.transform = CGAffineTransformMakeRotation(angle);
}

@end
