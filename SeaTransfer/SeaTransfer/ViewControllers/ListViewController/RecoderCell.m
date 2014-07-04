//
//  RecoderCell.m
//  SeaTransfer
//
//  Created by Cao JianRong on 14-4-28.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "RecoderCell.h"

@implementation RecoderCell
@synthesize bm,salesman,boatName,boatNo,goodsName,reason,bgView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self createInitView];
    }
    return self;
}

-(void) createInitView
{
    UILabel *lInfo = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 50, 15)];
    [lInfo setFont:[UIFont systemFontOfSize:11.0]];
    lInfo.textColor = [UIColor blackColor];
    lInfo.textAlignment = NSTextAlignmentRight;
    lInfo.text = @"业务编号:";
    lInfo.backgroundColor = [UIColor clearColor];
    [self addSubview:lInfo];
    [lInfo release];
    
    UILabel *field = [[UILabel alloc] initWithFrame:CGRectMake(60, 7.5, 95, 20)];
    self.bm = field;
    self.bm.font = [UIFont systemFontOfSize:11.0f];
    self.bm.layer.borderColor = HEXCOLOR(0xEBEBEB).CGColor;
    self.bm.layer.borderWidth = 1.0f;
    [self addSubview:self.bm];
    [field release];
    
    
    UILabel *rInfo = [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 50, 15)];
    [rInfo setFont:[UIFont systemFontOfSize:11.0]];
    rInfo.textColor = [UIColor blackColor];
    rInfo.textAlignment = NSTextAlignmentRight;
    rInfo.text = @"业  务  员:";
    rInfo.backgroundColor = [UIColor clearColor];
    [self addSubview:rInfo];
    [rInfo release];
    
    field = [[UILabel alloc] initWithFrame:CGRectMake(215, 7.5, 95, 20)];
    self.salesman = field;
    self.salesman.font = [UIFont systemFontOfSize:11.0f];
    self.salesman.layer.borderColor = HEXCOLOR(0xEBEBEB).CGColor;
    self.salesman.layer.borderWidth = 1.0f;
    [self addSubview:self.salesman];
    [field release];
    
    lInfo = [[UILabel alloc] initWithFrame:CGRectMake(10, lInfo.frame.size.height + lInfo.frame.origin.y + 10, 50, 15)];
    [lInfo setFont:[UIFont systemFontOfSize:11.0]];
    lInfo.textColor = [UIColor blackColor];
    lInfo.textAlignment = NSTextAlignmentRight;
    lInfo.text = @"船      名:";
    lInfo.backgroundColor = [UIColor clearColor];
    [self addSubview:lInfo];
    [lInfo release];
    
    field = [[UILabel alloc] initWithFrame:CGRectMake(lInfo.frame.origin.x + lInfo.frame.size.width, lInfo.frame.origin.y-2.5, 95, 20)];
    self.boatName = field;
    self.boatName.font = [UIFont systemFontOfSize:11.0f];
    self.boatName.layer.borderColor = HEXCOLOR(0xEBEBEB).CGColor;
    self.boatName.layer.borderWidth = 1.0f;
    [self addSubview:self.boatName];
    [field release];
    
    rInfo = [[UILabel alloc] initWithFrame:CGRectMake(160, rInfo.frame.size.height + rInfo.frame.origin.y + 10, 50, 15)];
    [rInfo setFont:[UIFont systemFontOfSize:11.0]];
    rInfo.textColor = [UIColor blackColor];
    rInfo.textAlignment = NSTextAlignmentRight;
    rInfo.text = @"航       次:";
    rInfo.backgroundColor = [UIColor clearColor];
    [self addSubview:rInfo];
    [rInfo release];
    
    field = [[UILabel alloc] initWithFrame:CGRectMake(rInfo.frame.origin.x + rInfo.frame.size.width+5, lInfo.frame.origin.y-2.5, 95, 20)];
    self.boatNo = field;
    self.boatNo.font = [UIFont systemFontOfSize:11.0f];
    self.boatNo.layer.borderColor = HEXCOLOR(0xEBEBEB).CGColor;
    self.boatNo.layer.borderWidth = 1.0f;
    [self addSubview:self.boatNo];
    [field release];
    
    lInfo = [[UILabel alloc] initWithFrame:CGRectMake(10, lInfo.frame.size.height + lInfo.frame.origin.y + 10, 50, 15)];
    [lInfo setFont:[UIFont systemFontOfSize:11.0]];
    lInfo.textColor = [UIColor blackColor];
    lInfo.textAlignment = NSTextAlignmentRight;
    lInfo.text = @"货      名:";
    lInfo.backgroundColor = [UIColor clearColor];
    [self addSubview:lInfo];
    [lInfo release];
    
    field = [[UILabel alloc] initWithFrame:CGRectMake(lInfo.frame.origin.x + lInfo.frame.size.width, lInfo.frame.origin.y-2.5, 95, 20)];
    self.goodsName = field;
    self.goodsName.font = [UIFont systemFontOfSize:11.0f];
    self.goodsName.layer.borderColor = HEXCOLOR(0xEBEBEB).CGColor;
    self.goodsName.layer.borderWidth = 1.0f;
    [self addSubview:self.goodsName];
    [field release];
    
    rInfo = [[UILabel alloc] initWithFrame:CGRectMake(160, rInfo.frame.size.height + rInfo.frame.origin.y + 10, 50, 15)];
    [rInfo setFont:[UIFont systemFontOfSize:11.0]];
    rInfo.textColor = [UIColor blackColor];
    rInfo.textAlignment = NSTextAlignmentRight;
    rInfo.text = @"记载因素:";
    rInfo.backgroundColor = [UIColor clearColor];
    [self addSubview:rInfo];
    [rInfo release];
    
    field = [[UILabel alloc] initWithFrame:CGRectMake(rInfo.frame.origin.x + rInfo.frame.size.width+5, lInfo.frame.origin.y-2.5, 95, 20)];
    self.reason = field;
    self.reason.font = [UIFont systemFontOfSize:11.0f];
    self.reason.layer.borderColor = HEXCOLOR(0xEBEBEB).CGColor;
    self.reason.layer.borderWidth = 1.0f;
    [self addSubview:self.reason];
    [field release];
    
    UIScrollView *bView = [[UIScrollView alloc] initWithFrame:CGRectMake(17.5, 79, 285, 72)];
    for (int i = 0; i<4; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(71*i+1, 1, 70, 70)];
        imgView.backgroundColor = [UIColor colorWithWhite:0.5+i*0.1 alpha:0.8];
        [bView addSubview:imgView];
        [imgView release];
    }
    self.bgView = bView;
    [self addSubview:bView];
    [bView release];
    
}

-(void) setDataWithDictionary:(NSDictionary *) dictionary
{
    self.bm.text = [dictionary objectForKey:@"contractNo"];
    self.salesman.text = [dictionary objectForKey:@"userName"];
    self.boatName.text = [dictionary objectForKey:@"shipName"];
    self.boatNo.text = [dictionary objectForKey:@"shipVoyage"];
    self.goodsName.text = [dictionary objectForKey:@"cargoName"];
    self.reason.text = [dictionary objectForKey:@"cargoLoadReason"];
    
    [[self.bgView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if ([dictionary objectForKey:@"img"]) {
        NSArray *array = [dictionary objectForKey:@"img"];
        for (int i = 0; i<array.count;i++) {
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(1+72*i, 1, 70, 70)];
            [imgView setImageWithURL:[NSURL URLWithString:[[array objectAtIndex:i] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
            [self.bgView addSubview:imgView];
            [imgView release];
        }
        [self.bgView setContentSize:CGSizeMake(72*array.count, 72)];
    }
    
    
}

-(void) reloadImageViews:(NSArray *) array
{
    [[self.bgView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIImageView *bView = [[UIImageView alloc] initWithFrame:CGRectMake(17.5, 79, 285, 72)];
    for (int i = 0; i<array.count; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(71*i+1, 1, 70, 70)];
        imgView.backgroundColor = [UIColor colorWithWhite:0.5+i*0.1 alpha:0.8];
        [bView addSubview:imgView];
        [imgView release];
    }
    self.bgView = bView;
    [self addSubview:bView];
    [bView release];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) dealloc
{
    [bm release];
    [salesman release];
    [boatNo release];
    [boatName release];
    [reason release];
    [goodsName release];
    [bgView release];
    [super dealloc];
}

@end
