//
//  XQQSlidePwdOperation.m
//  sliderLock
//
//  Created by XQQ on 2016/12/21.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import "XQQSlidePwdOperation.h"
#import "XQQSlideLockHeader.h"


@implementation XQQSlidePwdOperation

/*上一次密码*/
NSString * _previousPwd = nil;

/*设置密码*/
+ (void)settingPassword:(NSString*)password
          completeBlock:(XQQSlideSetPwdBlock)completeBlock{
    if (password.length < 4 &&_previousPwd == nil) {
        if (completeBlock) {
            completeBlock(NO,XQQSlidePwdOperationSettingTypeMiniNum);
        }
        return;
    }
    if (_previousPwd == nil) {//第一次输入密码
        _previousPwd = password;
        if (completeBlock) {
            completeBlock(NO,XQQSlidePwdOperationSettingTypeFirstSet);
        }
    }else{
        //第二次输入密码
        if([_previousPwd isEqualToString:password]){
            if (completeBlock) {
                _previousPwd = nil;
                completeBlock(YES,XQQSlidePwdOperationSettingTypeSameFirst);
            }
            [XQQSlidePwdOperation savePwd:password];
        }else{
            if (completeBlock) {
                completeBlock(NO,XQQSlidePwdOperationSettingTypeSameFirst);
            }
        }
    }
}

/*验证密码*/
+ (void)checkPassword:(NSString*)password
        completeBlock:(XQQSlideCheckPwdBlock)completeBlock{
    //先验证是否设置过密码
    if ([XQQSlidePwdOperation isFirst]) {
        if (completeBlock) {
            completeBlock(NO,XQQSlidePwdOperationCheckTypeExist);
        }
    }else{//判断验证的密码是否正确
        if ([password isEqualToString:[XQQSlidePwdOperation getPwd]]) {
            //密码对了
            if (completeBlock) {
                completeBlock(YES,XQQSlidePwdOperationCheckTypeSuccess);
            }
        }else{
            if (completeBlock) {
                completeBlock(NO,XQQSlidePwdOperationCheckTypeDefeated);
            }
        }
    }
}

/*重置密码*/
+ (void)resetPassword:(NSString*)password
        completeBlock:(XQQSlideResetPwdBlock)completeBlock{
    if ([XQQSlidePwdOperation isFirst]) {
        if (completeBlock) {
            completeBlock(NO,XQQSlidePwdOperationResetTypeExist);
        }
    }else{
        if ([[XQQSlidePwdOperation getPwd] isEqualToString:password]) {
            if (completeBlock) {
                completeBlock(YES,XQQSlidePwdOperationResetTypeSuccess);
            }
        }else{
            if (completeBlock) {
                completeBlock(NO,XQQSlidePwdOperationResetTypeDefeated);
            }
        }
    }
}


/*判断是否是第一次输入密码*/
+ (BOOL)isFirst{
    return [XQQSlidePwdOperation getPwd] ? NO : YES;
}

/*获取密码*/
+ (NSString*)getPwd{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults synchronize];
    return [userDefaults valueForKey:passWordKey];
}

/*保存密码*/
+ (void)savePwd:(NSString*)pwd{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:pwd forKey:passWordKey];
    [userDefaults synchronize];
}
@end
