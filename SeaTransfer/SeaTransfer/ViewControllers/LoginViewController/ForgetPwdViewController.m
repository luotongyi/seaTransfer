//
//  ForgetPwdViewController.m
//  SeaTransfer
//
//  Created by luotongyi on 14-8-6.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "ForgetPwdViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ForgetPwdViewController ()

@end

@implementation ForgetPwdViewController

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
    self.title = @"忘记密码";
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
	
    UILabel *nametab = [[UILabel alloc] initWithFrame:CGRectMake(20, 45, 60, 20)];
    nametab.text = @"用户名：";
    nametab.textColor = [UIColor blackColor];
    nametab.backgroundColor = [UIColor clearColor];
    nametab.font = [UIFont systemFontOfSize:13.0f];
    [self.view addSubview:nametab];
    [nametab release];
    
    nameTf = [[UITextField alloc] initWithFrame:CGRectMake(85, 40, 200, 30)];
    nameTf.delegate = self;
    nameTf.layer.borderColor = HEXCOLOR(0xEBEBEB).CGColor;
    nameTf.layer.borderWidth = 1.0f;
    nameTf.backgroundColor = [UIColor whiteColor];
    nameTf.borderStyle = UITextBorderStyleNone;
    nameTf.placeholder = @"用户名:";
    nameTf.text = @"";
    nameTf.font = [UIFont systemFontOfSize:13.0f];
    nameTf.textColor = [UIColor darkGrayColor];
    [self.view addSubview:nameTf];
    
    nametab = [[UILabel alloc] initWithFrame:CGRectMake(20, 85, 60, 20)];
    nametab.text = @"密  码：";
    nametab.textColor = [UIColor blackColor];
    nametab.backgroundColor = [UIColor clearColor];
    nametab.font = [UIFont systemFontOfSize:13.0f];
    [self.view addSubview:nametab];
    [nametab release];
    
    emailTf = [[UITextField alloc] initWithFrame:CGRectMake(85, 80, 200, 30)];
    emailTf.delegate = self;
    emailTf.text = @"";
    emailTf.layer.borderColor = HEXCOLOR(0xEBEBEB).CGColor;
    emailTf.layer.borderWidth = 1.0f;
    emailTf.backgroundColor = [UIColor whiteColor];
    emailTf.borderStyle = UITextBorderStyleNone;
    emailTf.placeholder = @"电子邮箱:";
    emailTf.font = [UIFont systemFontOfSize:13.0f];
    emailTf.textColor = [UIColor darkGrayColor];
    [self.view addSubview:emailTf];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
