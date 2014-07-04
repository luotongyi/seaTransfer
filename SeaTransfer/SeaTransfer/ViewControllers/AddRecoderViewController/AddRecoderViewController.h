//
//  AddRecoderViewController.h
//  SeaTransfer
//
//  Created by Cao JianRong on 14-4-28.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "CommonViewController.h"
#import "CHPickerView.h"
#import "QBImagePickerController.h"
#import "MBProgressHUD.h"

@interface AddRecoderViewController : CommonViewController <UITextFieldDelegate,CHPickerViewDelegate,QBImagePickerControllerDelegate,MBProgressHUDDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIScrollView *scroll;
    UITextField *bm;
    UITextField *salesman;
    UITextField *boatName;
    UITextField *boatNo;
    UITextField *goodsName;
    UITextField *reason;
    UITextField *time;
    UITextField *timeStart;
    UITextField *timeEnd;
    UITextField *start;
    UITextField *end;
    UITextField *planCount;
    UITextField *actualCount;
    UITextField *warehouseCapacity;
    UITextField *outworker;
    UITextField *remark;
    UIScrollView *imgScroller,*emptyImgScroller,*loadImgScroller,*finishImgScroller;
    CHPickerView *pickerView;
    MBProgressHUD *HUD;
    NSMutableArray *iArray,*iArray1,*iArray2,*iArray3;
    NSInteger finishCount;
    NSInteger errorCount;
    NSMutableString *imgPath;
    NSInteger currentTag;
    BOOL isSuccess;
    
    NSMutableString *emptyImg;
    NSMutableString *loadImg;
    NSMutableString *finishImg;
    NSInteger selectTags;
    NSInteger allCount;
    
    UIImagePickerController *imagePicker;
    
    NSMutableArray *uploadArray;
    
    UILabel *label1,*label2,*label3,*label4;
    UIButton *btn1,*btn2,*btn3,*btn4;
}
@end
