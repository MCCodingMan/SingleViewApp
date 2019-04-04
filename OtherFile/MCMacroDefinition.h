//
//  MCMacroDefinition.h
//  SingleViewAPP
//
//  Created by wr on 2019/4/2.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#ifndef MCMacroDefinition_h
#define MCMacroDefinition_h

//屏幕大小
#define MC_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define MC_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
//颜色宏定义
#define MC_COLOR_RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define MC_COLOR_RGB(r,g,b) MC_COLOR_RGBA(r,g,b,1.0f)
#define MC_COLOR_HEX(hex) MC_COLOR_HEXA(hex,1.0f)
#define MC_COLOR_HEXA(rgbValue,a) [UIColor colorWithRed:((float)(((rgbValue) & 0xFF0000) >> 16))/255.0 green:((float)(((rgbValue) & 0xFF00)>>8))/255.0 blue: ((float)((rgbValue) & 0xFF))/255.0 alpha:(a)]
#define MC_COLOR_RANDOM [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
//字体宏定义
#define MC_UIFont(fontSize) [UIFont systemFontOfSize:fontSize]
#define MC_UIBoldFont(fontSize) [UIFont boldSystemFontOfSize:fontSize]

#define MC_ImageWithName(imgName) [UIImage imageNamed:imgName]
//单利宏定义
#define MC_KeyWindow [UIApplication sharedApplication].keyWindow
#define MC_UserDefaults [NSUserDefaults standardUserDefaults]
//网络请求单列
#define MC_NetWorkRequest [MCNetWorkRequest shareRequest]
//永久存储对象
#define MC_SetUserDefaults(object, key)                                                                                                 \
({                                                                                                                                             \
[MC_UserDefaults setObject:object forKey:key];                                                                                                    \
[MC_UserDefaults synchronize];                                                                                                                    \
})
#define MC_GetUserDefaultsWithKey(key) [MC_UserDefaults objectForKey:key]
//通知宏定义
#define MC_NotificationCenter [NSNotificationCenter defaultCenter]
#define MC_PostNotification(name,obj,info) [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj userInfo:info]
//弱引用
#define MC_Weak_Self(type)  __weak typeof(type) weak##type = type
//加载XIB宏定义
#define MC_Load_Xib(xibName) [UINib nibWithNibName:xibName bundle:[NSBundle mainBundle]]
//字符串组装
#define MC_String_StringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]
//view 圆角
#define MC_ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]
// View 圆角和加边框
#define MC_ViewBorder(View, Width, Color)\
\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

#endif /* MCMacroDefinition_h */
