//
//  ListViewController.h
//  SeaTransfer
//
//  Created by Cao JianRong on 14-4-28.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "CommonViewController.h"
#import "DetailViewController.h"
#import "RecoderCell.h"
#import "UIScrollView+PullLoad.h"

@interface ListViewController : CommonViewController <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,PullDelegate>
{
    UITableView *recodeTable;
    NSMutableArray *recodeArray;
    NSMutableArray *searchArray;
    UITextField *searchText;
    NSInteger index;
    BOOL isSearch;
    int currentPage;
    UIButton *searchBtn;
}
@end
