//
//  CHPickerView.h
//  DatePicker
//
//  Created by Cao JianRong on 14-4-17.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CHPickerViewDelegate <NSObject>

-(void) pickerViewString:(NSString *) date;

@end

@interface CHPickerView : UIView <UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIPickerView *pickerDateView;
    NSMutableArray *yearArray;
    NSMutableArray *mouthArray;
    NSMutableArray *dayArray;
    NSMutableArray *hourArray;
    NSMutableArray *minArray;
    int year;
    int mouth;
    int day;
    int hour;
    int minute;
    UILabel *infoLabel;
    id<CHPickerViewDelegate> delegate;
}
@property (assign, nonatomic) id<CHPickerViewDelegate> delegate;
@end


