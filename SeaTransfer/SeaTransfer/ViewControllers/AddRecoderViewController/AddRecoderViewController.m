//
//  AddRecoderViewController.m
//  SeaTransfer
//
//  Created by Cao JianRong on 14-4-28.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "AddRecoderViewController.h"

@implementation UIScrollView (cateTouch)

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
    [[self nextResponder] touchesBegan:touches withEvent:event];
}

@end

@interface AddRecoderViewController ()

@end

@implementation AddRecoderViewController

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([bm.text length] != 0 && !isSuccess) {
        
        AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@""]];
        
        client.parameterEncoding = AFFormURLParameterEncoding;
        
        [client setDefaultHeader:@"Accept" value:@"text/json"];
        
        NSString *string = [NSString stringWithFormat:@"http://114.215.103.53/wfplatform/handling_records!getHr.action?contractNo=%@",bm.text];
        
        [client getPath:string parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self checkBmData:responseObject];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"ERROR : %@",[error localizedDescription]);
        }];
        
        [client release];
    }
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) createInitView
{
    isSuccess = NO;
    
    scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, kScreenHeight - 64)];
    scroll.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scroll];
    [scroll release];
    
    UILabel *lInfo = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 50, 15)];
    [lInfo setFont:[UIFont systemFontOfSize:11.0]];
    lInfo.textColor = [UIColor blackColor];
    lInfo.textAlignment = NSTextAlignmentRight;
    lInfo.text = @"业务编号:";
    lInfo.backgroundColor = [UIColor clearColor];
    [scroll addSubview:lInfo];
    [lInfo release];
    
    bm = [[UITextField alloc] initWithFrame:CGRectMake(60, 15, 95, 25)];
    bm.font = [UIFont systemFontOfSize:11.0f];
    bm.layer.borderColor = HEXCOLOR(0xEBEBEB).CGColor;
    bm.layer.borderWidth = 1.0f;
    [scroll addSubview:bm];
    [bm release];
    
    
    UILabel *rInfo = [[UILabel alloc] initWithFrame:CGRectMake(160, 20, 50, 15)];
    [rInfo setFont:[UIFont systemFontOfSize:11.0]];
    rInfo.textColor = [UIColor blackColor];
    rInfo.textAlignment = NSTextAlignmentRight;
    rInfo.text = @"业  务  员:";
    rInfo.backgroundColor = [UIColor clearColor];
    [scroll addSubview:rInfo];
    [rInfo release];
    
    salesman = [[UITextField alloc] initWithFrame:CGRectMake(215, 15, 95, 25)];
    salesman.font = [UIFont systemFontOfSize:11.0f];
    salesman.layer.borderColor = HEXCOLOR(0xEBEBEB).CGColor;
    salesman.layer.borderWidth = 1.0f;
    [scroll addSubview:salesman];
    [salesman release];

    lInfo = [[UILabel alloc] initWithFrame:CGRectMake(10, lInfo.frame.size.height + lInfo.frame.origin.y + 10, 50, 15)];
    [lInfo setFont:[UIFont systemFontOfSize:11.0]];
    lInfo.textColor = [UIColor blackColor];
    lInfo.textAlignment = NSTextAlignmentRight;
    lInfo.text = @"船      名:";
    lInfo.backgroundColor = [UIColor clearColor];
    [scroll addSubview:lInfo];
    [lInfo release];
    
    boatName = [[UITextField alloc] initWithFrame:CGRectMake(lInfo.frame.origin.x + lInfo.frame.size.width, lInfo.frame.origin.y-2.5, 95, 20)];
    boatName.font = [UIFont systemFontOfSize:11.0f];
    boatName.layer.borderColor = HEXCOLOR(0xEBEBEB).CGColor;
    boatName.layer.borderWidth = 1.0f;
    [scroll addSubview:boatName];
    [boatName release];

    rInfo = [[UILabel alloc] initWithFrame:CGRectMake(160, rInfo.frame.size.height + rInfo.frame.origin.y + 10, 50, 15)];
    [rInfo setFont:[UIFont systemFontOfSize:11.0]];
    rInfo.textColor = [UIColor blackColor];
    rInfo.textAlignment = NSTextAlignmentRight;
    rInfo.text = @"航       次:";
    rInfo.backgroundColor = [UIColor clearColor];
    [scroll addSubview:rInfo];
    [rInfo release];
    
    boatNo = [[UITextField alloc] initWithFrame:CGRectMake(rInfo.frame.origin.x + rInfo.frame.size.width+5, lInfo.frame.origin.y-2.5, 95, 20)];
    boatNo.font = [UIFont systemFontOfSize:11.0f];
    boatNo.layer.borderColor = HEXCOLOR(0xEBEBEB).CGColor;
    boatNo.layer.borderWidth = 1.0f;
    [scroll addSubview:boatNo];
    [boatNo release];

    lInfo = [[UILabel alloc] initWithFrame:CGRectMake(10, lInfo.frame.size.height + lInfo.frame.origin.y + 10, 50, 15)];
    [lInfo setFont:[UIFont systemFontOfSize:11.0]];
    lInfo.textColor = [UIColor blackColor];
    lInfo.textAlignment = NSTextAlignmentRight;
    lInfo.text = @"货      名:";
    lInfo.backgroundColor = [UIColor clearColor];
    [scroll addSubview:lInfo];
    [lInfo release];
    
    goodsName = [[UITextField alloc] initWithFrame:CGRectMake(lInfo.frame.origin.x + lInfo.frame.size.width, lInfo.frame.origin.y-2.5, 95, 20)];
    goodsName.font = [UIFont systemFontOfSize:11.0f];
    goodsName.layer.borderColor = HEXCOLOR(0xEBEBEB).CGColor;
    goodsName.layer.borderWidth = 1.0f;
    [scroll addSubview:goodsName];
    [goodsName release];

    rInfo = [[UILabel alloc] initWithFrame:CGRectMake(160, rInfo.frame.size.height + rInfo.frame.origin.y + 10, 50, 15)];
    [rInfo setFont:[UIFont systemFontOfSize:11.0]];
    rInfo.textColor = [UIColor blackColor];
    rInfo.textAlignment = NSTextAlignmentRight;
    rInfo.text = @"积载因素:";
    rInfo.backgroundColor = [UIColor clearColor];
    [scroll addSubview:rInfo];
    [rInfo release];
    
    reason = [[UITextField alloc] initWithFrame:CGRectMake(rInfo.frame.origin.x + rInfo.frame.size.width+5, lInfo.frame.origin.y-2.5, 95, 20)];
    reason.font = [UIFont systemFontOfSize:11.0f];
    reason.layer.borderColor = HEXCOLOR(0xEBEBEB).CGColor;
    reason.layer.borderWidth = 1.0f;
    [scroll addSubview:reason];
    [reason release];
    
    lInfo = [[UILabel alloc] initWithFrame:CGRectMake(10, reason.frame.size.height + reason.frame.origin.y + 15, 50, 15)];
    [lInfo setFont:[UIFont systemFontOfSize:11.0]];
    lInfo.textColor = [UIColor blackColor];
    lInfo.textAlignment = NSTextAlignmentRight;
    lInfo.text = @"装      港:";
    lInfo.backgroundColor = [UIColor clearColor];
    [scroll addSubview:lInfo];
    [lInfo release];
    
    start = [[UITextField alloc] initWithFrame:CGRectMake(lInfo.frame.origin.x + lInfo.frame.size.width, reason.frame.size.height + reason.frame.origin.y + 13, 95, 20)];
    start.font = [UIFont systemFontOfSize:11.0f];
    start.layer.borderColor = HEXCOLOR(0xEBEBEB).CGColor;
    start.layer.borderWidth = 1.0f;
    [scroll addSubview:start];
    [start release];

    rInfo = [[UILabel alloc] initWithFrame:CGRectMake(160, reason.frame.size.height + reason.frame.origin.y + 15, 50, 15)];
    [rInfo setFont:[UIFont systemFontOfSize:11.0]];
    rInfo.textColor = [UIColor blackColor];
    rInfo.textAlignment = NSTextAlignmentRight;
    rInfo.text = @"卸      港:";
    rInfo.backgroundColor = [UIColor clearColor];
    [scroll addSubview:rInfo];
    [rInfo release];
    
    end = [[UITextField alloc] initWithFrame:CGRectMake(rInfo.frame.origin.x + rInfo.frame.size.width+5, lInfo.frame.origin.y-2.5, 95, 20)];
    end.font = [UIFont systemFontOfSize:11.0f];
    end.layer.borderColor = HEXCOLOR(0xEBEBEB).CGColor;
    end.layer.borderWidth = 1.0f;
    [scroll addSubview:end];
    [end release];
    
    lInfo = [[UILabel alloc] initWithFrame:CGRectMake(10, lInfo.frame.size.height + lInfo.frame.origin.y + 12, 50, 15)];
    [lInfo setFont:[UIFont systemFontOfSize:11.0]];
    lInfo.textColor = [UIColor blackColor];
    lInfo.textAlignment = NSTextAlignmentRight;
    lInfo.text = @"合同数量:";
    lInfo.backgroundColor = [UIColor clearColor];
    [scroll addSubview:lInfo];
    [lInfo release];
    
    planCount = [[UITextField alloc] initWithFrame:CGRectMake(lInfo.frame.origin.x + lInfo.frame.size.width, lInfo.frame.origin.y-2.5, 95, 20)];
    planCount.font = [UIFont systemFontOfSize:11.0f];
    planCount.keyboardType = UIKeyboardTypeNumberPad;
    planCount.layer.borderColor = HEXCOLOR(0xEBEBEB).CGColor;
    planCount.layer.borderWidth = 1.0f;
    [scroll addSubview:planCount];
    [planCount release];
    
    rInfo = [[UILabel alloc] initWithFrame:CGRectMake(160, rInfo.frame.size.height + rInfo.frame.origin.y + 10, 50, 15)];
    [rInfo setFont:[UIFont systemFontOfSize:11.0]];
    rInfo.textColor = [UIColor blackColor];
    rInfo.textAlignment = NSTextAlignmentRight;
    rInfo.text = @"实际数量:";
    rInfo.backgroundColor = [UIColor clearColor];
    [scroll addSubview:rInfo];
    [rInfo release];
    
    actualCount = [[UITextField alloc] initWithFrame:CGRectMake(rInfo.frame.origin.x + rInfo.frame.size.width+5, lInfo.frame.origin.y-2.5, 95, 20)];
    actualCount.font = [UIFont systemFontOfSize:11.0f];
    actualCount.keyboardType = UIKeyboardTypeNumberPad;
    actualCount.layer.borderColor = HEXCOLOR(0xEBEBEB).CGColor;
    actualCount.layer.borderWidth = 1.0f;
    [scroll addSubview:actualCount];
    [actualCount release];
    
    lInfo = [[UILabel alloc] initWithFrame:CGRectMake(10, lInfo.frame.size.height + lInfo.frame.origin.y + 10, 50, 15)];
    [lInfo setFont:[UIFont systemFontOfSize:11.0]];
    lInfo.textColor = [UIColor blackColor];
    lInfo.textAlignment = NSTextAlignmentRight;
    lInfo.text = @"剩余舱容:";
    lInfo.backgroundColor = [UIColor clearColor];
    [scroll addSubview:lInfo];
    [lInfo release];
    
    warehouseCapacity = [[UITextField alloc] initWithFrame:CGRectMake(lInfo.frame.origin.x + lInfo.frame.size.width, lInfo.frame.origin.y-2.5, 95, 20)];
    warehouseCapacity.font = [UIFont systemFontOfSize:11.0f];
    warehouseCapacity.keyboardType = UIKeyboardTypeNumberPad;
    warehouseCapacity.layer.borderColor = HEXCOLOR(0xEBEBEB).CGColor;
    warehouseCapacity.layer.borderWidth = 1.0f;
    [scroll addSubview:warehouseCapacity];
    [warehouseCapacity release];
    
    rInfo = [[UILabel alloc] initWithFrame:CGRectMake(160, rInfo.frame.size.height + rInfo.frame.origin.y + 10, 50, 15)];
    [rInfo setFont:[UIFont systemFontOfSize:11.0]];
    rInfo.textColor = [UIColor blackColor];
    rInfo.textAlignment = NSTextAlignmentRight;
    rInfo.text = @"外勤人员:";
    rInfo.backgroundColor = [UIColor clearColor];
    [scroll addSubview:rInfo];
    [rInfo release];
    
    outworker = [[UITextField alloc] initWithFrame:CGRectMake(rInfo.frame.origin.x + rInfo.frame.size.width+5, lInfo.frame.origin.y-2.5, 95, 20)];
    outworker.font = [UIFont systemFontOfSize:11.0f];
    outworker.layer.borderColor = HEXCOLOR(0xEBEBEB).CGColor;
    outworker.layer.borderWidth = 1.0f;
    [scroll addSubview:outworker];
    [outworker release];
    
    
    lInfo = [[UILabel alloc] initWithFrame:CGRectMake(10, lInfo.frame.size.height + lInfo.frame.origin.y + 10, 50, 15)];
    [lInfo setFont:[UIFont systemFontOfSize:11.0]];
    lInfo.textColor = [UIColor blackColor];
    lInfo.textAlignment = NSTextAlignmentRight;
    lInfo.text = @"开工时间:";
    lInfo.backgroundColor = [UIColor clearColor];
    [scroll addSubview:lInfo];
    [lInfo release];
    
    timeStart = [[UITextField alloc] initWithFrame:CGRectMake(lInfo.frame.origin.x + lInfo.frame.size.width, lInfo.frame.origin.y-2.5, 95, 20)];
    timeStart.font = [UIFont systemFontOfSize:11.0f];
    timeStart.layer.borderColor = HEXCOLOR(0xEBEBEB).CGColor;
    timeStart.layer.borderWidth = 1.0f;
    [scroll addSubview:timeStart];
    [timeStart release];
    
    rInfo = [[UILabel alloc] initWithFrame:CGRectMake(160, rInfo.frame.size.height + rInfo.frame.origin.y + 10, 50, 15)];
    [rInfo setFont:[UIFont systemFontOfSize:11.0]];
    rInfo.textColor = [UIColor blackColor];
    rInfo.textAlignment = NSTextAlignmentRight;
    rInfo.text = @"完货时间:";
    rInfo.backgroundColor = [UIColor clearColor];
    [scroll addSubview:rInfo];
    [rInfo release];
    
    timeEnd = [[UITextField alloc] initWithFrame:CGRectMake(rInfo.frame.origin.x + rInfo.frame.size.width+5, lInfo.frame.origin.y-2.5, 95, 20)];
    timeEnd.font = [UIFont systemFontOfSize:11.0f];
    timeEnd.layer.borderColor = HEXCOLOR(0xEBEBEB).CGColor;
    timeEnd.layer.borderWidth = 1.0f;
    [scroll addSubview:timeEnd];
    [timeEnd release];
    
    UILabel *timeInfo = [[UILabel alloc] initWithFrame:CGRectMake(10, lInfo.frame.size.height + lInfo.frame.origin.y + 20, 70, 30)];
    timeInfo.text = @"离港时间";
    timeInfo.textColor = [UIColor blackColor];
//    timeInfo.backgroundColor = HEXCOLOR(0xDDD8D9);
    [timeInfo setFont:[UIFont systemFontOfSize:11]];
    [scroll addSubview:timeInfo];
    [timeInfo release];
    
    time = [[UITextField alloc] initWithFrame:CGRectMake(62,lInfo.frame.size.height + lInfo.frame.origin.y + 20, 240, 30)];
    time.font = [UIFont systemFontOfSize:11];
    time.layer.borderColor = HEXCOLOR(0xEBEBEB).CGColor;
    time.layer.borderWidth = 1.0f;
//    time.backgroundColor = HEXCOLOR(0xDDD8D9);
    [scroll addSubview:time];
    [time release];

    
    
    UILabel *remarkInfo = [[UILabel alloc] initWithFrame:CGRectMake(10, timeInfo.frame.size.height + timeInfo.frame.origin.y + 20, 70, 30)];
    remarkInfo.textAlignment = NSTextAlignmentCenter;
    remarkInfo.text = @"备    注：";
    remarkInfo.textColor = HEXCOLOR(0x2F92A0);
    remarkInfo.backgroundColor = HEXCOLOR(0xDDD8D9);
    [remarkInfo setFont:[UIFont boldSystemFontOfSize:17.0]];
    [scroll addSubview:remarkInfo];
    [remarkInfo release];
    
    remark = [[UITextField alloc] initWithFrame:CGRectMake(82,timeInfo.frame.size.height + timeInfo.frame.origin.y + 20, 230, 30)];
    remark.font = [UIFont systemFontOfSize:11.0f];
    remark.layer.borderColor = HEXCOLOR(0xEBEBEB).CGColor;
    remark.layer.borderWidth = 1.0f;
    remark.backgroundColor = HEXCOLOR(0xDDD8D9);
    [scroll addSubview:remark];
    [remark release];
    
    //图片scrollview
    imgScroller = [[UIScrollView alloc] initWithFrame:CGRectMake(70, 310, 200, 60)];
    imgScroller.showsHorizontalScrollIndicator = NO;
    imgScroller.tag = 201400;
    [scroll addSubview:imgScroller];
    [imgScroller release];
    
    emptyImgScroller = [[UIScrollView alloc] initWithFrame:CGRectMake(70, 380, 200, 60)];
    emptyImgScroller.showsHorizontalScrollIndicator = NO;
    emptyImgScroller.tag = 201401;
    [scroll addSubview:emptyImgScroller];
    [emptyImgScroller release];
    
    loadImgScroller = [[UIScrollView alloc] initWithFrame:CGRectMake(70, 450, 200, 60)];
    loadImgScroller.showsHorizontalScrollIndicator = NO;
    loadImgScroller.tag = 201402;
    [scroll addSubview:loadImgScroller];
    [loadImgScroller release];
    
    finishImgScroller = [[UIScrollView alloc] initWithFrame:CGRectMake(70, 520, 200, 60)];
    finishImgScroller.showsHorizontalScrollIndicator = NO;
    finishImgScroller.tag = 201403;
    [scroll addSubview:finishImgScroller];
    [finishImgScroller release];
    
    btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(280, 310, 30, 60);
    [btn1 setBackgroundColor:[UIColor colorWithRed:110/255.0 green:194/255.0 blue:212/255.0 alpha:1]];
    [btn1 setTitle:@"+" forState:UIControlStateNormal];
    btn1.tag = 201400;
    btn1.layer.cornerRadius = 5;
    [btn1 addTarget:self action:@selector(pickMutileImage:) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:btn1];
    
    btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(280, 380, 30, 60);
    [btn2 setBackgroundColor:[UIColor colorWithRed:110/255.0 green:194/255.0 blue:212/255.0 alpha:1]];
    [btn2 setTitle:@"+" forState:UIControlStateNormal];
    btn2.tag = 201401;
    btn2.layer.cornerRadius = 5;
    [btn2 addTarget:self action:@selector(pickMutileImage:) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:btn2];
    
    btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(280, 450, 30, 60);
    [btn3 setBackgroundColor:[UIColor colorWithRed:110/255.0 green:194/255.0 blue:212/255.0 alpha:1]];
    [btn3 setTitle:@"+" forState:UIControlStateNormal];
    btn3.tag = 201402;
    btn3.layer.cornerRadius = 5;
    [btn3 addTarget:self action:@selector(pickMutileImage:) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:btn3];
    
    btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.frame = CGRectMake(280, 520, 30, 60);
    btn4.layer.cornerRadius = 5;
    [btn4 setBackgroundColor:[UIColor colorWithRed:110/255.0 green:194/255.0 blue:212/255.0 alpha:1]];
    [btn4 setTitle:@"+" forState:UIControlStateNormal];
    btn4.tag = 201403;
    [btn4 addTarget:self action:@selector(pickMutileImage:) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:btn4];
    
    /*
    label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 240, 60)];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = [UIColor darkGrayColor];
    label1.text = @"点击添加照片";
    
    label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 240, 60)];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.textColor = [UIColor darkGrayColor];
    label2.text = @"点击添加照片";
    
    label3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 240, 60)];
    label3.textAlignment = NSTextAlignmentCenter;
    label3.textColor = [UIColor darkGrayColor];
    label3.text = @"点击添加照片";
    
    label4 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 240, 60)];
    label4.textAlignment = NSTextAlignmentCenter;
    label4.textColor = [UIColor darkGrayColor];
    label4.text = @"点击添加照片";
    
    [imgScroller addSubview:label1];
    [emptyImgScroller addSubview:label2];
    [loadImgScroller addSubview:label3];
    [finishImgScroller addSubview:label4];
    */
    
    /*
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickMutileImage:)];
    tap1.cancelsTouchesInView = NO;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickMutileImage:)];
    tap2.cancelsTouchesInView = NO;
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickMutileImage:)];
    tap3.cancelsTouchesInView = NO;
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickMutileImage:)];
    tap4.cancelsTouchesInView = NO;
    [imgScroller addGestureRecognizer:tap1];
    [emptyImgScroller addGestureRecognizer:tap2];
    [loadImgScroller addGestureRecognizer:tap3];
    [finishImgScroller addGestureRecognizer:tap4];
    [tap1 release];
    [tap2 release];
    [tap3 release];
    [tap4 release];
    */
    
    //上传图片标题
    UILabel *lable1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 310, 50, 30)];
    lable1.text = @"船头照片";
    lable1.textColor = [UIColor darkGrayColor];
    lable1.font = [UIFont systemFontOfSize:12];
    [scroll addSubview:lable1];
    [lable1 release];
    
    UILabel *lable2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 380, 50, 30)];
    lable2.text = @"空船照片";
    lable2.textColor = [UIColor darkGrayColor];
    lable2.font = [UIFont systemFontOfSize:12];
    [scroll addSubview:lable2];
    [lable2 release];
    
    UILabel *lable3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 450, 50, 30)];
    lable3.text = @"装货照片";
    lable3.textColor = [UIColor darkGrayColor];
    lable3.font = [UIFont systemFontOfSize:12];
    [scroll addSubview:lable3];
    [lable3 release];
    
    UILabel *lable4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 520, 50, 30)];
    lable4.text = @"完货照片";
    lable4.textColor = [UIColor darkGrayColor];
    lable4.font = [UIFont systemFontOfSize:12];
    [scroll addSubview:lable4];
    [lable4 release];
    
    //上传图片button
    UIButton *pickImage = [UIButton buttonWithType:UIButtonTypeCustom];
    pickImage.frame = CGRectMake(10, 340, 50, 30);
    pickImage.layer.cornerRadius = 4.0;
    pickImage.tag = 5000;
    pickImage.titleLabel.font = [UIFont systemFontOfSize:14];
    pickImage.backgroundColor = HEXCOLOR(0x6EC3D3);;
    [pickImage setTitle:@"上传" forState:UIControlStateNormal];
    [pickImage addTarget:self action:@selector(upLoadImagesWithArray:) forControlEvents:UIControlEventTouchUpInside];
    [pickImage setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [scroll addSubview:pickImage];
    
    UIButton *pickImage1 = [UIButton buttonWithType:UIButtonTypeCustom];
    pickImage1.frame = CGRectMake(10, 410, 50, 30);
    pickImage1.layer.cornerRadius = 4.0;
    pickImage1.tag = 5001;
    pickImage1.titleLabel.font = [UIFont systemFontOfSize:14];
    pickImage1.backgroundColor = HEXCOLOR(0x6EC3D3);;
    [pickImage1 setTitle:@"上传" forState:UIControlStateNormal];
    [pickImage1 addTarget:self action:@selector(upLoadImagesWithArray:) forControlEvents:UIControlEventTouchUpInside];
    [pickImage1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [scroll addSubview:pickImage1];
    
    UIButton *pickImage2 = [UIButton buttonWithType:UIButtonTypeCustom];
    pickImage2.frame = CGRectMake(10, 480, 50, 30);
    pickImage2.layer.cornerRadius = 4.0;
    pickImage2.tag = 5002;
    pickImage2.titleLabel.font = [UIFont systemFontOfSize:14];
    pickImage2.backgroundColor = HEXCOLOR(0x6EC3D3);
    [pickImage2 setTitle:@"上传" forState:UIControlStateNormal];
    [pickImage2 addTarget:self action:@selector(upLoadImagesWithArray:) forControlEvents:UIControlEventTouchUpInside];
    [pickImage2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [scroll addSubview:pickImage2];
    
    UIButton *pickImage3 = [UIButton buttonWithType:UIButtonTypeCustom];
    pickImage3.frame = CGRectMake(10, 550, 50, 30);
    pickImage3.layer.cornerRadius = 4.0;
    pickImage3.tag = 5003;
    pickImage3.titleLabel.font = [UIFont systemFontOfSize:14];
    pickImage3.backgroundColor = HEXCOLOR(0x6EC3D3);;
    [pickImage3 setTitle:@"上传" forState:UIControlStateNormal];
    [pickImage3 addTarget:self action:@selector(upLoadImagesWithArray:) forControlEvents:UIControlEventTouchUpInside];
    [pickImage3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [scroll addSubview:pickImage3];
    
    
    UIButton *add = [UIButton buttonWithType:UIButtonTypeCustom];
    add.frame = CGRectMake(70, 590, 50, 30);
    [add setBackgroundImage:[UIImage imageNamed:@"login_message_click"] forState:UIControlStateHighlighted];
    [add setBackgroundImage:[UIImage imageNamed:@"login_message"] forState:UIControlStateNormal];
    [add.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [add setTitle:@"保存" forState:UIControlStateNormal];
    [add setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [add addTarget:self action:@selector(addRecoder:) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:add];
    
    UIButton *cancle = [UIButton buttonWithType:UIButtonTypeCustom];
    cancle.frame = CGRectMake(130, 590, 50, 30);
    [cancle setBackgroundImage:[UIImage imageNamed:@"login_message_click"] forState:UIControlStateHighlighted];
    [cancle setBackgroundImage:[UIImage imageNamed:@"login_message"] forState:UIControlStateNormal];
    [cancle.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [cancle setTitle:@"取消" forState:UIControlStateNormal];
    [cancle addTarget:self action:@selector(cancleOperation:) forControlEvents:UIControlEventTouchUpInside];
    [cancle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [scroll addSubview:cancle];
    
    UIButton *clear = [UIButton buttonWithType:UIButtonTypeCustom];
    clear.frame = CGRectMake(190, 590, 50, 30);
    [clear.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
    clear.backgroundColor = [UIColor clearColor];
    [clear setBackgroundImage:[UIImage imageNamed:@"login_message_click"] forState:UIControlStateHighlighted];
    [clear setBackgroundImage:[UIImage imageNamed:@"login_message"] forState:UIControlStateNormal];
    [clear addTarget:self action:@selector(clearTextField:) forControlEvents:UIControlEventTouchUpInside];
    [clear setTitle:@"清空" forState:UIControlStateNormal];
    [clear setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [scroll addSubview:clear];
    
    pickerView = [[CHPickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    pickerView.delegate = self;
    [self.view addSubview:pickerView];
    [pickerView release];
    [pickerView setHidden:YES];
    
    bm.tag = 2000;
    salesman.tag = 2001;
    boatName.tag = 2002;
    boatNo.tag = 2003;
    goodsName.tag = 2004;
    reason.tag = 2005;
    time.tag = 2006;
    start.tag = 2007;
    end.tag = 2008;
    planCount.tag = 2009;
    actualCount.tag = 2010;
    warehouseCapacity.tag = 2011;
    outworker.tag = 2012;
    remark.tag = 2013;
    timeStart.tag = 2014;
    timeEnd.tag = 2015;
    currentTag = 0;
    
    for (int i = 2000; i<2016; i++) {
        UITextField *field = (UITextField *)[self.view viewWithTag:i];
        field.delegate = self;
    }
    
    outworker.text = [DataCenter shareInstance].userName;
    
    [scroll setContentSize:CGSizeMake(320, 635)];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self createInitView];
    iArray = [[NSMutableArray alloc] init];
    iArray1 = [[NSMutableArray alloc] init];
    iArray2 = [[NSMutableArray alloc] init];
    iArray3 = [[NSMutableArray alloc] init];
    imgPath = [[NSMutableString alloc] init];
    emptyImg = [[NSMutableString alloc] init];
    loadImg = [[NSMutableString alloc] init];
    finishImg = [[NSMutableString alloc] init];
    finishCount = 0;
    errorCount = 0;
    allCount = 0;
    
}

-(void) addRecoder:(id) sender
{
    if (isSending) {
        return;
    }
    
    isSending = YES;
    
    for (int i = 2000; i<2016; i++) {
        UITextField *field = (UITextField *)[self.view viewWithTag:i];
        if ([field.text length] == 0 && field.tag != 2006) {
            alertMessage(@"请检查输入信息的完整性。");
            return ;
        }
    }
    
    NSMutableDictionary *dics = [NSMutableDictionary dictionary];
    [dics setObject:bm.text forKey:@"handlingRecords.contractNo"];
    [dics setObject:salesman.text forKey:@"handlingRecords.handleUser"];
    [dics setObject:boatName.text forKey:@"handlingRecords.shipName"];
    [dics setObject:boatNo.text forKey:@"handlingRecords.shipVoyage"];
    [dics setObject:@"" forKey:@"handlingRecords.shipVoyageId"];
    [dics setObject:goodsName.text forKey:@"handlingRecords.cargoName"];
    [dics setObject:reason.text forKey:@"handlingRecords.cargoLoadReason"];
    [dics setObject:time.text forKey:@"handlingRecords.finishedDate"];
    [dics setObject:start.text forKey:@"handlingRecords.loadPort"];
    [dics setObject:end.text forKey:@"handlingRecords.dischargePort"];
    [dics setObject:planCount.text forKey:@"handlingRecords.cargoNum"];
    [dics setObject:actualCount.text forKey:@"handlingRecords.realNum"];
    [dics setObject:warehouseCapacity.text forKey:@"handlingRecords.releaseNum"];
    [dics setObject:outworker.text forKey:@"handlingRecords.recordUserId"];
    [dics setObject:remark.text forKey:@"handlingRecords.remark"];
    [dics setObject:timeStart.text forKey:@"handlingRecords.workBeg"];
    [dics setObject:timeEnd.text forKey:@"handlingRecords.workEnd"];
    
    if ([imgPath length]>0) {
        [dics setObject:imgPath forKey:@"handlingRecords.img"];
    }
    
    if ([emptyImg length]>0) {
        [dics setObject:emptyImg forKey:@"handlingRecords.emptyImg"];
    }
    
    if ([loadImg length]>0) {
        [dics setObject:loadImg forKey:@"handlingRecords.loadImg"];
    }
    
    if ([finishImg length]>0) {
        [dics setObject:finishImg forKey:@"handlingRecords.finishImg"];
    }
    
    NSString *pathStr=@"http://114.215.103.53/wfplatform/handling_records!save.action";

    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@""]];

    httpClient.parameterEncoding = AFFormURLParameterEncoding;

    [httpClient setDefaultHeader:@"Accept" value:@"text/json"];

    NSMutableDictionary *params=[[NSMutableDictionary alloc] initWithDictionary:dics];

    [httpClient postPath:pathStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        isSending = NO;
        [self checkData:responseObject];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        NSLog(@"[HTTPClient Error]: %@", error);
        isSending = NO;
        alertMessage(@"添加装卸记录失败，请检查网络链接.");
    }];
    
    [params release];
    
    [httpClient release];
    
}

-(void) checkData:(NSData *)data
{
    NSError *error = nil;
    
    NSDictionary *info = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error || !info) {
        alertMessage(@"添加装卸记录失败，请重新添加");
        return ;
    }
    
    NSLog(@"Request Successful, response:\n %@", info);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[info objectForKey:@"title"] message:[info objectForKey:@"detail"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) cancleOperation:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) pickMutileImage:(UIButton *)sender
{
//    UIScrollView *v = (UIScrollView *)sender.view;
    switch (sender.tag) {
        case 201400:
        {
            selectTags = 5000;
        }
            break;
        case 201401:
        {
            selectTags = 5001;
        }
            break;
        case 201402:
        {
            selectTags = 5002;
        }
            break;
        case 201403:
        {
            selectTags = 5003;
        }
            break;
        default:
            break;
    }
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册", nil];
    [sheet showInView:self.view];
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        //指定源类型前，检查图片源是否可用
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            imagePicker = [[UIImagePickerController alloc]init];
            imagePicker.delegate = self;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            //设置完iamgePicker后，就可以启动了。用以下方法将图像选取器的视图“推”出来
            if (isIOS7) {
                NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:20.0f],NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName,nil];
                imagePicker.navigationBar.titleTextAttributes = dict;
                imagePicker.navigationBar.tintColor = [UIColor whiteColor];
            }
            [self presentViewController:imagePicker animated:YES completion:nil];
            [imagePicker release];
        }
        else
        {
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:nil message:@"相机不能用" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        
    }
    else if (buttonIndex == 1)
    {
        QBImagePickerController *imagePickerController = [[QBImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsMultipleSelection = YES;
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
        navigationController.navigationBar.tintColor = [UIColor whiteColor];
        if (isIOS7) {
            navigationController.navigationBar.barTintColor = HEXCOLOR(0x176B8FF);
        } else {
            navigationController.navigationBar.tintColor = HEXCOLOR(0x176B8FF);
        }
        navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
        [self presentViewController:navigationController animated:YES completion:NULL];
        [imagePickerController release];
        [navigationController release];
    }
    else
    {
        
    }
}

/**
 *  多选照片的代理方法。在这里进行选择，上传等一系列操作
 */
#pragma mark - QBImagePickerControllerDelegate

- (void)imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingMediaWithInfo:(id)info
{
    //拍照
    if ([imagePickerController isKindOfClass:[UIImagePickerController class]])
    {
        NSLog(@"*************");
        
        NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
        UIImage *originImage = nil;
        if ([mediaType isEqualToString:@"public.image"])
        {
            UIImage *scaleImage = [info objectForKey:UIImagePickerControllerOriginalImage];
            originImage = [Utils scaleImage:scaleImage toScale:0.5];
            
        }
        [self dismissViewControllerAnimated:YES completion:^{
            
            switch (selectTags) {
                case 5000:
                {
                    [iArray addObject:originImage];
                    if (iArray.count > 0) {
                        label1.hidden = YES;
                    }
                    else
                    {
                        label1.hidden = NO;
                    }
                    for (UIView *v in [imgScroller subviews])
                    {
                        if ([v isKindOfClass:[UIImageView class]]) {
                            [v removeFromSuperview];
                        }
                    }
                    for (int i=0; i<iArray.count; i++)
                    {
                        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(5+55*i, 5, 50, 50)];
                        [img setImage:[iArray objectAtIndex:i]];
                        [imgScroller addSubview:img];
                        [imgScroller setContentSize:CGSizeMake(5+55*iArray.count+5, 60)];
                        
                        img.userInteractionEnabled = YES;
                        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(30, 0, 20, 20)];
                        btn.tag = i;
                        [btn setBackgroundImage:[UIImage imageNamed:@"close_btn"] forState:UIControlStateNormal];
                        [btn addTarget:self action:@selector(closeBtnClick1:) forControlEvents:UIControlEventTouchUpInside];
                        [img addSubview:btn];
                    }
                }
                    break;
                case 5001:
                {
                    [iArray1 addObject:originImage];
                    if (iArray1.count > 0) {
                        label2.hidden = YES;
                    }
                    else
                    {
                        label2.hidden = NO;
                    }
                    for (UIView *v in [emptyImgScroller subviews])
                    {
                        if ([v isKindOfClass:[UIImageView class]]) {
                            [v removeFromSuperview];
                        }
                    }
                    for (int i=0; i<iArray1.count; i++)
                    {
                        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(5+55*i, 5, 50, 50)];
                        [img setImage:[iArray1 objectAtIndex:i]];
                        [emptyImgScroller addSubview:img];
                        [emptyImgScroller setContentSize:CGSizeMake(5+55*iArray1.count+5, 60)];
                        
                        img.userInteractionEnabled = YES;
                        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(30, 0, 20, 20)];
                        btn.tag = i;
                        [btn setBackgroundImage:[UIImage imageNamed:@"close_btn"] forState:UIControlStateNormal];
                        [btn addTarget:self action:@selector(closeBtnClick2:) forControlEvents:UIControlEventTouchUpInside];
                        [img addSubview:btn];
                    }
                }
                    break;
                case 5002:
                {
                    [iArray2 addObject:originImage];
                    if (iArray2.count > 0) {
                        label3.hidden = YES;
                    }
                    else
                    {
                        label3.hidden = NO;
                    }
                    for (UIView *v in [loadImgScroller subviews])
                    {
                        if ([v isKindOfClass:[UIImageView class]]) {
                            [v removeFromSuperview];
                        }
                    }
                    for (int i=0; i<iArray2.count; i++)
                    {
                        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(5+55*i, 5, 50, 50)];
                        [img setImage:[iArray2 objectAtIndex:i]];
                        [loadImgScroller addSubview:img];
                        [loadImgScroller setContentSize:CGSizeMake(5+55*iArray2.count+5, 60)];
                        
                        img.userInteractionEnabled = YES;
                        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(30, 0, 20, 20)];
                        btn.tag = i;
                        [btn setBackgroundImage:[UIImage imageNamed:@"close_btn"] forState:UIControlStateNormal];
                        [btn addTarget:self action:@selector(closeBtnClick3:) forControlEvents:UIControlEventTouchUpInside];
                        [img addSubview:btn];
                    }
                }
                    break;
                case 5003:
                {
                    [iArray3 addObject:originImage];
                    if (iArray3.count > 0) {
                        label4.hidden = YES;
                    }
                    else
                    {
                        label4.hidden = NO;
                    }
                    for (UIView *v in [finishImgScroller subviews])
                    {
                        if ([v isKindOfClass:[UIImageView class]]) {
                            [v removeFromSuperview];
                        }
                    }
                    for (int i=0; i<iArray3.count; i++)
                    {
                        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(5+55*i, 5, 50, 50)];
                        [img setImage:[iArray3 objectAtIndex:i]];
                        [finishImgScroller addSubview:img];
                        [finishImgScroller setContentSize:CGSizeMake(5+55*iArray3.count+5, 60)];
                        
                        img.userInteractionEnabled = YES;
                        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(30, 0, 20, 20)];
                        btn.tag = i;
                        [btn setBackgroundImage:[UIImage imageNamed:@"close_btn"] forState:UIControlStateNormal];
                        [btn addTarget:self action:@selector(closeBtnClick4:) forControlEvents:UIControlEventTouchUpInside];
                        [img addSubview:btn];
                    }
                }
                    break;
                default:
                    break;
            }
            
        }];
    }
    else//选择照片
    {
        if(imagePickerController.allowsMultipleSelection) {
            NSArray *mediaInfoArray = (NSArray *)info;
            [self dismissViewControllerAnimated:YES completion:^{
                
                switch (selectTags) {
                    case 5000:
                        //[iArray removeAllObjects];
                        for (UIView *v in [imgScroller subviews])
                        {
                            if ([v isKindOfClass:[UIImageView class]]) {
                                [v removeFromSuperview];
                            }
                        }
                        @autoreleasepool {
                            for (ALAsset *asset in mediaInfoArray) {
                                if ([asset valueForProperty:ALAssetPropertyType] == ALAssetTypePhoto) {
                                    
                                    UIImage *scaleImage = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
                                    UIImage *originImage = [Utils scaleImage:scaleImage toScale:0.5];
                                    [iArray addObject:originImage];
                                }
                            }
                            if (iArray.count > 0)
                            {
                                label1.hidden = YES;
                                for (int i=0; i<iArray.count; i++)
                                {
                                    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(5+55*i, 5, 50, 50)];
                                    [img setImage:[iArray objectAtIndex:i]];
                                    [imgScroller addSubview:img];
                                    [imgScroller setContentSize:CGSizeMake(5+55*iArray.count+5, 60)];
                                    
                                    img.userInteractionEnabled = YES;
                                    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(30, 0, 20, 20)];
                                    btn.tag = i;
                                    [btn setBackgroundImage:[UIImage imageNamed:@"close_btn"] forState:UIControlStateNormal];
                                    [btn addTarget:self action:@selector(closeBtnClick1:) forControlEvents:UIControlEventTouchUpInside];
                                    [img addSubview:btn];
                                }
                                label1.hidden = YES;
                            }
                            else
                            {
                                label1.hidden = NO;
                            }
                        }
                        break;
                    case 5001:
                        //[iArray1 removeAllObjects];
                        for (UIView *v in [emptyImgScroller subviews])
                        {
                            if ([v isKindOfClass:[UIImageView class]]) {
                                [v removeFromSuperview];
                            }
                        }
                        @autoreleasepool {
                            for (ALAsset *asset in mediaInfoArray) {
                                if ([asset valueForProperty:ALAssetPropertyType] == ALAssetTypePhoto) {
                                    
                                    UIImage *scaleImage = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
                                    UIImage *originImage = [Utils scaleImage:scaleImage toScale:0.5];
                                    [iArray1 addObject:originImage];
                                }
                            }
                            if (iArray1.count > 0)
                            {
                                for (int i=0; i<iArray1.count; i++)
                                {
                                    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(5+55*i, 5, 50, 50)];
                                    [img setImage:[iArray1 objectAtIndex:i]];
                                    [emptyImgScroller addSubview:img];
                                    [emptyImgScroller setContentSize:CGSizeMake(5+55*iArray1.count+5, 60)];
                                    
                                    img.userInteractionEnabled = YES;
                                    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(30, 0, 20, 20)];
                                    btn.tag = i;
                                    [btn setBackgroundImage:[UIImage imageNamed:@"close_btn"] forState:UIControlStateNormal];
                                    [btn addTarget:self action:@selector(closeBtnClick2:) forControlEvents:UIControlEventTouchUpInside];
                                    [img addSubview:btn];
                                }
                                label2.hidden = YES;
                            }
                            else
                            {
                                label2.hidden = NO;
                            }
                        }
                        break;
                    case 5002:
                        //[iArray2 removeAllObjects];
                        for (UIView *v in [loadImgScroller subviews])
                        {
                            if ([v isKindOfClass:[UIImageView class]]) {
                                [v removeFromSuperview];
                            }
                        }
                        @autoreleasepool {
                            for (ALAsset *asset in mediaInfoArray) {
                                if ([asset valueForProperty:ALAssetPropertyType] == ALAssetTypePhoto) {
                                    
                                    UIImage *scaleImage = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
                                    UIImage *originImage = [Utils scaleImage:scaleImage toScale:0.5];
                                    [iArray2 addObject:originImage];
                                }
                            }
                            if (iArray2.count > 0)
                            {
                                for (int i=0; i<iArray2.count; i++)
                                {
                                    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(5+55*i, 5, 50, 50)];
                                    [img setImage:[iArray2 objectAtIndex:i]];
                                    [loadImgScroller addSubview:img];
                                    [loadImgScroller setContentSize:CGSizeMake(5+55*iArray2.count+5, 60)];
                                    
                                    img.userInteractionEnabled = YES;
                                    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(30, 0, 20, 20)];
                                    btn.tag = i;
                                    [btn setBackgroundImage:[UIImage imageNamed:@"close_btn"] forState:UIControlStateNormal];
                                    [btn addTarget:self action:@selector(closeBtnClick3:) forControlEvents:UIControlEventTouchUpInside];
                                    [img addSubview:btn];
                                }
                                label3.hidden = YES;
                            }
                            else
                            {
                                label3.hidden = NO;
                            }
                        }
                        break;
                    case 5003:
                        //[iArray3 removeAllObjects];
                        for (UIView *v in [finishImgScroller subviews])
                        {
                            if ([v isKindOfClass:[UIImageView class]]) {
                                [v removeFromSuperview];
                            }
                        }
                        @autoreleasepool {
                            for (ALAsset *asset in mediaInfoArray) {
                                if ([asset valueForProperty:ALAssetPropertyType] == ALAssetTypePhoto) {
                                    
                                    UIImage *scaleImage = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
                                    UIImage *originImage = [Utils scaleImage:scaleImage toScale:0.5];
                                    [iArray3 addObject:originImage];
                                }
                            }
                            if (iArray3.count > 0)
                            {
                                for (int i=0; i<iArray3.count; i++)
                                {
                                    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(5+55*i, 5, 50, 50)];
                                    [img setImage:[iArray3 objectAtIndex:i]];
                                    [finishImgScroller addSubview:img];
                                    [finishImgScroller setContentSize:CGSizeMake(5+55*iArray3.count+5, 60)];
                                    
                                    img.userInteractionEnabled = YES;
                                    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(30, 0, 20, 20)];
                                    btn.tag = i;
                                    [btn setBackgroundImage:[UIImage imageNamed:@"close_btn"] forState:UIControlStateNormal];
                                    [btn addTarget:self action:@selector(closeBtnClick4:) forControlEvents:UIControlEventTouchUpInside];
                                    [img addSubview:btn];
                                }
                                label4.hidden = YES;
                            }
                            else
                            {
                                label4.hidden = NO;
                            }
                        }
                        break;
                    default:
                        break;
                }
                
                /*for (int i=0; i<mediaInfoArray.count; i++)
                {
                    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(5+55*i, 5, 50, 50)];
                    
                    switch (selectTags) {
                        case 5000:
                        {
                            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(5+55*i, 5, 50, 50)];
                            [img setImage:[iArray objectAtIndex:i]];
                            [imgScroller addSubview:img];
                            [imgScroller setContentSize:CGSizeMake(5+55*mediaInfoArray.count+5, 60)];
                        }
                            break;
                        case 5001:
                        {
                            
                            [img setImage:[iArray1 objectAtIndex:i]];
                            [emptyImgScroller addSubview:img];
                            [emptyImgScroller setContentSize:CGSizeMake(5+55*mediaInfoArray.count+5, 60)];
                        }
                            break;
                        case 5002:
                        {
                            
                            [img setImage:[iArray2 objectAtIndex:i]];
                            [loadImgScroller addSubview:img];
                            [loadImgScroller setContentSize:CGSizeMake(5+55*mediaInfoArray.count+5, 60)];
                        }
                            break;
                        case 5003:
                        {
                            
                            [img setImage:[iArray3 objectAtIndex:i]];
                            [finishImgScroller addSubview:img];
                            [finishImgScroller setContentSize:CGSizeMake(5+55*mediaInfoArray.count+5, 60)];
                        }
                            break;
                        default:
                            break;
                    }
                    
                    [img release];
                }*/
            }];
        } else {
            NSDictionary *mediaInfo = (NSDictionary *)info;
            NSLog(@"Selected: %@", mediaInfo);
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
    }
    
}

- (void)closeBtnClick1:(UIButton *)sender
{
    NSLog(@"hello world 1");
    for (UIView *v in [imgScroller subviews])
    {
        if ([v isKindOfClass:[UIImageView class]]) {
            [v removeFromSuperview];
        }
    }
    if (iArray.count <= 0) {
        return;
    }
    [iArray removeObjectAtIndex:sender.tag];
    if (iArray.count > 0)
    {
        label1.hidden = YES;
        for (int i=0; i<iArray.count; i++)
        {
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(5+55*i, 5, 50, 50)];
            [img setImage:[iArray objectAtIndex:i]];
            [imgScroller addSubview:img];
            [imgScroller setContentSize:CGSizeMake(5+55*iArray.count+5, 60)];
            
            img.userInteractionEnabled = YES;
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(30, 0, 20, 20)];
            btn.tag = i;
            [btn setBackgroundImage:[UIImage imageNamed:@"close_btn"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(closeBtnClick1:) forControlEvents:UIControlEventTouchUpInside];
            [img addSubview:btn];
        }
    }
    else
    {
        label1.hidden = NO;
    }
}

- (void)closeBtnClick2:(UIButton *)sender
{
    NSLog(@"hello world 2");
    for (UIView *v in [emptyImgScroller subviews])
    {
        if ([v isKindOfClass:[UIImageView class]]) {
            [v removeFromSuperview];
        }
    }
    if (iArray1.count <= 0) {
        return;
    }
    [iArray1 removeObjectAtIndex:sender.tag];
    if (iArray1.count > 0)
    {
        label2.hidden = YES;
        for (int i=0; i<iArray1.count; i++)
        {
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(5+55*i, 5, 50, 50)];
            [img setImage:[iArray1 objectAtIndex:i]];
            [emptyImgScroller addSubview:img];
            [emptyImgScroller setContentSize:CGSizeMake(5+55*iArray1.count+5, 60)];
            
            img.userInteractionEnabled = YES;
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(30, 0, 20, 20)];
            btn.tag = i;
            [btn setBackgroundImage:[UIImage imageNamed:@"close_btn"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(closeBtnClick2:) forControlEvents:UIControlEventTouchUpInside];
            [img addSubview:btn];
        }
    }
    else
    {
        label2.hidden = NO;
    }
}

- (void)closeBtnClick3:(UIButton *)sender
{
    NSLog(@"hello world 3");
    for (UIView *v in [loadImgScroller subviews])
    {
        if ([v isKindOfClass:[UIImageView class]]) {
            [v removeFromSuperview];
        }
    }
    if (iArray2.count <= 0) {
        return;
    }
    [iArray2 removeObjectAtIndex:sender.tag];
    if (iArray2.count > 0)
    {
        label3.hidden = YES;
        for (int i=0; i<iArray2.count; i++)
        {
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(5+55*i, 5, 50, 50)];
            [img setImage:[iArray2 objectAtIndex:i]];
            [loadImgScroller addSubview:img];
            [loadImgScroller setContentSize:CGSizeMake(5+55*iArray2.count+5, 60)];
            
            img.userInteractionEnabled = YES;
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(30, 0, 20, 20)];
            btn.tag = i;
            [btn setBackgroundImage:[UIImage imageNamed:@"close_btn"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(closeBtnClick3:) forControlEvents:UIControlEventTouchUpInside];
            [img addSubview:btn];
        }
    }
    else
    {
        label3.hidden = NO;
    }
}

- (void)closeBtnClick4:(UIButton *)sender
{
    NSLog(@"hello world 4");
    for (UIView *v in [finishImgScroller subviews])
    {
        if ([v isKindOfClass:[UIImageView class]]) {
            [v removeFromSuperview];
        }
    }
    if (iArray3.count <= 0) {
        return;
    }
    [iArray3 removeObjectAtIndex:sender.tag];
    if (iArray3.count > 0)
    {
        label4.hidden = YES;
        for (int i=0; i<iArray3.count; i++)
        {
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(5+55*i, 5, 50, 50)];
            [img setImage:[iArray3 objectAtIndex:i]];
            [finishImgScroller addSubview:img];
            [finishImgScroller setContentSize:CGSizeMake(5+55*iArray3.count+5, 60)];
            
            img.userInteractionEnabled = YES;
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(30, 0, 20, 20)];
            btn.tag = i;
            [btn setBackgroundImage:[UIImage imageNamed:@"close_btn"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(closeBtnClick4:) forControlEvents:UIControlEventTouchUpInside];
            [img addSubview:btn];
        }
    }
    else
    {
        label4.hidden = NO;
    }
}

-(void) uploadImageWithArray
{
    errorCount = 0;
    finishCount = 0;

    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:HUD];
    // Set determinate mode
    HUD.mode = MBProgressHUDModeAnnularDeterminate;
    HUD.delegate = self;
    HUD.labelText = @"图片上传中...";
    [HUD show:YES];
    UIActivityIndicatorView *actView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    actView.frame = CGRectMake(150, (kScreenHeight - 20)/2-11, 20, 20);
    [actView startAnimating];
    [HUD addSubview:actView];
    [actView release];
    
    [self upLoadImageWithSort];
}

- (void)upLoadImagesWithArray:(UIButton *)btn
{
    upImageBtnTag = btn.tag;
    switch (btn.tag) {
        case 5000://iArray
        {
            uploadArray = iArray;
            [self uploadImageWithArray];
            NSLog(@"1111111");
        }
            break;
        case 5001://iArray1
        {
            uploadArray = iArray1;
            [self uploadImageWithArray];
            NSLog(@"22222222");
        }
            break;
        case 5002://iArray2
        {
            uploadArray = iArray2;
            [self uploadImageWithArray];
            NSLog(@"33333333");
        }
            break;
        case 5003://iArray3
        {
            uploadArray = iArray3;
            [self uploadImageWithArray];
            NSLog(@"44444444");
        }
            break;
        default:
            break;
    }
}

-(void) upLoadImageWithSort
{
    if ([uploadArray count] == 0 || finishCount >= [uploadArray count]) {
        [HUD hide:YES];
        finishCount = 0;
        [uploadArray removeAllObjects];
        return ;
    }
    
    NSURL *url = [NSURL URLWithString:@""];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    NSData *imageData = UIImageJPEGRepresentation([uploadArray objectAtIndex:finishCount], 0.5);
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];

    [params setValue:[NSString stringWithFormat:@"%@ZX",bm.text] forKey:@"contractNo"];
    NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"POST" path:@"http://114.215.103.53/wfplatform/upload2.action" parameters:params constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置时间格式
        int i = arc4random() % 100;
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%d%@.jpg", i, str];
        [formData appendPartWithFileData:imageData name:@"filedata" fileName:fileName mimeType:@"image/jpeg"];
    }];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];

    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self reloadWaterView:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"ERROR: %@",[error localizedDescription]);
        [self uploadFail:error];
    }];
    [operation start];
    
}


-(void) reloadWaterView:(NSData *)respBody
{
    finishCount ++;
    HUD.progress = ((float)finishCount)/uploadArray.count;
    
    NSLog(@"%@",[[NSString alloc] initWithData:respBody encoding:NSUTF8StringEncoding])
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:respBody options:NSJSONReadingMutableContainers error:&error];
    
    if (error || [dic objectForKey:@"title"]) {
        [self upLoadImageWithSort];
        errorCount ++;
        if (finishCount == [uploadArray count] && errorCount > 0) {
//            alertMessage(@"有图片上传失败。");
        }
        return ;
    }
    allCount++;
    switch (upImageBtnTag) {
        case 5000:
        {
//            [iArray removeAllObjects];
            for (int i =finishCount-1; i<finishCount; i++)
            {
                UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(5+55*i, 5, 50, 50)];
                img.backgroundColor = [UIColor blackColor];
                img.userInteractionEnabled = YES;
                img.alpha = 0.5;
                [imgScroller addSubview:img];
            }
        }
            break;
        case 5001:
        {
//            [iArray1 removeAllObjects];
            for (int i =finishCount-1; i<finishCount; i++)
            {
                UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(5+55*i, 5, 50, 50)];
                img.backgroundColor = [UIColor blackColor];
                img.userInteractionEnabled = YES;
                img.alpha = 0.5;
                [emptyImgScroller addSubview:img];
            }
        }
            break;
        case 5002:
        {
//            [iArray2 removeAllObjects];
            for (int i =finishCount-1; i<finishCount; i++)
            {
                UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(5+55*i, 5, 50, 50)];
                img.backgroundColor = [UIColor blackColor];
                img.userInteractionEnabled = YES;
                img.alpha = 0.5;
                [loadImgScroller addSubview:img];
            }
        }
            break;
        case 5003:
        {
//            [iArray3 removeAllObjects];
            for (int i =finishCount-1; i<finishCount; i++)
            {
                UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(5+55*i, 5, 50, 50)];
                img.backgroundColor = [UIColor blackColor];
                img.userInteractionEnabled = YES;
                img.alpha = 0.5;
                [finishImgScroller addSubview:img];
            }
        }
            break;
        default:
            break;
    }
    
    switch (selectTags) {
        case 5000:
            [imgPath appendString:[NSString stringWithFormat:@"%@,",[dic valueForKey:@"name"]]];
            break;
        case 5001:
            [emptyImg appendString:[NSString stringWithFormat:@"%@,",[dic valueForKey:@"name"]]];
            break;
        case 5002:
            [loadImg appendString:[NSString stringWithFormat:@"%@,",[dic valueForKey:@"name"]]];
            break;
        case 5003:
            [finishImg appendString:[NSString stringWithFormat:@"%@,",[dic valueForKey:@"name"]]];
            break;
        default:
            break;
    }
    
    [self upLoadImageWithSort];
}


-(void) uploadFail:(NSError *)error
{
    finishCount ++;
    HUD.progress = ((float)finishCount)/uploadArray.count;
    [self upLoadImageWithSort];
    if (finishCount == [uploadArray count] && errorCount > 0) {
        alertMessage(@"图片上传失败。");
    }
}

- (void)imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController
{
    NSLog(@"取消选择");
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (NSString *)descriptionForSelectingAllAssets:(QBImagePickerController *)imagePickerController
{
    return @"";
}

- (NSString *)descriptionForDeselectingAllAssets:(QBImagePickerController *)imagePickerController
{
    return @"";
}

- (NSString *)imagePickerController:(QBImagePickerController *)imagePickerController descriptionForNumberOfPhotos:(NSUInteger)numberOfPhotos
{
    return [NSString stringWithFormat:@"图片%d张", numberOfPhotos];
}

- (NSString *)imagePickerController:(QBImagePickerController *)imagePickerController descriptionForNumberOfVideos:(NSUInteger)numberOfVideos
{
    return [NSString stringWithFormat:@"视频%d", numberOfVideos];
}

- (NSString *)imagePickerController:(QBImagePickerController *)imagePickerController descriptionForNumberOfPhotos:(NSUInteger)numberOfPhotos numberOfVideos:(NSUInteger)numberOfVideos
{
    return [NSString stringWithFormat:@"图片%d 视频%d", numberOfPhotos, numberOfVideos];
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[HUD removeFromSuperview];
	[HUD release];
	HUD = nil;
}



-(void) clearTextField:(id) sender
{
    for (int i = 2000; i<2016; i++) {
        UITextField *field = (UITextField *)[self.view viewWithTag:i];
        field.text = @"";
    }
    [[imgScroller subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    pickImage.alpha = 1.0;
    allCount = 0;
    [imgPath setString:@""];
    [emptyImg setString:@""];
    [loadImg setString:@""];
    [finishImg setString:@""];
}

-(void) pickerViewString:(NSString *)date
{
    UITextField *field = (UITextField *)[self.view viewWithTag:currentTag];
    field.text = date;
}

#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (bm == textField) {
        isSuccess = NO;
    }
    
    if (timeEnd == textField || timeStart == textField || time == textField) {
        currentTag = textField.tag;
        [pickerView setHidden:NO];
        [self.view endEditing:YES];
        return NO;
    }
    [pickerView setHidden:YES];
    if ([textField tag] == 2013) {
        if (scroll.frame.origin.y < 0) {
            return YES;
        }
        [UIView animateWithDuration:0.5 animations:^{
            scroll.frame = CGRectMake(0, -39*4 + 10, 320, kScreenHeight - 64);
        }];
    }
    return YES;
}

-(void) textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.5 animations:^{
        scroll.frame = CGRectMake(0, 0, 320, kScreenHeight - 64);
    }];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if (textField.tag == 2000 && [textField.text length] != 0) {
        
        AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@""]];
        
        client.parameterEncoding = AFFormURLParameterEncoding;
        
        [client setDefaultHeader:@"Accept" value:@"text/json"];
        
        
        NSString *string = [NSString stringWithFormat:@"http://114.215.103.53/wfplatform/handling_records!getHr.action?contractNo=%@",textField.text];
        
        [client getPath:string parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self checkBmData:responseObject];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"ERROR : %@",[error localizedDescription]);
        }];

        
        [client release];
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        scroll.frame = CGRectMake(0, 0, 320, kScreenHeight - 64);
    }];
    
    [self.view endEditing:YES];
    return YES;
}

- (void)closeBtnClick:(UIButton *)sender
{
    NSLog(@"hello world");
}

-(void) checkBmData:(NSData *)data
{
    NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    NSError *error = nil;
    
    NSMutableDictionary *info = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error || !info) {
        return ;
    }
    
    isSuccess = YES;
    
    bm.text = [[info objectForKey:@"contractNo"] description];
    salesman.text = [[info objectForKey:@"handleUser"] description];
    boatName.text = [[info objectForKey:@"shipName"] description];
    boatNo.text = [[info objectForKey:@"shipVoyage"] description];
    goodsName.text = [[info objectForKey:@"cargoName"] description];
    reason.text = [[info objectForKey:@"cargoLoadReason"] description];
    time.text = [[info objectForKey:@"finishedDate"] description];
    start.text = [[info objectForKey:@"loadPort"] description];
    end.text = [[info objectForKey:@"dischargePort"] description];
    planCount.text = [[info objectForKey:@"cargoWeight"] description];
    actualCount.text = [[info objectForKey:@"realNum"] description];
    warehouseCapacity.text = [[info objectForKey:@"releaseNum"] description];
//    outworker.text = [[info objectForKey:@"recordUserId"] description];
    outworker.text = [DataCenter shareInstance].userName;
    remark.text = [[info objectForKey:@"remark"] description];
    timeStart.text = [[info objectForKey:@"workBeg"] description];
    timeEnd.text = [[info objectForKey:@"workEnd"] description];
    
    NSString *path = [[info objectForKey:@"img"] description];
    if ([path length] == 0) {
        return ;
    }
    NSArray *array = [path componentsSeparatedByString:@","];
    
    /*if ([array count] > 0) {
        pickImage.alpha = 0.0;
    } else {
        pickImage.alpha = 1.0;
    }*/
    
    for (int i = 0; i<array.count; i++) {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(5+55*i, 5, 50, 50)];
        NSString *imgUrl = [[NSString stringWithFormat:@"http://114.215.103.53/upload/%@ZX/%@",bm.text,[array objectAtIndex:i]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [img setImageWithURL:[NSURL URLWithString:imgUrl]];
        [imgScroller addSubview:img];
        [imgScroller setContentSize:CGSizeMake(5+55*(finishCount-errorCount-1)+5, 50)];
        [img release];
    }

    imgPath = [[NSMutableString alloc] initWithFormat:@"%@,",path];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc
{
    /*
    [label1 release];
    [label2 release];
    [label3 release];
    [label4 release];
     */
    
    [iArray release];
    [imgPath release];
    [emptyImg release];
    [loadImg release];
    [finishImg release];
    [super dealloc];
}

@end
