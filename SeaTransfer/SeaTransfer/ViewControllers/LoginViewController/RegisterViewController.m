//
//  RegisterViewController.m
//  SeaTransfer
//
//  Created by luotongyi on 14-8-6.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "RegisterViewController.h"

#import <QuartzCore/QuartzCore.h>

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    self.title = @"注册";
    self.view.backgroundColor = HEXCOLOR(0x6981FE);
    
    //TODO:定制自己的风格的  左UIBarButtonItem
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(5, 5, 30, 30);
    [backButton setBackgroundImage:[UIImage imageNamed:@"navBar_back"] forState:UIControlStateNormal];
    //    [backButton setBackgroundImage:[UIImage imageNamed:@"music_navigationbar_back"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:someBarButtonItem];
    [someBarButtonItem release];
    
}

- (void)goBack {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    wfplatform/user_reg.action
//    clientName：用户名
//    clientPwd：登录密码
//    clientRePwd：确认密码
//    companyName：公司名称
//    clientMobile：手机号码
//    clientEmail:电子邮件
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
