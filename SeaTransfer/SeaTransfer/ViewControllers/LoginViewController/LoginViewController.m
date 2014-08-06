//
//  LoginViewController.m
//  SeaTransfer
//
//  Created by Cao JianRong on 14-4-28.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "LoginViewController.h"

#import "RegisterViewController.h"
#import "ForgetPwdViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    loginView = [[LoginView alloc] initWithFrame:CGRectMake(0, -64, kScreenWidth, kScreenHeight)];
    
    NSLog(@"%.2f,%.2f",kScreenWidth,kScreenHeight);
    
    loginView.delegate = self;
    [self.view addSubview:loginView];
    [loginView release];
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(30, 410, 120, 30);
    registerBtn.layer.cornerRadius = 4.0;
    registerBtn.layer.borderWidth = 1.0;
    registerBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    registerBtn.backgroundColor = HEXCOLOR(0x76B8FF);
    [registerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(rgisterInServer:) forControlEvents:UIControlEventTouchUpInside];
    [loginView addSubview:registerBtn];
    
    UIButton *forgetPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetPwdBtn.frame = CGRectMake(170, 410, 120, 30);
    forgetPwdBtn.layer.cornerRadius = 4.0;
    forgetPwdBtn.layer.borderWidth = 1.0;
    forgetPwdBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    forgetPwdBtn.backgroundColor = HEXCOLOR(0x76B8FF);
    [forgetPwdBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [forgetPwdBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetPwdBtn addTarget:self action:@selector(forgetInServer:) forControlEvents:UIControlEventTouchUpInside];
    [loginView addSubview:forgetPwdBtn];
}

- (void)rgisterInServer:(id)sender
{
    RegisterViewController *controller = [[RegisterViewController alloc]init];
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

- (void)forgetInServer:(id)sender
{
    ForgetPwdViewController *controller = [[ForgetPwdViewController alloc]init];
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

-(void) loginInServce:(NSString *)name withPassword:(NSString *)pwd
{
    NSString *pathStr= @"http://114.215.103.53/j_spring_security_check";
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@""]];//这里要将url设置为空
    
    httpClient.parameterEncoding = AFFormURLParameterEncoding;   //设置请求参数的类型   plist/json/urlParameter 3种格式
    
    [httpClient setDefaultHeader:@"User-Agent" value:@"Mozilla/5.0 (iphone; Intel Mac OS X 10.6; rv:2.0.1) Gecko/20100101 Firefox/4.0.1"];
    
    [httpClient setDefaultHeader:@"Accept" value:@"text/json"];
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc] init];   // 要传递的json数据是一个字典
    
    [params setObject:name forKey:@"j_username"];
    
    [params setObject:pwd forKey:@"j_password"];
    
    [params setObject:@"app" forKey:@"j_user"];
    
    [[NSUserDefaults standardUserDefaults] setValue:name forKey:@"j_username"];
    [[NSUserDefaults standardUserDefaults] setValue:pwd forKey:@"j_password"];
    [[NSUserDefaults standardUserDefaults] setValue:@"app" forKey:@"j_user"];
    
    // httpClient 的postPath就是上文中的pathStr，即你要访问的URL地址，这里是向服务器提交一个数据请求，
    [httpClient postPath:pathStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {

        [self checkData:(NSData *)responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"[HTTPClient Error]: %@", error);
        alertMessage(@"登录失败，请检查网络链接.")
    }];
    
    [params release];
    
    [httpClient release];
}

-(void) checkData:(NSData *) data
{
    NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    
    NSError *error = nil;
    NSDictionary *info = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error || !info) {
        alertMessage(@"登录失败，请重新登录.");
        return ;
    }
    
    for (NSString *key in [info allKeys]) {
        [[DataCenter shareInstance].userInfo setObject:[info objectForKey:key] forKey:key];
    }
    [DataCenter shareInstance].userName = [info objectForKey:@"username"];
    
    [DataCenter shareInstance].isLogin = YES;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSLog(@"Request Successful,:\n %@", info);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
