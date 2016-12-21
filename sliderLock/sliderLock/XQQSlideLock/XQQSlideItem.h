//
//  XQQSlideItem.h
//  sliderLock
// 滑动解锁的小视图
//  Created by XQQ on 2016/12/16.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSInteger{
    XQQSlideViewItemNormal = 0,
    XQQSlideViewItemSelectd,
    XQQSlideViewItemWrong
}XQQSlideViewItemType;

@interface XQQSlideItem : UIView
/** item的状态 */
@property(nonatomic, assign)  XQQSlideViewItemType   itemType;
/** 当前item的标记 */
@property(nonatomic, assign)  NSInteger   index;

+ (instancetype)itemWithFrame:(CGRect)frame;

/*调整箭头的方向*/
- (void)adjustAngleFromPoint:(CGPoint)fp toPoint:(CGPoint)tp;

@end
