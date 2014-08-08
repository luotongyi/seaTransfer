//
//  RegisterViewController.h
//  SeaTransfer
//
//  Created by luotongyi on 14-8-6.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>
{
    UIScrollView *baseScrollview;
    UITextField *tf1,*tf2,*tf3,*tf4,*tf5,*tf6;
}

@end
