//
//  AssetPickerController.m
//  taiben_ipad
//
//  Created by lbf on 14-8-21.
//  Copyright (c) 2014年 xun-ao. All rights reserved.
//

#import "AssetPickerController.h"
#import "AssetPickerCell.h"

@interface AssetPickerController ()
{
    UIBarButtonItem *confirmButton;
}
@property (nonatomic) NSMutableArray *imageList;
@property (nonatomic) NSMutableArray *pickList;

@end

@implementation AssetPickerController

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
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
	[self.navigationItem setTitle:@"选择文件"];
    
    confirmButton = [[UIBarButtonItem alloc] initWithTitle:@"选择" style:UIBarButtonItemStylePlain target:self action:@selector(pickup)];
    [confirmButton setEnabled:NO];
	[self.navigationItem setRightBarButtonItem:confirmButton];
    
    [self.view addSubview:self.tableView];
	[self performSelectorInBackground:@selector(preparePhotos) withObject:nil];
}

-(void)pickup
{
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.assetPicked != nil) {
            self.assetPicked(self.pickList);
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray *)imageList
{
    if (_imageList == nil) {
        _imageList = [NSMutableArray array];
    }
    return _imageList;
}

-(NSMutableArray *)pickList
{
    if (_pickList == nil) {
        _pickList = [NSMutableArray array];
    }
    return _pickList;
}

-(UICollectionView *)tableView
{
    if (_tableView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        [layout setMinimumInteritemSpacing:2];
        [layout setMinimumLineSpacing:2];
        [layout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        float offset = 20+44;
        _tableView = [[UICollectionView alloc] initWithFrame:CGRectMake(11, 0, self.view.frame.size.width-22, self.view.frame.size.height-offset) collectionViewLayout:layout];
        [_tableView setBackgroundColor:[UIColor whiteColor]];
        [_tableView registerClass:[AssetPickerCell class] forCellWithReuseIdentifier:@"pickerCell"];
        [_tableView setContentInset:UIEdgeInsetsMake(20, 0, 20, 0)];
        [_tableView setShowsVerticalScrollIndicator:NO];
        
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
    }
    return _tableView;
}


- (void)preparePhotos
{
    @autoreleasepool {
        [self.assetGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if (result == nil) {
                return;
            }
            [self.imageList addObject:[XAAssetData dataWith:result]];
        }];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }
}

#pragma mark-元素选中
-(BOOL)pickItemWithIndex:(int)index
{
    if (index >= 0 && index < [self.imageList count]) {
        int count = (int)[self.pickList count];
        id item = [self.imageList objectAtIndex:index];
        if ([self isItemPickedUp:item]) {
            [self.pickList removeObject:item];
        }else {
            if (self.maxCount > 0 && count >= self.maxCount) {
                return NO;
            }
            [self.pickList addObject:[self.imageList objectAtIndex:index]];
        }
        [self updatePickInfo];
        return YES;
    }
    return NO;
}

-(BOOL)isItemPickedUp:(id)item
{
    return [self.pickList containsObject:item];
}

//更新选中信息
-(void)updatePickInfo
{
    int count = (int)[self.pickList count];
    if (count > 0) {
        if (self.minCount > 0 && count < self.minCount) {
            [self.navigationItem setTitle:[NSString stringWithFormat:@"已选择 %i 个文件(最少%i个)", count, self.minCount]];
            [confirmButton setEnabled:NO];
        }else if (self.maxCount > 0) {
            if (count > self.maxCount) {
                [confirmButton setEnabled:NO];
            }else {
                [confirmButton setEnabled:YES];
            }
            [self.navigationItem setTitle:[NSString stringWithFormat:@"已选择 %i/%i 个文件", count, self.maxCount]];
        }else {
            [self.navigationItem setTitle:[NSString stringWithFormat:@"已选择 %i 个文件", count]];
            [confirmButton setEnabled:YES];
        }
    }else {
        [self.navigationItem setTitle:@"选择文件"];
        [confirmButton setEnabled:NO];
    }
}

#pragma mark-往期 collectionView delegate
//设置分区
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个分区上的元素个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.imageList count];
}
//设置元素大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((AL_DEVICE_WIDTH-40)/3, (AL_DEVICE_WIDTH-40)/3);
}

//设置元素内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"pickerCell";
    AssetPickerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    if (!cell) {
        cell = [[AssetPickerCell alloc] initWithFrame:CGRectMake(0, 0, (AL_DEVICE_WIDTH-40)/3, (AL_DEVICE_WIDTH-40)/3)];
    }
    XAAssetData *result = [self.imageList objectAtIndex:indexPath.row];
    [cell initWithAsset:result];
    [cell setIsPicked:[self isItemPickedUp:result]];
    return cell;
}

//点击元素触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self pickItemWithIndex:(int)indexPath.row]) {
        AssetPickerCell *cell = (AssetPickerCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [cell cellTaped];
    }
}


@end
