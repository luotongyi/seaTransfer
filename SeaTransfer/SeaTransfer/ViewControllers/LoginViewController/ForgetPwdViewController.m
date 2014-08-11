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
	
    UILabel *nametab = [[UILabel alloc] initWithFrame:CGRectMake(20, 45, 70, 20)];
    nametab.text = @"用户名：";
    nametab.textColor = [UIColor blackColor];
    nametab.backgroundColor = [UIColor clearColor];
    nametab.font = [UIFont systemFontOfSize:13.0f];
    [self.view addSubview:nametab];
    [nametab release];
    
    nameTf = [[UITextField alloc] initWithFrame:CGRectMake(95, 40, 200, 30)];
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
    
    nametab = [[UILabel alloc] initWithFrame:CGRectMake(20, 85, 70, 20)];
    nametab.text = @"电子邮箱：";
    nametab.textColor = [UIColor blackColor];
    nametab.backgroundColor = [UIColor clearColor];
    nametab.font = [UIFont systemFontOfSize:13.0f];
    [self.view addSubview:nametab];
    [nametab release];
    
    emailTf = [[UITextField alloc] initWithFrame:CGRectMake(95, 80, 200, 30)];
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
    
    UIButton *forgetPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetPwdBtn.frame = CGRectMake(20, 130, 260, 30);
    forgetPwdBtn.layer.cornerRadius = 4.0;
    forgetPwdBtn.layer.borderWidth = 1.0;
    forgetPwdBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    forgetPwdBtn.backgroundColor = HEXCOLOR(0x76B8FF);
    [forgetPwdBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [forgetPwdBtn setTitle:@"找回密码" forState:UIControlStateNormal];
    [forgetPwdBtn addTarget:self action:@selector(forgetInServer:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPwdBtn];
}

- (void)forgetInServer:(id)sender
{
    NSString *pathStr=@"http://114.215.103.53/wfplatform/user_password!pwd.action";
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@""]];
    
    httpClient.parameterEncoding = AFFormURLParameterEncoding;   //设置请求参数的类型   plist/json/urlParameter 3种格式
    
//    [httpClient setDefaultHeader:@"User-Agent" value:@"Mozilla/5.0 (iphone; Intel Mac OS X 10.6; rv:2.0.1) Gecko/20100101 Firefox/4.0.1"];
    
    [httpClient setDefaultHeader:@"Accept" value:@"text/json"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         @"employee",@"pwd_type",
                         nameTf.text,@"client.clientName",
                         emailTf.text,@"client.clientEmail"
                         ,nil];
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc] initWithDictionary:dic];
    
    [httpClient postPath:pathStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self checkData:responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"[HTTPClient Error]: %@", error);
        
        alertMessage(@"请求失败，请检查网络链接.");
    }];
    
    [params release];
    
    [httpClient release];
}

-(void) checkData:(NSData *)data
{
    NSError *error = nil;
    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *info = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error || !info) {
        alertMessage(@"请求错误，请重新操作");
        return ;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[info objectForKey:@"title"] message:[info objectForKey:@"detail"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
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
