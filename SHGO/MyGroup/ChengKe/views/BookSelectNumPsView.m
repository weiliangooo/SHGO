//
//  BookSelectNumPsView.m
//  SHGO
//
//  Created by 魏亮 on 2017/6/6.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "BookSelectNumPsView.h"
#import "AppDelegate.h"

@interface BookSelectNumPsView()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSArray *numArray;
    UIView *myView;
}
@property (nonatomic, strong)UIPickerView *pickerView;

@property (nonatomic, assign)NSInteger numPs;

@end

@implementation BookSelectNumPsView

-(UIPickerView *)pickerView{
    if (!_pickerView){
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 190*PROPORTION750, AL_DEVICE_WIDTH, 250*PROPORTION750)];
        _pickerView.backgroundColor= [UIColor clearColor];
        _pickerView.showsSelectionIndicator=YES;
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

-(instancetype)init
{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]){
        
        numArray = @[@"1",@"2",@"3",@"4"];
        
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
        titleLB.text = @"请选择乘坐人数（最多4人）";
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


-(void)buttonClickEvents:(UIButton *)button{
    [self dismissView];
    if (button.tag == 101) {
        self.bookNumPsBlock(self.numPs == 0 ? 1:self.numPs);
    }
}

#pragma 实现UIPickerViewDelegate的协议的方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

//返回的是每一列的个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return numArray.count;
}

#pragma 实现UIPickerViewDataSource的协议的方法

//如果选中某行，该执行的方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *string = numArray[row];
    _numPs = [string integerValue];
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 90*PROPORTION750;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    [self changeSpearatorLineColor];
    //设置文字的属性
    UILabel *genderLabel = [UILabel new];
    genderLabel.textAlignment = NSTextAlignmentCenter;
    genderLabel.text = numArray[row];
    return genderLabel;
}

#pragma mark - 改变分割线的颜色
- (void)changeSpearatorLineColor{
    for(UIView *speartorView in self.pickerView.subviews){
        if (speartorView.frame.size.height < 1){//取出分割线view
            speartorView.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];//隐藏分割线
        }
    }
}

-(void)dismissView{
    [self removeFromSuperview];
}

-(void)test{
    NSLog(@"hahah");
}


@end
