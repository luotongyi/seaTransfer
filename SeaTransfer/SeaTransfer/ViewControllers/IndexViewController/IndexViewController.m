//
//  IndexViewController.m
//  SeaTransfer
//
//  Created by Cao JianRong on 14-4-28.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "IndexViewController.h"

@interface IndexViewController ()

@end

@implementation IndexViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = nil;
    
    //结束    左按钮。 显示用户登录名称——————————————————————————————————————
    UIImageView *topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 150)];
    [topView setImage:[UIImage imageNamed:@"large_logo"]];
    [self.view addSubview:topView];
    [topView release];
    
    float high = kScreenHeight - topView.frame.size.height - 64.0;
    
    UIButton *select = [UIButton buttonWithType:UIButtonTypeCustom];
    select.frame = CGRectMake(10,kScreenHeight - 59 - high , 135, 90);
    select.layer.cornerRadius = 5.0f;
    [select.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [select setImage:[UIImage imageNamed:@"search_large"] forState:UIControlStateNormal];
    [select addTarget:self action:@selector(searchInfomation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:select];
    
    UIButton *take = [UIButton buttonWithType:UIButtonTypeCustom];
    take.frame = CGRectMake( 10, kScreenHeight - high + 36, 135, 155);
    take.layer.cornerRadius = 5.0f;
    [take.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [take setImage:[UIImage imageNamed:@"takePic"] forState:UIControlStateNormal];
    [take addTarget:self action:@selector(takePhotos:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:take];
    
    UIButton *addResult = [UIButton buttonWithType:UIButtonTypeCustom];
    addResult.frame = CGRectMake(150, kScreenHeight - 59 - high, 160, 250);
    addResult.layer.cornerRadius = 5.0f;
    [addResult.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [addResult setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [addResult addTarget:self action:@selector(addRecorder:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addResult];
    
    /*UIBarButtonItem *rbutotn = [[UIBarButtonItem alloc] initWithTitle:@"查询动态" style:UIBarButtonItemStyleBordered target:self action:@selector(searchState:)];
    self.navigationItem.rightBarButtonItem = rbutotn;
    [rbutotn release];*/
}

-(void) viewDidAppear:(BOOL)animated
{
    if (![DataCenter shareInstance].isLogin) {
        LoginViewController *login = [[LoginViewController alloc] init];
        login.title = @"登录";
        [UIView  beginAnimations:nil context:NULL];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.75];
        [self presentViewController:login animated:YES completion:^{}];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.navigationController.view cache:NO];
        [UIView commitAnimations];
        [login release];
    }
    
    //开始    左按钮。 显示用户登录名称——————————————————————————————————————
    if ([DataCenter shareInstance].isLogin) {

        self.title = @"";
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 144, 44)];
        bgView.backgroundColor = [UIColor clearColor];
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(0, 11, 80, 20)];
        name.text = [DataCenter shareInstance].userName;
        name.backgroundColor = [UIColor clearColor];
        name.textColor = [UIColor whiteColor];
        [name setFont:[UIFont boldSystemFontOfSize:15.0]];
        [bgView addSubview:name];
        
        UIButton *loginOut = [UIButton buttonWithType:UIButtonTypeCustom];
        loginOut.frame = CGRectMake(100, 10, 64, 24);
        [loginOut.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
        [loginOut setBackgroundImage:[UIImage imageNamed:@"login_message_click"] forState:UIControlStateHighlighted];
        [loginOut setBackgroundImage:[UIImage imageNamed:@"login_message"] forState:UIControlStateNormal];
        [loginOut setTitle:@"退出登录" forState:UIControlStateNormal];
        [loginOut addTarget:self action:@selector(outLoginInServce:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:loginOut];
        [name release];
        
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:bgView];
        self.navigationItem.leftBarButtonItem = left;
        [bgView release];
        [left release];
    } else {
        self.title = @"首页";
    }
}

-(void) outLoginInServce:(id)sender
{
    NSLog(@"退出登录");
    [DataCenter shareInstance].isLogin = NO;
    [DataCenter shareInstance].isQuite = YES;
    [DataCenter shareInstance].userName = @"";
    [[DataCenter shareInstance].userInfo removeAllObjects];
    
    LoginViewController *login = [[LoginViewController alloc] init];
    login.title = @"登录";
    [UIView  beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.75];
    [self presentViewController:login animated:YES completion:^{}];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
    [login release];
    
}

/*-(void) searchState:(id) sender
{
    SearchStateViewController *search = [[SearchStateViewController alloc] init];
    search.title = @"查询动态";
    [self.navigationController pushViewController:search animated:YES];
    [search release];
}*/

-(void) searchInfomation:(id)sender
{
    ListViewController *list = [[ListViewController alloc] init];
    list.title = @"查询";
    [self.navigationController pushViewController:list animated:YES];
    [list release];
}

-(void) takePhotos:(id)sender
{
    SearchStateViewController *search = [[SearchStateViewController alloc] init];
    search.title = @"查询动态";
    [self.navigationController pushViewController:search animated:YES];
    [search release];
    
    /*TakeImageViewController *take = [[TakeImageViewController alloc] init];
    take.title = @"拍照";
    [self.navigationController pushViewController:take animated:YES];
    [take release];*/
}

-(void) addRecorder:(id)sender
{
    AddRecoderViewController *addController = [[AddRecoderViewController alloc] init];
    addController.title = @"添加装船记录";
    [self.navigationController pushViewController:addController animated:YES];
    [addController release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
