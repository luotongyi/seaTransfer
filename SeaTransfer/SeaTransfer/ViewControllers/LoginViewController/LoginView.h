//
//  LoginView.h
//  SeaTransfer
//
//  Created by Cao JianRong on 14-4-28.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginViewDelegate <NSObject>

-(void) loginInServce:(NSString *) name withPassword:(NSString *) pwd;

@end

@interface LoginView : UIView <UITextFieldDelegate>
{
    UITextField *name;
    UITextField *pwd;
    UIImageView *bgView;
    id<LoginViewDelegate> delegate;
}
@property (nonatomic, assign) id<LoginViewDelegate> delegate;
@end
