//
//  DetailViewController.h
//  SeaTransfer
//
//  Created by Cao JianRong on 14-4-28.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "CommonViewController.h"
#import "ImageControl.h"
#import "CHPickerView.h"

@interface DetailViewController : CommonViewController<CHPickerViewDelegate,UITextFieldDelegate>
{
    NSMutableDictionary *detailDic;
    UIScrollView *scroll;
    UITextField *bm;
    UITextField *salesman;
    UITextField *boatName;
    UITextField *boatNo;
    UITextField *goodsName;
    UITextField *reason;
    UITextField *timeStart;
    UITextField *timeEnd;
    UITextField *time;
    UITextField *start;
    UITextField *end;
    UITextField *planCount;
    UITextField *actualCount;
    UITextField *warehouseCapacity;
    UITextField *outworker;
    UITextField *remark;
    UIButton *pickImage;
    NSInteger currentTag;
    CHPickerView *pickerView;
}
@property (nonatomic, retain) NSMutableDictionary *detailDic;

@end
