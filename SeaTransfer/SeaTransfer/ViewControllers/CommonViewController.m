//
//  CommonViewController.m
//  SeaTransfer
//
//  Created by Cao JianRong on 14-4-28.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "CommonViewController.h"

@interface CommonViewController ()

@end

@implementation CommonViewController

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
    
    //TODO:定制自己的风格的  左UIBarButtonItem
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(5, 5, 30, 30);
    [backButton setBackgroundImage:[UIImage imageNamed:@"navBar_back"] forState:UIControlStateNormal];
//    [backButton setBackgroundImage:[UIImage imageNamed:@"music_navigationbar_back"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:someBarButtonItem];
    [someBarButtonItem release];
    
    //TODO:定制自己的风格的  右UIBarButtonItem
    UIButton* rightButton= [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(5, 5, 30, 30);
    [rightButton setBackgroundImage:[UIImage imageNamed:@"navigationbar_profile_edit"] forState:UIControlStateNormal];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"navigationbar_profile_edit_highlighted"] forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:@selector(rightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    [self.navigationItem setRightBarButtonItem:rightBarButtonItem];
    [rightBarButtonItem release];
}

/*!
 *  设置导航栏右侧按钮图标
 *
 *  @param normal      正常状态下Image
 *  @param highlighted 点击状态下的Image
 */
-(void) setNaviRightButtonImage:(NSString *)normal withHighlighted:(NSString *)highlighted
{
    [self.navigationItem setRightBarButtonItem:nil];
    UIButton* rightButton= [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(5, 5, 30, 30);
    [rightButton setBackgroundImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [rightButton setBackgroundImage:[UIImage imageNamed:highlighted] forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:@selector(rightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    [self.navigationItem setRightBarButtonItem:rightBarButtonItem];
    [rightBarButtonItem release];
}

/*!
 *  返回按钮点击事件
 */
- (void)goBack {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

/*!
 *  右侧按钮点击时间
 *
 *  @param sender 右侧按钮
 */
-(void) rightButtonClicked:(id)sender
{
    NSLog(@"clicked rightButton");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
