//
//  XAAssetPickerController.m
//  taiben_ipad
//
//  Created by lbf on 14-8-22.
//  Copyright (c) 2014年 xun-ao. All rights reserved.
//

#import "XAAssetPickerController.h"

@interface XAAssetPickerController ()

@property (nonatomic) AssetsGroupController *groupController;

@end

@implementation XAAssetPickerController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

+(XAAssetPickerController *)pickerWithPickType:(AssetsPickType)tye Completion:(void (^)(NSArray *))pickup
{
    AssetsGroupController *vc = [[AssetsGroupController alloc] init];
    [vc setPicktype:tye];
    [vc setAssetPicked:pickup];
    [vc setMaxCount:0];
    [vc setMinCount:0];
    XAAssetPickerController *picker = [[XAAssetPickerController alloc] initWithRootViewController:vc];
    return picker;
}

-(id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.groupController = (AssetsGroupController *)rootViewController;
    }
    return self;
}

-(void)setMaxCount:(int)maxCount
{
    _maxCount = maxCount;
    [self.groupController setMaxCount:_maxCount];
}

-(void)setMinCount:(int)minCount
{
    _minCount = minCount;
    [self.groupController setMinCount:_minCount];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
