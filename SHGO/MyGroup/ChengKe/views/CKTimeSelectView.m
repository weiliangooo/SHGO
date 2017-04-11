//
//  CKTimeSelectView.m
//  SHGO
//
//  Created by Alen on 2017/3/24.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKTimeSelectView.h"
#import "AppDelegate.h"


@interface CKTimeSelectView ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSMutableArray *timeArray;
    
    UIView *myView;
}

@property (nonatomic, strong)UIPickerView *pickerView;

@property (nonatomic, strong) NSString *dateStr;

@property (nonatomic, strong) NSString *timeStr;

@end

@implementation CKTimeSelectView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(UIPickerView *)pickerView
{
    if (!_pickerView)
    {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 190*PROPORTION750, AL_DEVICE_WIDTH, 250*PROPORTION750)];
        _pickerView.backgroundColor= [UIColor clearColor];
        _pickerView.showsSelectionIndicator=YES;
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}


-(instancetype)initWithData:(NSMutableArray *)array
{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds])
    {
        [self setDataArray:array];
        
        AppDelegate *de = (AppDelegate *)[UIApplication sharedApplication].delegate;
        self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.8];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissView)]];
        [de.window addSubview:self];
        
        myView = [[UIView alloc] initWithFrame:CGRectMake(0, AL_DEVICE_HEIGHT-510*PROPORTION750, AL_DEVICE_WIDTH, 510*PROPORTION750)];
        myView.backgroundColor = [UIColor whiteColor];
        myView.userInteractionEnabled = YES;
        [myView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(test)]];
        [self addSubview:myView];
        
        UIButton *cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(30*PROPORTION750, 45*PROPORTION750, 65*PROPORTION750, 30*PROPORTION750)];
        [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancleBtn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
        cancleBtn.titleLabel.font = SYSF750(30);
        cancleBtn.tag = 100;
        [cancleBtn addTarget:self action:@selector(buttonClickEvents:) forControlEvents:UIControlEventTouchUpInside];
        [myView addSubview:cancleBtn];
        
        UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(self.width/2-225*PROPORTION750, 45*PROPORTION750, 450*PROPORTION750, 25*PROPORTION750)];
        titleLB.text = @"建议提前一天预约";
        titleLB.font = SYSF750(25);
        titleLB.textAlignment = NSTextAlignmentCenter;
        [myView addSubview:titleLB];
        
        
        UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(AL_DEVICE_WIDTH-95*PROPORTION750, 45*PROPORTION750, 65*PROPORTION750, 30*PROPORTION750)];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sureBtn setTitleColor:[UIColor colorWithHexString:@"#1aaf1a"] forState:UIControlStateNormal];
        sureBtn.titleLabel.font = SYSF750(30);
        sureBtn.tag = 101;
        [sureBtn addTarget:self action:@selector(buttonClickEvents:) forControlEvents:UIControlEventTouchUpInside];
        [myView addSubview:sureBtn];
        
        [myView addSubview:self.pickerView];
        
    }
    return self;
}


-(void)buttonClickEvents:(UIButton *)button
{
    [self dismissView];
    self.CKTimeSelectBlock(button.tag == 100);
}

-(void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
    timeArray = [NSMutableArray arrayWithArray:[[_dataArray objectAtIndex:0] arrayForKey:@"runs"]];
}


#pragma 实现UIPickerViewDelegate的协议的方法

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

//返回的是每一列的个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    //如果是第一列，就是显示首字母的那一列，返回的是存放首字母数组的个数
    if (component == 0)
    {
        return _dataArray.count;
    }
    else//如果是第二列，就是显示城市的那一列，返回的是存放城市的数组的个数
    {
        return timeArray.count;
    }
}

#pragma 实现UIPickerViewDataSource的协议的方法
//返回的是component列的行显示的内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0)//如果是首字母的那一列
    {
        //row表示你已经选中第几行了，当然是从0开始的
        return [[_dataArray objectAtIndex:row] stringForKey:@"date"];
    }
    else//如果选择的是城市那一列
    {
        //返回的是城市那一列的第row的那一行的显示的内容
        return [[timeArray objectAtIndex:row] stringForKey:@"start_time"];
    }
}

//如果选中某行，该执行的方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //如果首字母那一列被选中
    if (component == 0)
    {
        _dateStr = [[_dataArray objectAtIndex:row] stringForKey:@"date"];
        _timeStr = @"";
        timeArray = [[_dataArray objectAtIndex:row] arrayForKey:@"runs"];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView reloadComponent:1];
    }
    else
    {
        [[timeArray objectAtIndex:row] stringForKey:@"start_time"];
    }
}

-(void)dismissView
{
    [self removeFromSuperview];
}

-(void)test
{
    NSLog(@"hahah");
}

@end
