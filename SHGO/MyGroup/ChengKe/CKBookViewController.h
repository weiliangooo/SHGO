//
//  CKBookViewController.h
//  SHGO
//
//  Created by Alen on 2017/3/27.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKMapViewController.h"


@interface CKBookViewController : CKMapViewController

///从上个界面带过来的数据
@property (nonatomic, strong) NSDictionary *inputData;

///出发点的坐标
@property (nonatomic, strong) NSString *startLocal;

///到达地的坐标
@property (nonatomic, strong) NSString *endLocal;


@end
