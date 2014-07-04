//
//  CollectionCell.m
//  LuxuryA4L
//
//  Created by Cao JianRong on 13-12-5.
//  Copyright (c) 2013年 Cao JianRong. All rights reserved.
//

#import "CollectionCell.h"

@implementation CollectionCell
@synthesize label,icon;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.icon = imageView;
        [self.contentView addSubview:imageView];
        [imageView release];
        
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 115.0, 100, 20)];
        self.label = lb;
//        self.label.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont boldSystemFontOfSize:11.0];
        self.label.backgroundColor = [UIColor brownColor];
        self.label.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.label];
        [lb release];
        
        self.contentView.layer.borderWidth = 4.0f;
        self.contentView.layer.borderColor = [UIColor whiteColor].CGColor;
//        self.contentView.layer.cornerRadius = 4.0f;
    }
    return self;
}

-(void) dealloc
{
    [label release];
    [icon release];
    [super dealloc];
}

@end
