//
//  DataCenter.h
//  SeaTransfer
//
//  Created by Cao JianRong on 14-4-28.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataCenter : NSObject
{
    NSString *userName;
    BOOL isLogin;
    BOOL isQuite;
    NSMutableDictionary *userInfo;
}
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, assign) BOOL isQuite;
@property (nonatomic, retain) NSMutableDictionary *userInfo;

+(DataCenter*)shareInstance;

@end
