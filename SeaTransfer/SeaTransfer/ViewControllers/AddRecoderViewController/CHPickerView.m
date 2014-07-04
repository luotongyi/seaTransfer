//
//  CHPickerView.m
//  DatePicker
//
//  Created by Cao JianRong on 14-4-17.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "CHPickerView.h"

@implementation CHPickerView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 246, 320, 246);
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        [self creatrInitView];
    }
    return self;
}

-(void) creatrInitView
{
    year = 0;
    mouth = 0;
    day = 0;
    yearArray = [[NSMutableArray alloc] init];
    mouthArray = [[NSMutableArray alloc] init];
    dayArray = [[NSMutableArray alloc] init];
    hourArray = [[NSMutableArray alloc] init];
    minArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<= 100; i++) {
        [yearArray addObject:[NSNumber numberWithInt:i+1980]];
    }
    
    for (int i = 1; i<= 12; i++) {
        [mouthArray addObject:[NSNumber numberWithInt:i]];
    }
    
    for (int i = 1; i<= 31; i++) {
        [dayArray addObject:[NSNumber numberWithInt:i]];
    }
    
    for (int i = 1; i<= 24; i++) {
        [hourArray addObject:[NSNumber numberWithInt:i]];
    }
    
    for (int i = 0; i<= 59; i++) {
        [minArray addObject:[NSNumber numberWithInt:i]];
    }
    
    NSDate *date = [NSDate date];
    // Get Current Year
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy"];
    year = [[formatter stringFromDate:date] intValue];
    [formatter setDateFormat:@"MM"];
    mouth = [[formatter stringFromDate:date] intValue];
    [formatter setDateFormat:@"dd"];
    day = [[formatter stringFromDate:date] intValue];
    [formatter setDateFormat:@"HH"];
    hour = [[formatter stringFromDate:date] intValue];
    [formatter setDateFormat:@"mm"];
    minute = [[formatter stringFromDate:date] intValue];
    [formatter release];
    

    UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 88, 320, 40)];
    maskView.backgroundColor = [UIColor colorWithRed:150.0/255.0 green:234.0/255.0 blue:224.0/255.0 alpha:0.3];
    maskView.userInteractionEnabled = NO;
    
    pickerDateView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 216, 320, 216)];
    
    pickerDateView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth; //这里设置了就可以自定义高度了，一般默认是无法修改其216像素的高度
    
    pickerDateView.dataSource = self;   //这个不用说了瑟
    
    pickerDateView.delegate = self;       //这个不用说了瑟
    
    pickerDateView.showsSelectionIndicator = YES;    //这个最好写 你不写来试下哇
    
    [self addSubview:pickerDateView];
    
    [pickerDateView addSubview:maskView];
    
    [maskView release];
    
    [pickerDateView release];
    
    [pickerDateView selectRow:(year - 1980) inComponent:0 animated:NO];
    [pickerDateView selectRow:mouth-1 inComponent:1 animated:NO];
    [pickerDateView selectRow:day-1 inComponent:2 animated:NO];
    [pickerDateView selectRow:hour-1 inComponent:3 animated:NO];
    [pickerDateView selectRow:minute-1 inComponent:4 animated:NO];
    
    UIBarButtonItem *cancle = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(configDate:)];
    [cancle setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:13],NSFontAttributeName,nil] forState:UIControlStateNormal];
    cancle.tag = 1000;
    
    UIBarButtonItem *fix = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *sure = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleBordered target:self action:@selector(configDate:)];
    [sure setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:13],NSFontAttributeName,nil] forState:UIControlStateNormal];
    sure.tag = 1001;
    NSArray *items = [NSArray arrayWithObjects:cancle,fix,sure, nil];
    [cancle release];
    [fix release];
    [sure release];
    
    UIToolbar *tool = [[UIToolbar alloc] initWithFrame:CGRectMake(-0.5, self.frame.size.height - 246, 322, 30)];
    tool.backgroundColor = [UIColor whiteColor];
    tool.layer.borderWidth = 0.5;
    tool.layer.borderColor = [UIColor blackColor].CGColor;
    [self addSubview:tool];
    [tool release];
    
    [tool setItems:items];
}

-(void) configDate:(id)sender
{
    if ([sender tag] - 1000) {
        NSLog(@"%d/%d/%d %.2f",year,mouth,day,self.frame.size.height);
        if (self.delegate && [self.delegate respondsToSelector:@selector(pickerViewString:)]) {
            [self.delegate pickerViewString:[NSString stringWithFormat:@"%d-%d-%d %d:%d",year,mouth,day,hour,minute]];
        }
    }
    [self setHidden:YES];
    
}

/****************************下面是数据源和代理的实现***********************************/
#pragma mark -

#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 5;   //这个picker里的组键数
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    //数组个数
    switch (component) {
        case 0:
            return [yearArray count];
            break;
        case 1:
            return [mouthArray count];
            break;
        default:
        {
            if (mouth == 2) {
                if ((year%4==0 && year%100!=0) || year%400==0) {
                    return 29;
                }
                return 28;
            } else if (mouth == 1 || mouth == 3
                       || mouth == 5 || mouth == 7
                       || mouth == 8 || mouth == 10 || mouth == 12){
                return [dayArray count];
            } else {
                return 30;
            }
        }
            break;
        case 3:
            return [hourArray count];
            break;
        case 4:
            return [minArray count];
            break;
            
    }
}

#pragma mark -

#pragma mark UIPickerViewDelegate

/************************重头戏来了************************/
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *myView = nil;
    
    if (component == 0) {
        
        myView = [[[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 30)] autorelease];
        
        myView.textAlignment = NSTextAlignmentCenter;
        
        myView.text = [NSString stringWithFormat:@"%d年",[[yearArray objectAtIndex:row] intValue]];
        
        myView.font = [UIFont systemFontOfSize:14];         //用label来设置字体大小
        
        myView.backgroundColor = [UIColor clearColor];
        
    } else if (component == 1) {
        
        myView = [[[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 60, 30)] autorelease];
        
        myView.text = [NSString stringWithFormat:@"%d月",[[mouthArray objectAtIndex:row] intValue]];
        
        myView.textAlignment = NSTextAlignmentCenter;
        
        myView.font = [UIFont systemFontOfSize:14];
        
        myView.backgroundColor = [UIColor clearColor];
        
    } else if (component == 2) {
        
        myView = [[[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 60, 30)] autorelease];
        
        myView.text = [NSString stringWithFormat:@"%d日",[[dayArray objectAtIndex:row] intValue]];
        
        myView.textAlignment = NSTextAlignmentCenter;
        
        myView.font = [UIFont systemFontOfSize:14];
        
        myView.backgroundColor = [UIColor clearColor];
        
    } else if (component == 3){
        
        myView = [[[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 60, 30)] autorelease];
        
        myView.text = [NSString stringWithFormat:@"%d时",[[hourArray objectAtIndex:row] intValue]];
        
        myView.textAlignment = NSTextAlignmentCenter;
        
        myView.font = [UIFont systemFontOfSize:14];
        
        myView.backgroundColor = [UIColor clearColor];
        
    } else if (component == 4){
        
        myView = [[[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 60, 30)] autorelease];
        
        myView.text = [NSString stringWithFormat:@"%d分",[[minArray objectAtIndex:row] intValue]];
        
        myView.textAlignment = NSTextAlignmentCenter;
        
        myView.font = [UIFont systemFontOfSize:14];
        
        myView.backgroundColor = [UIColor clearColor];
    }

    return myView;

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    UILabel *label = (UILabel *)[pickerDateView viewForRow:row forComponent:component];
    switch (component) {
        case 0:
            year = [[label.text stringByReplacingOccurrencesOfString:@"年" withString:@""] intValue];
            break;
        case 1:
            mouth = [[label.text stringByReplacingOccurrencesOfString:@"月" withString:@""] intValue];
            break;
        case 2:
            day = [[label.text stringByReplacingOccurrencesOfString:@"日" withString:@""] intValue];
            break;
        case 3:
            hour = [[label.text stringByReplacingOccurrencesOfString:@"时" withString:@""] intValue];
            break;
        case 4:
            minute = [[label.text stringByReplacingOccurrencesOfString:@"分" withString:@""] intValue];
            break;
        default:
            break;
    }
    [pickerView reloadComponent:2];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    CGFloat componentWidth = 0.0;
//    if (component == 0)
//        componentWidth = 80.0; // 第一个组键的宽度
////    else if (component == 1)
////        componentWidth = 60.0; // 第2个组键的宽度
//    else
        componentWidth = 60.0; // 第3个组键的宽度
    
    return componentWidth;
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40.0f;
}

@end
