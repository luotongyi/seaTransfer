//
//  PublicDefine.h
//  SeaShipping
//
//  Created by Cao JianRong on 14-4-28.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#ifndef SeaShipping_PublicDefine_h
#define SeaShipping_PublicDefine_h

//屏幕高和宽
#define kScreenHeight ([[UIScreen mainScreen] bounds].size.height)
#define kScreenWidth ([[UIScreen mainScreen] bounds].size.width)

#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define rgbaColor(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define alertMessage(x) {UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:x delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];[alertView show];[alertView release];}

#define isIOS7     ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

#define kRemmemberPassword @"remmemberPassword"
#define kAutoLogin @"autoLogin"

#endif
