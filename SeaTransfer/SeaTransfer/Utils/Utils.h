//
//  Utils.h
//  SeaTransfer
//
//  Created by Cao JianRong on 14-4-28.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

// NSDictionary To NSString
+(NSString*)DataTOjsonString:(id)object;

//TODO:缩放图片
+(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;

@end
