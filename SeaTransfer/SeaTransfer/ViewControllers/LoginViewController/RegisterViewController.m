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

#define kInputTfTag 100

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
    
    //    baseScrollview = [[UIScrollView alloc]initWithFrame:self.view.frame];
    //    [self.view addSubview:baseScrollview];
    //    baseScrollview.contentSize = CGSizeMake(320, 600);
    
    //TODO:定制自己的风格的  左UIBarButtonItem
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(5, 5, 30, 30);
    [backButton setBackgroundImage:[UIImage imageNamed:@"navBar_back"] forState:UIControlStateNormal];
    //    [backButton setBackgroundImage:[UIImage imageNamed:@"music_navigationbar_back"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:someBarButtonItem];
    [someBarButtonItem release];
    
    //各种控件
    UILabel *label;
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 70, 20)];
    label.font = [UIFont systemFontOfSize:14];
    label.text = @"用 户 名:";
    [self.view addSubview:label];
    [label release];
    
    tf1 = [[UITextField alloc]initWithFrame:CGRectMake(100, 20, 150, 20)];
    tf1.delegate = self;
    tf1.placeholder = @"请输入用户名";
    tf1.text = @"";
    tf1.adjustsFontSizeToFitWidth = YES;
    tf1.borderStyle = UITextBorderStyleNone;
    tf1.layer.borderColor = HEXCOLOR(0xEBEBEB).CGColor;
    tf1.layer.borderWidth = 1.0f;
    tf1.backgroundColor = [UIColor whiteColor];
    tf1.tag = kInputTfTag;
    [self.view addSubview:tf1];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(20, 50, 70, 20)];
    label.font = [UIFont systemFontOfSize:14];
    label.text = @"登录密码:";
    [self.view addSubview:label];
    [label release];
    
    tf2 = [[UITextField alloc]initWithFrame:CGRectMake(100, 50, 150, 20)];
    tf2.placeholder = @"请输入密码";
    tf2.text = @"";
    tf2.adjustsFontSizeToFitWidth = YES;
    tf2.delegate = self;
    tf2.borderStyle = UITextBorderStyleNone;
    tf2.layer.borderColor = HEXCOLOR(0xEBEBEB).CGColor;
    tf2.layer.borderWidth = 1.0f;
    tf2.backgroundColor = [UIColor whiteColor];
    tf2.tag = kInputTfTag+1;
    [self.view addSubview:tf2];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(20, 80, 70, 20)];
    label.font = [UIFont systemFontOfSize:14];
    label.text = @"确认密码:";
    [self.view addSubview:label];
    [label release];
    
    tf3 = [[UITextField alloc]initWithFrame:CGRectMake(100, 80, 150, 20)];
    tf3.placeholder = @"请确认密码";
    tf3.text = @"";
    tf3.adjustsFontSizeToFitWidth = YES;
    tf3.delegate = self;
    tf3.borderStyle = UITextBorderStyleNone;
    tf3.layer.borderColor = HEXCOLOR(0xEBEBEB).CGColor;
    tf3.layer.borderWidth = 1.0f;
    tf3.backgroundColor = [UIColor whiteColor];
    tf3.tag = kInputTfTag+2;
    [self.view addSubview:tf3];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(20, 110, 70, 20)];
    label.font = [UIFont systemFontOfSize:14];
    label.text = @"手 机 号:";
    [self.view addSubview:label];
    [label release];
    
    tf4 = [[UITextField alloc]initWithFrame:CGRectMake(100, 110, 150, 20)];
    tf4.placeholder = @"请输入手机号";
    tf4.text = @"";
    tf4.adjustsFontSizeToFitWidth = YES;
    tf4.delegate = self;
    tf4.borderStyle = UITextBorderStyleNone;
    tf4.layer.borderColor = HEXCOLOR(0xEBEBEB).CGColor;
    tf4.layer.borderWidth = 1.0f;
    tf4.backgroundColor = [UIColor whiteColor];
    tf4.tag = kInputTfTag+3;
    [self.view addSubview:tf4];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(20, 140, 70, 20)];
    label.font = [UIFont systemFontOfSize:14];
    label.text = @"邮\t箱:";
    [self.view addSubview:label];
    [label release];
    
    tf5 = [[UITextField alloc]initWithFrame:CGRectMake(100, 140, 150, 20)];
    tf5.placeholder = @"请输入邮箱";
    tf5.text = @"";
    tf5.adjustsFontSizeToFitWidth = YES;
    tf5.delegate = self;
    tf5.borderStyle = UITextBorderStyleNone;
    tf5.layer.borderColor = HEXCOLOR(0xEBEBEB).CGColor;
    tf5.layer.borderWidth = 1.0f;
    tf5.backgroundColor = [UIColor whiteColor];
    tf5.tag = kInputTfTag+4;
    [self.view addSubview:tf5];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(20, 170, 70, 20)];
    label.font = [UIFont systemFontOfSize:14];
    label.text = @"公司名称:";
    [self.view addSubview:label];
    [label release];
    
    tf6 = [[UITextField alloc]initWithFrame:CGRectMake(100, 170, 150, 20)];
    tf6.placeholder = @"请输入公司名称";
    tf6.text = @"";
    tf6.adjustsFontSizeToFitWidth = YES;
    tf6.delegate = self;
    tf6.borderStyle = UITextBorderStyleNone;
    tf6.layer.borderColor = HEXCOLOR(0xEBEBEB).CGColor;
    tf6.layer.borderWidth = 1.0f;
    tf6.backgroundColor = [UIColor whiteColor];
    tf6.tag = kInputTfTag+5;
    [self.view addSubview:tf6];
    
    UIButton *forgetPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetPwdBtn.frame = CGRectMake(20, 200, 260, 30);
    forgetPwdBtn.layer.cornerRadius = 4.0;
    forgetPwdBtn.layer.borderWidth = 1.0;
    forgetPwdBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    forgetPwdBtn.backgroundColor = HEXCOLOR(0x76B8FF);
    [forgetPwdBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [forgetPwdBtn setTitle:@"注  册" forState:UIControlStateNormal];
    [forgetPwdBtn addTarget:self action:@selector(registerInServer:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPwdBtn];
    
}

- (void)registerInServer:(id)sender
{
    if (![self checkInputTf])
    {
        return;
    };
    
    NSString *pathStr=@"http://114.215.103.53/wfplatform/user_reg!reg.action";
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@""]];
    
    httpClient.parameterEncoding = AFFormURLParameterEncoding;   //设置请求参数的类型   plist/json/urlParameter 3种格式
    
    [httpClient setDefaultHeader:@"Accept" value:@"text/json"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         tf1.text,@"client.clientName",
                         tf2.text,@"client.clientPwd",
                         tf3.text,@"client.clientRePwd",
                         tf4.text,@"client.clientMobile",
                         tf5.text,@"client.clientEmail",
                         tf6.text,@"client.companyEname",
                         nil];
    
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
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[info objectForKey:@"title"] message:[info objectForKey:@"detail"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    [alert release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
    }
    else
    {
        [self goBack];
    }
}

- (void)goBack {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (BOOL)checkInputTf
{
    BOOL result = NO;
    if (tf1.text.length == 0)
    {
        alertMessage(@"请输入用户名");
        return result;
    }
    
    if (tf2.text.length == 0)
    {
        alertMessage(@"请输入密码");
        return result ;
    }
    
    if (tf3.text.length == 0)
    {
        alertMessage(@"请输入确认密码");
        return result;
    }
    
    if (![Utils isMobileNumber:tf4.text])
    {
        alertMessage(@"请输入正确的手机号");
        return result;
    }
    
    if (![Utils isEmailAddress:tf5.text])
    {
        alertMessage(@"请输入正确的邮箱地址");
        return result;
    }
    if (tf6.text.length == 0)
    {
        alertMessage(@"请输入公司名称");
        return result;
    }
    
    NSString *pwd,*pwd1;
    for (UITextField *tf in [self.view subviews])
    {
        if (tf.tag == kInputTfTag+1)
        {
            pwd = tf.text;
        }
        if (tf.tag == kInputTfTag+2)
        {
            pwd1 = tf.text;
        }
    }
    if (![pwd isEqualToString:pwd1])
    {
        alertMessage(@"请输入相同的密码");
        return result;
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
}

- (void)dealloc
{
    [tf1 release];
    [tf2 release];
    [tf3 release];
    [tf4 release];
    [tf5 release];
    [tf6 release];
    //    [baseScrollview release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
