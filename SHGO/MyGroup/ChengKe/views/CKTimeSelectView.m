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
    NSArray *timeArray;
    
    UIView *myView;
}
///班次选择器
@property (nonatomic, strong)UIPickerView *pickerView;
///存储当前选中班次的日期
@property (nonatomic, strong) NSString *dateStr;
///存储当前选中班次的时间
@property (nonatomic, strong) NSString *timeStr;
///存储当前选中的班次id
@property (nonatomic, strong) NSString *timeId;

@end

@implementation CKTimeSelectView

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

-(instancetype)initWithData:(NSMutableArray *)array
{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]){
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


-(void)buttonClickEvents:(UIButton *)button{
    [self dismissView];
    if ([_timeStr isEqualToString:@"无可乘班次"]){
        return;
    }
    NSString *timeSting = [_dateStr stringByAppendingString:@" 00:00:00"];
    self.CKTimeSelectBlock(button.tag == 100, timeSting, _timeId);
}

-(void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
    if ([[_dataArray objectAtIndex:0] arrayForKey:@"runs"].count == 0) {
        [_dataArray removeObjectAtIndex:0];
    }
    timeArray = [NSMutableArray arrayWithArray:[[_dataArray objectAtIndex:0] arrayForKey:@"runs"]];
}

#pragma 实现UIPickerViewDelegate的协议的方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

//返回的是每一列的个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0){
        return _dataArray.count;
    }
    else{
        return timeArray.count;
    }
}

#pragma 实现UIPickerViewDataSource的协议的方法
//返回的是component列的行显示的内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0){
        //row表示你已经选中第几行了，当然是从0开始的
        _dateStr = [[_dataArray objectAtIndex:row] stringForKey:@"date"];
        return [[_dataArray objectAtIndex:row] stringForKey:@"date"];
    }else{
        NSDictionary *dic = [timeArray objectAtIndex:row];
        if (dic != nil) {
            _timeStr = [dic stringForKey:@"start_time"];
            _timeId = [dic stringForKey:@"id"];
            return [dic stringForKey:@"start_time"];
        }
        return @"无可乘班次";
    }
}

//如果选中某行，该执行的方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0){
        timeArray = [[_dataArray objectAtIndex:row] arrayForKey:@"runs"];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView reloadComponent:1];
    }else{
        if (timeArray.count == 0) {
            return;
        }
        [[timeArray objectAtIndex:row] stringForKey:@"start_time"];
    }
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 90*PROPORTION750;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{

    [self changeSpearatorLineColor];
    //设置文字的属性
    UILabel *genderLabel = [UILabel new];
    genderLabel.textAlignment = NSTextAlignmentCenter;
    
    if (component == 0){
        //row表示你已经选中第几行了，当然是从0开始的
        _dateStr = [[_dataArray objectAtIndex:row] stringForKey:@"date"];
        genderLabel.text = [[_dataArray objectAtIndex:row] stringForKey:@"date"];
    }else{
        NSDictionary *dic = [timeArray objectAtIndex:row];
        _timeStr = [dic stringForKey:@"start_time"];
        _timeId = [dic stringForKey:@"id"];
        genderLabel.text = [dic stringForKey:@"start_time"];
        
    }
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
