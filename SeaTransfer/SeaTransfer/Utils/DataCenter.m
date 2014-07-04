//
//  DataCenter.m
//  SeaTransfer
//
//  Created by Cao JianRong on 14-4-28.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "DataCenter.h"

@implementation DataCenter
@synthesize isLogin;
@synthesize isQuite;
@synthesize userName;
@synthesize userInfo;

static DataCenter *m_DataCenter = nil;

+(DataCenter*)shareInstance {
    @synchronized(self)
	{
		if (m_DataCenter == nil)
		{
			m_DataCenter = [[DataCenter alloc] init];
		}
	}
	return m_DataCenter;
}

- (id)init {
    self = [super init];
    if (self) {
        self.userName = @"";
        self.isLogin = NO;
        self.isQuite = NO;
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        self.userInfo = dic;
        [dic release];
    }
    return self;
}

-(void) dealloc
{
    [userInfo release];
    [userName release];
    [super dealloc];
}

@end
