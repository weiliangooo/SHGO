//
//  AssetsGroupController.m
//  taiben_ipad
//
//  Created by lbf on 14-8-20.
//  Copyright (c) 2014年 xun-ao. All rights reserved.
//

#import "AssetsGroupController.h"
#import "AssetGroupCell.h"

@interface AssetsGroupController ()

@end

@implementation AssetsGroupController

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
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self loadAllAssetGroups];
    
	[self.navigationItem setTitle:@"相簿"];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(close)];
	[self.navigationItem setLeftBarButtonItem:cancelButton];
    
    [self.view addSubview:self.tableView];
}

-(ALAssetsLibrary *)assetsLibrary
{
    static ALAssetsLibrary *_library = nil;
    if (_library == nil) {
        _library = [[ALAssetsLibrary alloc] init];
    }
    return _library;
}

-(NSMutableArray *)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-20)];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
    }
    return _tableView;
}

-(void)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadAllAssetGroups
{
    // Load Albums into assetGroups
    dispatch_async(dispatch_get_main_queue(), ^{
        @autoreleasepool {
            // 遍历相册
            [self.assetsLibrary
             enumerateGroupsWithTypes:ALAssetsGroupAll
             usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                 if (group == nil) {
                     return;
                 }
                 [group setAssetsFilter:[self assetFilter]];
                 if ([group numberOfAssets] > 0) {//空的相册不显示
                     // added fix for camera albums order
                     NSString *sGroupPropertyName = (NSString *)[group valueForProperty:ALAssetsGroupPropertyName];
                     NSUInteger nType = [[group valueForProperty:ALAssetsGroupPropertyType] intValue];
                     if (([[sGroupPropertyName lowercaseString] isEqualToString:@"camera roll"] || [sGroupPropertyName isEqualToString:@"相机胶卷"]) && nType == ALAssetsGroupSavedPhotos) {
                         [self.groups insertObject:group atIndex:0];
                     }
                     else {
                         [self.groups addObject:group];
                     }
                     
                     // Reload albums
                     [self performSelectorOnMainThread:@selector(reloadTableView) withObject:nil waitUntilDone:YES];
                 }
             } failureBlock:^(NSError *error) {
                     UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"打开相册失败"
                                                                    message:@"请打开 设置-隐私-照片 来进行设置"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil, nil];
                     [alert show];
                 
//                 NSString *message = [NSString stringWithFormat:@"读取相册错误: %@ - %@", [error localizedDescription], [error localizedRecoverySuggestion]];
//                 [self allertMessage:message];
             }];
            
        }
    });
}

- (void)allertMessage:(NSString *)message
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"云西游" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}

- (ALAssetsFilter *)assetFilter
{
    switch (self.picktype) {
        case AssetsPickTypeImage:
            return [ALAssetsFilter allPhotos];
        case AssetsPickTypeVideo:
            return [ALAssetsFilter allVideos];
        default:
            return [ALAssetsFilter allAssets];
    }
}

-(void)reloadTableView
{
	[self.tableView reloadData];
}

#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.groups count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    AssetGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[AssetGroupCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setFrame:CGRectMake(0, 0, tableView.frame.size.width, 120)];
        [cell initGroupCell];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    // Get count
    ALAssetsGroup *g = (ALAssetsGroup*)[self.groups objectAtIndex:indexPath.row];
    [g setAssetsFilter:[self assetFilter]];
    NSInteger gCount = [g numberOfAssets];
    
    UIImage *poster = [UIImage imageWithCGImage:[g posterImage]];
    NSString *title = [NSString stringWithFormat:@"%@ (%ld)",[g valueForProperty:ALAssetsGroupPropertyName], (long)gCount];

    [cell setImage:poster];
    [cell setTitle:title];
	
    return cell;
}

#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AssetPickerController *picker = [[AssetPickerController alloc] init];
    [picker setAssetGroup:[self.groups objectAtIndex:indexPath.row]];
    [picker.assetGroup setAssetsFilter:[self assetFilter]];
    [picker setAssetPicked:self.assetPicked];
    [picker setMaxCount:self.maxCount];
    [picker setMinCount:self.minCount];
    [self.navigationController pushViewController:picker animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 120;
}

@end
