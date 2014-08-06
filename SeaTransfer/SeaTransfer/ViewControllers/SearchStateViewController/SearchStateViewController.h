//
//  SearchStateViewController.h
//  SeaTransfer
//
//  Created by Cao JianRong on 14-6-12.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "CommonViewController.h"

@interface SearchStateViewController : CommonViewController <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView *recodeTable;
    NSMutableArray *searchArray;
    UITextField *searchText;
    UIButton *searchBtn;
    UIView *headerView;
    CGSize portSize,portSize1;
    CGSize shipSize;
    NSString *portAgent,*portAgent1;
    NSString *shipSpec;
}
@end
