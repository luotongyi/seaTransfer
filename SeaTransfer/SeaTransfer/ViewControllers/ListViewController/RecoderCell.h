//
//  RecoderCell.h
//  SeaTransfer
//
//  Created by Cao JianRong on 14-4-28.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecoderCell : UITableViewCell
{
    UILabel *bm;
    UILabel *salesman;
    UILabel *boatName;
    UILabel *boatNo;
    UILabel *goodsName;
    UILabel *reason;
    UIScrollView *bgView;
}
@property (nonatomic, retain) UILabel *bm;
@property (nonatomic, retain) UILabel *salesman;
@property (nonatomic, retain) UILabel *boatName;
@property (nonatomic, retain) UILabel *boatNo;
@property (nonatomic, retain) UILabel *goodsName;
@property (nonatomic, retain) UILabel *reason;
@property (nonatomic, retain) UIScrollView *bgView;

-(void) setDataWithDictionary:(NSDictionary *) dictionary;

@end
