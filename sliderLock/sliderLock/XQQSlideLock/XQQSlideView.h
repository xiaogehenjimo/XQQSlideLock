//
//  XQQSlideView.h
//  sliderLock
// 滑动解锁的主view
//  Created by XQQ on 2016/12/16.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum :NSInteger{
    XQQSlideLockSet = 0,//设置密码
    XQQSlideLockCheck,  //验证密码
    XQQSlideLockReset   //重置密码
}XQQSlideLockType;

@protocol XQQSlideViewDelegate <NSObject>
@optional
/*获取到密码*/
- (void)slideViewDidGetPassword:(NSString*)password;

@end

typedef void(^XQQSlideLockCompleteBlock)(NSString * password);

@interface XQQSlideView : UIView
/** 代理 */
@property(nonatomic, weak)  id<XQQSlideViewDelegate>  delegate;
/** 设置密码类型 */
@property(nonatomic, assign)  XQQSlideLockType   slideLockType;

/*初始化*/
+ (instancetype)slideViewWithFrame:(CGRect)frame
                     completeBlock:(XQQSlideLockCompleteBlock)completeBlock;

- (instancetype)initWithFrame:(CGRect)frame
                completeBlock:(XQQSlideLockCompleteBlock)completeBlock;


@end
