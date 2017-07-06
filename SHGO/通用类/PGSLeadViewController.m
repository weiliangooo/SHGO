//
//  PGSLeadViewController.m
//  SHGO
//
//  Created by Alen on 2017/3/31.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "PGSLeadViewController.h"

#import <CoreLocation/CLLocationManager.h>

#import "LoginViewController.h"
#import "BaseNavViewController.h"
#import "AppDelegate.h"

@interface PGSLeadViewController ()<UIScrollViewDelegate,CLLocationManagerDelegate>

@property (nonatomic, strong) UIScrollView *myScrollView;
@property (nonatomic, strong) CLLocationManager *locManager;

@end

@implementation PGSLeadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *pics = @[@"guide_one", @"guide_two", @"guide_three"];
    
    _myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT)];
    _myScrollView.backgroundColor = [UIColor clearColor];
    _myScrollView.showsHorizontalScrollIndicator = NO;
    _myScrollView.showsVerticalScrollIndicator = NO;
    _myScrollView.contentSize = CGSizeMake(AL_DEVICE_WIDTH*pics.count, 0);
    _myScrollView.pagingEnabled = YES;
    _myScrollView.delegate = self;
    [self.view addSubview:_myScrollView];
    
    for (int i = 0 ; i < pics.count; i++){
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(AL_DEVICE_WIDTH*i, 0, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT)];
        imageView.image = [UIImage imageNamed:pics[i]];
        [_myScrollView addSubview:imageView];
        
        if (i == 2){
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoLoginViewController)]];
        }
    }

    _locManager = [[CLLocationManager alloc] init];
    _locManager.delegate = self;
    [_locManager requestWhenInUseAuthorization];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x > AL_DEVICE_WIDTH*2+200*PROPORTION750) {
        [self gotoLoginViewController];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
