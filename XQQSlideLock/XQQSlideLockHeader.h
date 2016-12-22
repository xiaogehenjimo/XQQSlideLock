//
//  XQQSlideLockHeader.h
//  sliderLock
//
//  Created by XQQ on 2016/12/19.
//  Copyright © 2016年 UIP. All rights reserved.
//

#ifndef XQQSlideLockHeader_h
#define XQQSlideLockHeader_h

/*颜色相关*/
#define XQQColorAlpa(r,g,b,a)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define XQQColor(r,g,b)         XQQColorAlpa((r),(g),(b),255)


/*未选中的颜色*/
#define XQQLockItemNormalColor   XQQColor(211, 211, 240)
/*选中的颜色*/
#define XQQLockItemSelectedColor XQQColor(23, 146, 193)
/*错误的颜色*/
#define XQQLockItemWrongColor     [UIColor redColor]



/*frame 相关*/
#define boardWidth 10

/*密码相关*/
#define passwordLenth 4
/*本地存储key*/
#define passWordKey @"XQQSlidePwdKey"


#import "XQQSlideItem.h"
#import "UIView+XQQExtension.h"

#endif /* XQQSlideLockHeader_h */
