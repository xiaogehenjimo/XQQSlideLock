//
//  XQQSlideView.m
//  sliderLock
//
//
//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖保佑             永无BUG
//          佛曰:
//                  写字楼里写字间，写字间里程序员；
//                  程序人员写程序，又拿程序换酒钱。
//                  酒醒只在网上坐，酒醉还来网下眠；
//                  酒醉酒醒日复日，网上网下年复年。
//                  但愿老死电脑间，不愿鞠躬老板前；
//                  奔驰宝马贵者趣，公交自行程序员。
//                  别人笑我忒疯癫，我笑自己命太贱；
//                  不见满街漂亮妹，哪个归得程序员？
//  Created by 徐勤强 on 2016/12/16.
//  Copyright © 2016年 UIPower. All rights reserved.
//

#import "XQQSlideView.h"
#import "XQQSlideItem.h"
#import <AudioToolbox/AudioToolbox.h>
#import "CALayer+XQQExtension.h"
#import "XQQShowResultView.h"
#import "XQQSlideLockView.h"
#import "XQQSlideLockHeader.h"
#import "XQQReminderView.h"
#import "XQQSlidePwdOperation.h"

@interface XQQSlideView ()
/** 滑动结果View */
@property (nonatomic, strong)  XQQReminderView   *  reminderView;
/** 滑动解锁的View */
@property (nonatomic, strong)  XQQSlideLockView  *  lockView;
/** 完成的block */
@property (nonatomic, copy)  XQQSlideLockCompleteBlock  complete;

@end

@implementation XQQSlideView

/*初始化*/

+ (instancetype)slideViewWithFrame:(CGRect)frame
                     completeBlock:(XQQSlideLockCompleteBlock)completeBlock{
    return [[self alloc]initWithFrame:frame completeBlock:completeBlock];
}

- (instancetype)initWithFrame:(CGRect)frame
                completeBlock:(XQQSlideLockCompleteBlock)completeBlock{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
        _complete = completeBlock;
    }
    return self;
}

- (void)initUI{
    __weak typeof(self) weakSelf = self;
    //上部分为滑动结果小View
    _reminderView = [[XQQReminderView alloc]initWithFrame:CGRectMake(0, 0, self.xqq_width, self.xqq_height * 0.3)];
    _reminderView.backgroundColor = XQQColor(11, 36, 72);
    [self addSubview:_reminderView];
    //滑动解锁的View
    _lockView = [[XQQSlideLockView alloc]initWithFrame:CGRectMake(0, _reminderView.xqq_bottom, self.xqq_width, self.xqq_height * 0.7)];
    _lockView.completeBlock = ^(NSString * password){
        if (self.delegate&&[self.delegate respondsToSelector:@selector(slideViewDidGetPassword:)]) {
            [weakSelf.delegate slideViewDidGetPassword:password];
        }
        [weakSelf gestureLockUseType:password];
    };
    _lockView.backgroundColor = XQQColor(11, 36, 72);
    [self addSubview:_lockView];
}


- (void)sync:(NSString*)password{
    if (password.length >= 4) {
        //同步上面的View
        [_reminderView.resultView showResultView:password];
    }
}


/*判断当前密码状态*/
- (void)gestureLockUseType:(NSString*)password{
    switch (self.slideLockType) {
        case XQQSlideLockSet:{//设置密码
            [XQQSlidePwdOperation settingPassword:password completeBlock:^(BOOL isSuccess, XQQSlidePwdOperationSetType states) {
                if (states == XQQSlidePwdOperationSettingTypeMiniNum) {
                    [self setSuggestLabel:@"密码不能小于4位" isNormal:NO];
                }else if (states == XQQSlidePwdOperationSettingTypeFirstSet){
                    [self sync:password];
                    [self setSuggestLabel:@"请再次确认密码" isNormal:YES];
                }else if(states == XQQSlidePwdOperationSettingTypeSameFirst){
                    if (isSuccess) {
                        [self setSuggestLabel:@"设置密码成功" isNormal:YES];
                        [self sync:password];
                        //验证成功回调
                        if (_complete) {
                            _complete(password);
                        }
                    }else{
                        [self setSuggestLabel:@"两次密码输入不一致" isNormal:NO];
                    }
                }
            }];
        }
            break;
        case XQQSlideLockCheck:{//验证密码
            [XQQSlidePwdOperation checkPassword:password completeBlock:^(BOOL isSuccess, XQQSlidePwdOperationCheckType states) {
                if (states == XQQSlidePwdOperationCheckTypeExist) {
                    [self setSuggestLabel:@"您还没有设置过密码,请先设置密码" isNormal:NO];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        self.slideLockType = XQQSlideLockSet;
                    });
                }else if (states == XQQSlidePwdOperationCheckTypeSuccess){
                    [self setSuggestLabel:@"密码验证通过" isNormal:YES];
                    [self sync:password];
                    //验证成功回调
                    if (_complete) {
                        _complete(password);
                    }
                }else if(states == XQQSlidePwdOperationCheckTypeDefeated){
                    [self setSuggestLabel:@"密码验证失败,请重新验证" isNormal:NO];
                }
            }];
        }
            break;
        case XQQSlideLockReset:{//重置密码
            [XQQSlidePwdOperation checkPassword:password completeBlock:^(BOOL isSuccess, XQQSlidePwdOperationCheckType states) {
                if (states == XQQSlidePwdOperationResetTypeExist) {
                    [self setSuggestLabel:@"您还没有设置过密码,请先设置密码" isNormal:NO];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        self.slideLockType = XQQSlideLockSet;
                    });
                }else if (states == XQQSlidePwdOperationResetTypeSuccess){
                    [self setSuggestLabel:@"请重置密码" isNormal:YES];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        self.slideLockType = XQQSlideLockSet;
                    });
                }else if(states == XQQSlidePwdOperationResetTypeDefeated){
                    [self setSuggestLabel:@"密码验证失败,请重新验证" isNormal:NO];
                }
            }];
        }
            break;
        default:
            break;
    }
}


/*设置滑动类型*/
- (void)setSlideLockType:(XQQSlideLockType)slideLockType{
    _slideLockType = slideLockType;
    switch (slideLockType) {
        case XQQSlideLockSet:{//设置密码
            [self setSuggestLabel:@"请滑动设置密码" isNormal:YES];
        }
            break;
        case XQQSlideLockCheck:{//验证密码
            [self setSuggestLabel:@"请输入密码" isNormal:YES];
        }
            break;
        case XQQSlideLockReset:{//重置密码
            [self setSuggestLabel:@"请输入原密码" isNormal:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - setter&getter

/*设置提示label的文字*/
- (void)setSuggestLabel:(NSString*)title isNormal:(BOOL)isNormal{
    _reminderView.reminderLabel.text = title;
    _reminderView.reminderLabel.textColor = isNormal ? [UIColor whiteColor]: [UIColor redColor];
    if (!isNormal) {
        [_reminderView.reminderLabel.layer shakeComplete:nil];
        //震动
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
}

@end
