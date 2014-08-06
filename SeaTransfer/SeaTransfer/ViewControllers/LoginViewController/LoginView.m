//
//  LoginView.m
//  SeaTransfer
//
//  Created by Cao JianRong on 14-4-28.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "LoginView.h"



@implementation LoginView
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createInitView];
    }
    return self;
}

-(void) createInitView
{
    self.backgroundColor = HEXCOLOR(0x6A7EFF);
    
    CGFloat high = 0.0;
    
    if (!isIOS7) {
        if (kScreenHeight == 568) {
            high = -20.0;
        } else {
            high = -40.0;
        }
        
    }
    
    
    
    bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, high, kScreenWidth, kScreenHeight)];
    bgView.userInteractionEnabled = YES;
    [bgView setImage:[UIImage imageNamed:@"loginBg"]];
    [self addSubview:bgView];
    
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 260 + high, 320, 140)];
    baseView.backgroundColor = [UIColor clearColor];
    [bgView addSubview:baseView];
    
    //    用户名和密码
    UILabel *nametab = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 60, 20)];
    nametab.text = @"用户名：";
    nametab.textColor = [UIColor blackColor];
    nametab.backgroundColor = [UIColor clearColor];
    nametab.font = [UIFont systemFontOfSize:13.0f];
    [baseView addSubview:nametab];
    [nametab release];
    
    name = [[UITextField alloc] initWithFrame:CGRectMake(85, 0, 200, 30)];
    name.delegate = self;
    name.backgroundColor = [UIColor whiteColor];
    name.borderStyle = UITextBorderStyleNone;
    name.placeholder = @"用户名:";
    name.font = [UIFont systemFontOfSize:13.0f];
    name.textColor = [UIColor darkGrayColor];
    [baseView addSubview:name];
    [name release];
    
    nametab = [[UILabel alloc] initWithFrame:CGRectMake(20, 45, 60, 20)];
    nametab.text = @"密  码：";
    nametab.textColor = [UIColor blackColor];
    nametab.backgroundColor = [UIColor clearColor];
    nametab.font = [UIFont systemFontOfSize:13.0f];
    [baseView addSubview:nametab];
    [nametab release];
    
    pwd = [[UITextField alloc] initWithFrame:CGRectMake(85, 40, 200, 30)];
    pwd.delegate = self;
    pwd.backgroundColor = [UIColor whiteColor];
    pwd.borderStyle = UITextBorderStyleNone;
    pwd.secureTextEntry = YES;
    pwd.placeholder = @"密码:";
    pwd.font = [UIFont systemFontOfSize:13.0f];
    pwd.textColor = [UIColor darkGrayColor];
    [baseView addSubview:pwd];
    [pwd release];

    //    记住密码
    UIButton *rememberPassBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rememberPassBtn.tag = 1000;
    rememberPassBtn.frame = CGRectMake(85, 80, 20, 20);
    rememberPassBtn.backgroundColor = [UIColor clearColor];
    [rememberPassBtn setBackgroundImage:[UIImage imageNamed:@"home_login_uncheck"] forState:UIControlStateNormal];
    [rememberPassBtn setBackgroundImage:[UIImage imageNamed:@"home_login_check"] forState:UIControlStateSelected];
    [rememberPassBtn setImageEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    [rememberPassBtn addTarget:self action:@selector(rememberPassword:) forControlEvents:UIControlEventTouchUpInside];
    [baseView addSubview:rememberPassBtn];

    UILabel *rememberLab = [[UILabel alloc] initWithFrame:CGRectMake(110, 80, 82, 20)];
    rememberLab.text = @"记住密码";
    rememberLab.textColor = [UIColor blackColor];
    rememberLab.backgroundColor = [UIColor clearColor];
    rememberLab.font = [UIFont systemFontOfSize:11];
    [baseView addSubview:rememberLab];
    [rememberLab release];
    
    UIButton *autoLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    autoLogin.tag = 1001;
    autoLogin.frame = CGRectMake(190, 80, 20, 20);
    autoLogin.backgroundColor = [UIColor clearColor];
    [autoLogin setBackgroundImage:[UIImage imageNamed:@"home_login_uncheck"] forState:UIControlStateNormal];
    [autoLogin setBackgroundImage:[UIImage imageNamed:@"home_login_check"] forState:UIControlStateSelected];
    [autoLogin setImageEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    [autoLogin addTarget:self action:@selector(autoLogin:) forControlEvents:UIControlEventTouchUpInside];
    [baseView addSubview:autoLogin];
    
    rememberLab = [[UILabel alloc] initWithFrame:CGRectMake(215, 80, 82, 20)];
    rememberLab.text = @"自动登录";
    rememberLab.textColor = [UIColor blackColor];
    rememberLab.backgroundColor = [UIColor clearColor];
    rememberLab.font = [UIFont systemFontOfSize:11];
    [baseView addSubview:rememberLab];
    [rememberLab release];
    
    //    登录到服务器
    UIButton *login = [UIButton buttonWithType:UIButtonTypeCustom];
    login.frame = CGRectMake(30, 110, 260, 30);
    login.layer.cornerRadius = 4.0;
    login.layer.borderWidth = 1.0;
    login.layer.borderColor = [UIColor lightGrayColor].CGColor;
    login.backgroundColor = HEXCOLOR(0x76B8FF);
    [login setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [login setTitle:@"登录" forState:UIControlStateNormal];
    [login addTarget:self action:@selector(loginInServer:) forControlEvents:UIControlEventTouchUpInside];
    [baseView addSubview:login];
    
    [baseView release];

    //版权信息
    UILabel *copyRight = [[UILabel alloc] initWithFrame:CGRectMake(0, kScreenHeight - 50 - high/2, 320, 50)];
    copyRight.backgroundColor = [UIColor clearColor];
    copyRight.numberOfLines = 2;
    copyRight.textAlignment = NSTextAlignmentCenter;
    copyRight.textColor = [UIColor blackColor];
    copyRight.text = @"Copyright © 2008-2014 \n版权声明";
    copyRight.font = [UIFont systemFontOfSize:13.0f];
    [bgView addSubview:copyRight];
    [copyRight release];
    [bgView release];
    
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:kRemmemberPassword]);
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:kAutoLogin]);
    
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"j_username"]);
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"j_password"]);
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:kRemmemberPassword] isEqualToString:@"1"]) {
        name.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"j_username"];
        pwd.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"j_password"];
        [rememberPassBtn setSelected:YES];
    }
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:kAutoLogin] isEqualToString:@"1"]) {
        [autoLogin setSelected:YES];
        if (![DataCenter shareInstance].isQuite) {
            [self performSelector:@selector(loginInServer:) withObject:login afterDelay:1.0];
        }
    }
    
//    name.text = @"iphone";
//    pwd.text = @"1";
}

-(void) loginInServer:(id) sender
{
    if ([name.text length] == 0 || [pwd.text length] == 0) {
        alertMessage(@"用户名或者密码不能为空！");
        return ;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(loginInServce:withPassword:)]) {
        [self.delegate loginInServce:name.text withPassword:pwd.text];
    }
}

-(void) rememberPassword:(id) sender
{
    [sender setSelected:![sender isSelected]];
    if ([sender isSelected]) {
        
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:kRemmemberPassword];
    } else {
        [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:kRemmemberPassword];
    }
    
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:kRemmemberPassword]);
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:kAutoLogin]);
    
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"j_username"]);
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"j_password"]);
}

-(void) autoLogin:(id) sender
{
    [sender setSelected:![sender isSelected]];
    if ([sender isSelected]) {
        UIButton *button = (UIButton *)[self viewWithTag:1000];
        [button setSelected:YES];
    }
    
    if ([sender isSelected]) {
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:kAutoLogin];
    } else {
        [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:kAutoLogin];
    }
    
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:kRemmemberPassword]);
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:kAutoLogin]);
    
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"j_username"]);
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"j_password"]);
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (isIOS7) {
        [UIView animateWithDuration:0.5 animations:^{
            bgView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        }];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            CGFloat high = 0.0;
            if (!isIOS7) {
                if (kScreenHeight == 568) {
                    high = -20.0;
                } else {
                    high = -40.0;
                }
            }
            bgView.frame = CGRectMake(0, high, kScreenWidth, kScreenHeight);
        }];
    }

    [self endEditing:YES];
}

-(BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    if (bgView.frame.origin.y == 0) {
        [UIView animateWithDuration:0.5 animations:^{
            bgView.frame = CGRectMake(0, -40 - 140, kScreenWidth, kScreenHeight);
        }];
    }
    return YES;
}

@end
