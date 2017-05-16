//
//  PGSLeadViewController.m
//  SHGO
//
//  Created by Alen on 2017/3/31.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "PGSLeadViewController.h"

#import "CKLoginViewController.h"

#import "BaseNavViewController.h"

@interface PGSLeadViewController ()


@property (nonatomic, strong) UIScrollView *myScrollView;

@end

@implementation PGSLeadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *pics = @[@"guide_one", @"guide_two", @"guide_three"];
    
    _myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT)];
    _myScrollView.backgroundColor = [UIColor whiteColor];
    _myScrollView.showsHorizontalScrollIndicator = NO;
    _myScrollView.showsVerticalScrollIndicator = NO;
    _myScrollView.contentSize = CGSizeMake(AL_DEVICE_WIDTH*pics.count, 0);
    _myScrollView.pagingEnabled = YES;
    [self.view addSubview:_myScrollView];
    
    for (int i = 0 ; i < pics.count; i++){
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(AL_DEVICE_WIDTH*i, 0, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT)];
        imageView.image = [UIImage imageNamed:pics[i]];
        [_myScrollView addSubview:imageView];
        
        if (i == 2){
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToLoginInterface:)]];
        }
    }
    
}

-(void)goToLoginInterface:(UITapGestureRecognizer *)tap{
    CKLoginViewController *viewController = [[CKLoginViewController alloc] init];
    BaseNavViewController *navigationController = [[BaseNavViewController alloc] initWithRootViewController:viewController];
    [self presentViewController:navigationController animated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
