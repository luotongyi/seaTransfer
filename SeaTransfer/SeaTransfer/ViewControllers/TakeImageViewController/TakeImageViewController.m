//
//  TakeImageViewController.m
//  SeaTransfer
//
//  Created by Cao JianRong on 14-4-30.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "TakeImageViewController.h"

@interface TakeImageViewController ()

@end

@implementation TakeImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = nil;
    
    imageArray = [[NSMutableArray alloc] init];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setItemSize:CGSizeMake(100, 135)];
    //    [layout setMinimumInteritemSpacing:1];
    [layout setMinimumLineSpacing:10.0f];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    waterView = [[UICollectionView alloc] initWithFrame:CGRectMake(5, 0, 310, kScreenHeight - 64) collectionViewLayout:layout];
    waterView.delegate = self;
    waterView.dataSource = self;
    waterView.showsVerticalScrollIndicator = NO;
    [waterView registerClass:[CollectionCell class] forCellWithReuseIdentifier:@"collectionIdentifier"];
    waterView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:waterView];
    [layout release];
    [waterView release];
    
    imagePicker = [[UIImagePickerController alloc] init];
    //在选定图片之前，用户可以简单编辑要选的图片。包括上下移动改变图片的选取范围，用手捏合动作改变图片的大小等。
    //        imagePicker.allowsEditing = YES;
    //实现委托，委托必须实现UIImagePickerControllerDelegate协议，来对用户在图片选取器中的动作
    imagePicker.delegate = self;
    //指定源类型前，检查图片源是否可用
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
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

/**
 *  返回每个collectionViewCell的大小（可以进行单独的配置）
 *
 *  @param collectionView       collectionView
 *  @param collectionViewLayout collectionViewLayout
 *  @param indexPath            indexPath
 *
 *  @return 返回每个collectionViewCell的大小
 */
-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 135);
}


-(CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.0;
}

-(CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 15.0;
}

//-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//
//}
//
//-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//
//}


/**
 *  总共有多少个Section
 *
 *  @param collectionView collectionView
 *
 *  @return 返回总共多少个Section
 */
-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

/**
 *  每个section总共有多少个cell
 *
 *  @param collectionView collection
 *  @param section        当前的section
 *
 *  @return 返回每个section总共有多少个cell
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [imageArray count];
}

/**
 *  返回的UICollectionViewCell
 *  这个cell返回的时候必须先从
 *  -dequeueReusableCellWithReuseIdentifier:forIndexPath:中检索
 *
 *  @param  collectionView
 *
 *  @return 返回Cell
 */
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *collectionIdentifier = @"collectionIdentifier";
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[[CollectionCell alloc] init] autorelease];
    }
    cell.label.text = @"collection";
    NSLog(@"%@",[[imageArray objectAtIndex:indexPath.row] class]);
    [cell.icon setImage:[imageArray objectAtIndex:indexPath.row]];
    return cell;
}

/**
 *  选中的当前Cell的点击事件
 *
 *  @param collectionView collectionView
 *  @param indexPath      indexPath  索引
 */
-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark -
#pragma mark UIImagePickerControllerDelegate协议的方法

//用户点击图像选取器中的“cancel”按钮时被调用，这说明用户想要中止选取图像的操作
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//用户点击选取器中的“choose”按钮时被调用，告知委托对象，选取操作已经完成，同时将返回选取图片的实例
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [NSThread detachNewThreadSelector:@selector(getScaleImage:) toTarget:self withObject:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)getScaleImage:(UIImage *)image {
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    // Create a graphics image context
    
    image = [UIImage imageWithData:UIImageJPEGRepresentation(image, 0.5)];
    
    CGSize newSize = CGSizeMake(160, 120);
    
    UIGraphicsBeginImageContext(newSize);
    
    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
    
    // Tell the old image to draw in this new context, with the desired
    
    // new size
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    
    UIGraphicsEndImageContext();

    pickImg = [[UIImage alloc] initWithCGImage:newImage.CGImage];
    
    [imageArray addObject:pickImg];

    [waterView reloadData];
    
    [pool release];
}


-(void) addImage:(id)sender
{
    NSLog(@"addImage");
    imagePicker = [[UIImagePickerController alloc] init];
    //在选定图片之前，用户可以简单编辑要选的图片。包括上下移动改变图片的选取范围，用手捏合动作改变图片的大小等。
    //        imagePicker.allowsEditing = YES;
    //实现委托，委托必须实现UIImagePickerControllerDelegate协议，来对用户在图片选取器中的动作
    imagePicker.delegate = self;
    //指定源类型前，检查图片源是否可用
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
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

-(void) upLoadImages:(id)sender
{
    NSLog(@"upload");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc
{
    [imageArray release];
    if (pickImg) {
        [pickImg release];
    }
    [super dealloc];
}

@end
