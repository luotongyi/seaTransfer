//
//  CollectionCell.h
//  LuxuryA4L
//
//  Created by Cao JianRong on 13-12-5.
//  Copyright (c) 2013年 Cao JianRong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionCell : UICollectionViewCell
{
    UILabel* label;
    UIImageView* icon;
}
@property (retain, nonatomic) UILabel* label;
@property (retain, nonatomic) UIImageView* icon;
@end
