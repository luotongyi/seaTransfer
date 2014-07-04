//
//  LoginViewController.h
//  SeaTransfer
//
//  Created by Cao JianRong on 14-4-28.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginView.h"

@interface LoginViewController : UIViewController<LoginViewDelegate>
{
    LoginView *loginView;
}
@end
