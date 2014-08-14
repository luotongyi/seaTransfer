//
//  DetailViewController.m
//  SeaTransfer
//
//  Created by Cao JianRong on 14-4-28.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize detailDic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*!
 *  更新货物信息
 *
 *  @param sender 更新操作
 */
-(void) updateDetail:(id) sender
{
    for (int i = 2000; i<2016; i++) {
        UITextField *field = (UITextField *)[self.view viewWithTag:i];
        if ([field.text length] == 0) {
            alertMessage(@"请检查输入信息的完整性。");
            return ;
        }
    }
    
    NSString *userId = [[DataCenter shareInstance].userInfo  objectForKey:@"userId"];
    NSString *vogId = [self.detailDic objectForKey:@"shipVoyageId"];
    NSString *recoderUserId = [DataCenter shareInstance].userName;
    NSString *recordsId = [self.detailDic objectForKey:@"id"];
    
    NSMutableString *string =  [[NSMutableString alloc] init];
    
    NSString *str1 = [self.detailDic objectForKey:@"emptyImg"];
    NSString *str2 = [self.detailDic objectForKey:@"finishImg"];
    NSString *str3 = [self.detailDic objectForKey:@"img"];
    NSString *str4 = [self.detailDic objectForKey:@"loadImg"];
    str4 = [str4 substringToIndex:[str4 length]-1];
    
    [string appendString:str1];
    [string appendString:str2];
    [string appendString:str3];
    [string appendString:str4];
    
    /*NSArray *array = [self.detailDic objectForKey:@"imgs"];
    
    for (NSString *url in array) {
        NSString *img = [NSString stringWithFormat:@"%@,",[url substringFromIndex:[url length]-19] ];
        [string appendString:img];
    }
    
    if ([string length] >0) {
        [string setString:[string substringToIndex:[string length]-1]];
    }*/
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         recordsId,@"handlingRecords.id",
                         bm.text,@"handlingRecords.contractNo",
                         salesman.text,@"handlingRecords.handleUser",
                         boatName.text,@"handlingRecords.shipName",
                         boatNo.text,@"handlingRecords.shipVoyage",
                         !vogId ? @"" : vogId,@"handlingRecords.shipVoyageId",
                         goodsName.text,@"handlingRecords.cargoName",
                         reason.text,@"handlingRecords.cargoLoadReason",
                         time.text,@"handlingRecords.finishedDate",
                         start.text,@"handlingRecords.loadPort",
                         end.text,@"handlingRecords.dischargePort",
                         planCount.text,@"handlingRecords.cargoNum",
                         actualCount.text,@"handlingRecords.realNum",
                         warehouseCapacity.text,@"handlingRecords.releaseNum",
                         !recoderUserId ? @"" : recoderUserId,@"handlingRecords.recordUserId",
                         remark.text,@"handlingRecords.remark",
                         !string ? @"" : string , @"handlingRecords.img",
                         timeStart.text , @"handlingRecords.workBeg",
                         timeEnd.text , @"handlingRecords.workEnd",nil];
    
    NSString *pathStr=@"http://114.215.103.53/wfplatform/handling_records!save.action";
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@""]];
    
    httpClient.parameterEncoding = AFFormURLParameterEncoding;
    
    [httpClient setDefaultHeader:@"Accept" value:@"text/json"];
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc] initWithDictionary:dic];
    
    [httpClient postPath:pathStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self checkData:responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"[HTTPClient Error]: %@", error);
        
        alertMessage(@"更新装卸记录失败，请检查网络链接.");
    }];
    
    [params release];
    
    [httpClient release];
}

-(void) checkData:(NSData *)data
{
    NSError *error = nil;
    
    NSDictionary *info = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error || !info) {
        alertMessage(@"更新装卸记录失败，请重新操作");
        return ;
    }
    
    NSLog(@"Request Successful, response:\n %@", info);
    
    self.navigationItem.rightBarButtonItem = nil;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(editDetail:)];
    self.navigationItem.rightBarButtonItem = item;
    [item release];
    for (int i = 2000; i<2016; i++) {
        UITextField *field = (UITextField *)[self.view viewWithTag:i];
        field.userInteractionEnabled = NO;
        field.borderStyle = UITextBorderStyleNone;
        field.layer.borderWidth = 0.0;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[info objectForKey:@"title"] message:[info objectForKey:@"detail"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}

/*!
 *  编辑货物信息
 *
 *  @param sender 编辑操作
 */
-(void) editDetail:(id) sender
{
    self.navigationItem.rightBarButtonItem = nil;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(updateDetail:)];
    self.navigationItem.rightBarButtonItem = item;
    [item release];
    for (int i = 2000; i<2016; i++) {
        UITextField *field = (UITextField *)[self.view viewWithTag:i];
        field.userInteractionEnabled = YES;
        field.borderStyle = UITextBorderStyleNone;
        field.layer.borderWidth = 1.0;
    }
}

-(void) createInitView
{
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
    
    bm = [[UITextField alloc] initWithFrame:CGRectMake(60, 17.5, 95, 20)];
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
    
    salesman = [[UITextField alloc] initWithFrame:CGRectMake(215, 17.5, 95, 20)];
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
    
    lInfo = [[UILabel alloc] initWithFrame:CGRectMake(10, rInfo.frame.size.height + rInfo.frame.origin.y + 15, 50, 15)];
    [lInfo setFont:[UIFont systemFontOfSize:11.0]];
    lInfo.textColor = [UIColor blackColor];
    lInfo.textAlignment = NSTextAlignmentRight;
    lInfo.text = @"装      港:";
    lInfo.backgroundColor = [UIColor clearColor];
    [scroll addSubview:lInfo];
    [lInfo release];
    
    start = [[UITextField alloc] initWithFrame:CGRectMake(lInfo.frame.origin.x + lInfo.frame.size.width, rInfo.frame.size.height + rInfo.frame.origin.y + 15, 95, 20)];
    start.font = [UIFont systemFontOfSize:11.0f];
    start.layer.borderColor = HEXCOLOR(0xEBEBEB).CGColor;
    start.layer.borderWidth = 1.0f;
    [scroll addSubview:start];
    [start release];
    
    rInfo = [[UILabel alloc] initWithFrame:CGRectMake(160, rInfo.frame.size.height + rInfo.frame.origin.y + 15, 50, 15)];
    [rInfo setFont:[UIFont systemFontOfSize:11.0]];
    rInfo.textColor = [UIColor blackColor];
    rInfo.textAlignment = NSTextAlignmentRight;
    rInfo.text = @"卸      港:";
    rInfo.backgroundColor = [UIColor clearColor];
    [scroll addSubview:rInfo];
    [rInfo release];
    
    end = [[UITextField alloc] initWithFrame:CGRectMake(rInfo.frame.origin.x + rInfo.frame.size.width+5, rInfo.frame.origin.y, 95, 20)];
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
    
    
     lInfo = [[UILabel alloc] initWithFrame:CGRectMake(10, rInfo.frame.size.height + rInfo.frame.origin.y + 10, 50, 15)];
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
     
     rInfo = [[UILabel alloc] initWithFrame:CGRectMake(160, lInfo.frame.origin.y , 50, 15)];
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
     
    UILabel *timeInfo = [[UILabel alloc] initWithFrame:CGRectMake(10, rInfo.frame.size.height + rInfo.frame.origin.y + 20, 70, 30)];
    timeInfo.text = @"离港时间:";
    timeInfo.textColor = [UIColor blackColor];
    [timeInfo setFont:[UIFont systemFontOfSize:11]];
    [scroll addSubview:timeInfo];
    [timeInfo release];
    
    time = [[UITextField alloc] initWithFrame:CGRectMake(62,timeInfo.frame.origin.y , 230, 30)];
    time.font = [UIFont systemFontOfSize:11];
    time.layer.borderColor = HEXCOLOR(0xEBEBEB).CGColor;
    time.layer.borderWidth = 1.0f;
    [scroll addSubview:time];
    [time release];
    
    UILabel *remarkInfo = [[UILabel alloc] initWithFrame:CGRectMake(10, time.frame.size.height + time.frame.origin.y + 20, 70, 30)];
    remarkInfo.textAlignment = NSTextAlignmentCenter;
    remarkInfo.text = @"备    注";
    remarkInfo.textColor = HEXCOLOR(0xC03822);
    remarkInfo.backgroundColor = HEXCOLOR(0xDDD8D9);
    [remarkInfo setFont:[UIFont systemFontOfSize:17.0]];
    [scroll addSubview:remarkInfo];
    [remarkInfo release];
    
    remark = [[UITextField alloc] initWithFrame:CGRectMake(82,time.frame.size.height + time.frame.origin.y + 20, 230, 30)];
    remark.font = [UIFont systemFontOfSize:11];
    remark.layer.borderColor = HEXCOLOR(0xEBEBEB).CGColor;
    remark.layer.borderWidth = 1.0f;
    remark.backgroundColor = HEXCOLOR(0xDDD8D9);
    [scroll addSubview:remark];
    [remark release];
    
    
    UIScrollView *scrolls = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 310, 300, 70)];
    [scrolls setContentSize:CGSizeMake(600, 50)];
    scrolls.showsHorizontalScrollIndicator = NO;
    [scroll addSubview:scrolls];
    
    NSInteger imgCount = [[self.detailDic objectForKey:@"img"] count];
    
    for (int i = 0; i<imgCount; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(75*i+2.5, 2.5, 70, 65)];
        [imgView setImageWithURL:[NSURL URLWithString:[[[self.detailDic objectForKey:@"img"] objectAtIndex:i] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        [scrolls addSubview:imgView];
        [imgView release];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor clearColor];
        btn.frame = CGRectMake(75*i+2.5, 2.5, 70, 65);
        btn.tag = 1000+i;
        [btn addTarget:self action:@selector(seeBigPicture:) forControlEvents:UIControlEventTouchUpInside];
        [scrolls addSubview:btn];
    }
    
    [scrolls setContentSize:CGSizeMake(75*imgCount+3.5, 70)];
    
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
    
    pickerView = [[CHPickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    pickerView.delegate = self;
    [self.view addSubview:pickerView];
    [pickerView release];
    [pickerView setHidden:YES];
    
    for (int i = 2000; i<2016; i++) {
        UITextField *field = (UITextField *)[self.view viewWithTag:i];
        field.userInteractionEnabled = NO;
        field.delegate = self;
        field.borderStyle = UITextBorderStyleNone;
        field.layer.borderWidth = 0.0;
    }
    
    bm.text = [self.detailDic objectForKey:@"contractNo"];
    salesman.text = [self.detailDic objectForKey:@"uname"];
    boatName.text = [self.detailDic objectForKey:@"shipName"];
    boatNo.text = [self.detailDic objectForKey:@"shipVoyage"];
    goodsName.text = [self.detailDic objectForKey:@"cargoName"];
    reason.text = [self.detailDic objectForKey:@"cargoLoadReason"];
    time.text = [self.detailDic objectForKey:@"finishedDate"];
    start.text = [self.detailDic objectForKey:@"loadPort"];
    end.text = [self.detailDic objectForKey:@"dischargePort"];
    planCount.text = [NSString stringWithFormat:@"%@",[self.detailDic objectForKey:@"cargoNum"]];
    actualCount.text = [NSString stringWithFormat:@"%@",[self.detailDic objectForKey:@"realNum"]];
    warehouseCapacity.text = [NSString stringWithFormat:@"%@",[self.detailDic objectForKey:@"releaseNum"]];
//    outworker.text = [self.detailDic objectForKey:@"recordUserId"];
    outworker.text = [DataCenter shareInstance].userName;
    remark.text = [self.detailDic objectForKey:@"remark"];
    timeStart.text = [self.detailDic objectForKey:@"workBeg"];
    timeEnd.text = [self.detailDic objectForKey:@"workEnd"];
    
    [scroll setContentSize:CGSizeMake(320, 415)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(editDetail:)];
    self.navigationItem.rightBarButtonItem = item;
    [item release];
    
    [self createInitView];
}

-(void) seeBigPicture:(id)sender
{
    NSLog(@"%d",[sender tag]);
    NSArray *array = [self.detailDic objectForKey:@"img"];
    NSString *url = [[array objectAtIndex:[sender tag]-1000] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if (array.count == 0) {
        return;
    }
    ImageControl *imgControl = [[ImageControl alloc] initWithUrl:url andImageTitle:@"详细大图"];
    [imgControl show];
    [imgControl release];
}

-(void) pickerViewString:(NSString *)date
{
    UITextField *field = (UITextField *)[self.view viewWithTag:currentTag];
    field.text = date;
}

#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (time == textField || timeEnd == textField || timeStart == textField) {
        currentTag = textField.tag;
        [pickerView setHidden:NO];
        [self.view endEditing:YES];
        return NO;
    }
    [pickerView setHidden:YES];
    if ([textField tag] >= 2007) {
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
    if ([textField tag] >= 2007) {
        if (scroll.frame.origin.y < 0) {
            return ;
        }
        [UIView animateWithDuration:0.5 animations:^{
            scroll.frame = CGRectMake(0, 0, 320, kScreenHeight - 64);
        }];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [UIView animateWithDuration:0.5 animations:^{
        scroll.frame = CGRectMake(0, 0, 320, kScreenHeight - 64);
    }];
    
    [self.view endEditing:YES];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:0.5 animations:^{
        scroll.frame = CGRectMake(0, 0, 320, kScreenHeight - 64);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc
{
    [detailDic release];
    [super dealloc];
}

@end
