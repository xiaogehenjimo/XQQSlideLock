//
//  XQQSlidePwdOperation.h
//  sliderLock
//
//  Created by XQQ on 2016/12/21.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import <Foundation/Foundation.h>

/*设置密码的状态枚举*/
//typedef enum: NSInteger{
//    XQQSlidePwdOperationSettingTypeMiniNum = 0, //密码的最小位数
//    XQQSlidePwdOperationSettingTypeFirstSet,    //设置的第一次密码
//    XQQSlidePwdOperationSettingTypeSameFirst    //是否与第一次设置的一致
//}XQQSlidePwdOperationSetType;

typedef NS_ENUM(NSInteger,XQQSlidePwdOperationSetType){
    XQQSlidePwdOperationSettingTypeMiniNum = 0, //密码的最小位数
    XQQSlidePwdOperationSettingTypeFirstSet,    //设置的第一次密码
    XQQSlidePwdOperationSettingTypeSameFirst    //是否与第一次设置的一致
};


/*验证密码的枚举*/
//typedef enum: NSInteger{
//    XQQSlidePwdOperationCheckTypeExist = 0, //是否设置过密码
//    XQQSlidePwdOperationCheckTypeSuccess,   //验证成功
//    XQQSlidePwdOperationCheckTypeDefeated   //验证失败
//}XQQSlidePwdOperationCheckType;

typedef NS_ENUM(NSInteger,XQQSlidePwdOperationCheckType){
    XQQSlidePwdOperationCheckTypeExist = 0, //是否设置过密码
    XQQSlidePwdOperationCheckTypeSuccess,   //验证成功
    XQQSlidePwdOperationCheckTypeDefeated   //验证失败
};

/*重置密码的枚举*/
//typedef enum: NSInteger{
//    XQQSlidePwdOperationResetTypeExist = 0, //是否设置过密码
//    XQQSlidePwdOperationResetTypeSuccess,   //验证成功
//    XQQSlidePwdOperationResetTypeDefeated   //验证失败
//}XQQSlidePwdOperationResetType;

typedef NS_ENUM(NSInteger,XQQSlidePwdOperationResetType){
    XQQSlidePwdOperationResetTypeExist = 0, //是否设置过密码
    XQQSlidePwdOperationResetTypeSuccess,   //验证成功
    XQQSlidePwdOperationResetTypeDefeated   //验证失败
};





/*设置密码的block*/
typedef void(^XQQSlideSetPwdBlock)(BOOL isSuccess,XQQSlidePwdOperationSetType states);
/*验证密码的block*/
typedef void(^XQQSlideCheckPwdBlock)(BOOL isSuccess,XQQSlidePwdOperationCheckType states);
/*重置密码的block*/
typedef void(^XQQSlideResetPwdBlock)(BOOL isSuccess,XQQSlidePwdOperationResetType states);

@interface XQQSlidePwdOperation : NSObject

/*判断是否是第一次输入密码*/
+ (BOOL)isFirst;
/*设置密码*/
+ (void)settingPassword:(NSString*)password
          completeBlock:(XQQSlideSetPwdBlock)completeBlock;
/*验证密码*/
+ (void)checkPassword:(NSString*)password
        completeBlock:(XQQSlideCheckPwdBlock)completeBlock;
/*重置密码*/
+ (void)resetPassword:(NSString*)password
        completeBlock:(XQQSlideResetPwdBlock)completeBlock;
@end
