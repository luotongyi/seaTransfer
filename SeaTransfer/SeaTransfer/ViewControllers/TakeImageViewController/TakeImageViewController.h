//
//  TakeImageViewController.h
//  SeaTransfer
//
//  Created by Cao JianRong on 14-4-30.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "CommonViewController.h"
#import "CollectionCell.h"

@interface TakeImageViewController : CommonViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UIImagePickerController *imagePicker;
    UIImage *pickImg;
    NSMutableArray *imageArray;
    UICollectionView *waterView;
}
@end
