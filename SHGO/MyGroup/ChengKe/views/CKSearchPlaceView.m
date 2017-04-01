//
//  CKSearchPlaceView.m
//  SHGO
//
//  Created by Alen on 2017/3/23.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKSearchPlaceView.h"

@interface CKSearchPlaceView ()<UITableViewDelegate, UITableViewDataSource>
{
    UIView *line;
}

@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation CKSearchPlaceView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(UITableView *)myTableView
{
    if (!_myTableView)
    {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(20*PROPORTION750, 165*PROPORTION750, AL_DEVICE_WIDTH-40*PROPORTION750, AL_DEVICE_HEIGHT-165*PROPORTION750) style:UITableViewStyleGrouped];
        _myTableView.backgroundColor = [UIColor whiteColor];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        
    }
    return _myTableView;
}


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
        self.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.6];
        
        [self createNaviView];
        
        [self addSubview:self.myTableView];
    }
    return self;
}

-(void)createNaviView
{
    UIView *naviView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AL_DEVICE_WIDTH, 135*PROPORTION750)];
    naviView.backgroundColor = [UIColor whiteColor];
    [self addSubview:naviView];
    
    _cityTF = [[UITextField alloc] initWithFrame:CGRectMake(20*PROPORTION750, 70*PROPORTION750, 135*PROPORTION750, 35*PROPORTION750)];
    _cityTF.delegate = self;
    _cityTF.placeholder = @"到达城市";
    _cityTF.font = SYSF750(32);
    _cityTF.returnKeyType = UIReturnKeyDone;
    [naviView addSubview:_cityTF];
    
    line = [[UIView alloc] initWithFrame:CGRectMake(_cityTF.right+20*PROPORTION750, _cityTF.top, 2*PROPORTION750, 35*PROPORTION750)];
    line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [naviView addSubview:line];
    
    _placeTF = [[UITextField alloc] initWithFrame:CGRectMake(line.right+20*PROPORTION750, _cityTF.top, 425*PROPORTION750, 35*PROPORTION750)];
    _placeTF.delegate = self;
    _placeTF.placeholder = @"你要去哪儿";
    _placeTF.font = SYSF750(30);
    [_placeTF addTarget:self
                  action:@selector(textFieldDidChangeValue:)
        forControlEvents:UIControlEventEditingChanged];
    _placeTF.returnKeyType = UIReturnKeyDone;
    [naviView addSubview:_placeTF];
    
    UIButton *cancleBT = [[UIButton alloc] initWithFrame:CGRectMake(naviView.width-100*PROPORTION750, _cityTF.top, 70*PROPORTION750, 35*PROPORTION750)];
    [cancleBT setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBT setTitleColor:[UIColor colorWithHexString:@"#1aad1a"] forState:UIControlStateNormal];
    cancleBT.titleLabel.font = SYSF750(30);
    [cancleBT addTarget:self action:@selector(cancleBtnClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    [naviView addSubview:cancleBT];
    
}

-(void)cancleBtnClickEvent:(UIButton *)button
{
    [_cityTF resignFirstResponder];
    [_placeTF resignFirstResponder];
    
    if (_delegate && [_delegate respondsToSelector:@selector(CKSearchPlaceView:cancleBtnClick:)])
    {
        [_delegate CKSearchPlaceView:self cancleBtnClick:button];
    }
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _cityTF)
    {
        _typeOfData = 0;
        _dataArray = [NSMutableArray array];
        for (int i = 0; i < _defaultModel.citysModel.count; i++)
        {
            CKCitysModel *model = [[CKCitysModel alloc] init];
            model = [_defaultModel.citysModel objectAtIndex:i];
            [_dataArray addObject:model.cityName];
        }
        [self.myTableView reloadData];
    }
    else
    {
        _dataArray = [NSMutableArray array];
        if (_placeTF.text.length == 0)
        {
            _typeOfData = 1;
            for (int i = 0; i < _defaultModel.citysModel.count; i++)
            {
                
                CKCitysModel *model = [[CKCitysModel alloc] init ];
                model = [_defaultModel.citysModel objectAtIndex:i];
                if ([model.cityName hasPrefix:_cityTF.text])
                {
                    for (int j = 0; j < model.placeModel.count; j++)
                    {
                        CKHotPlaceModel *hotModel = [[CKHotPlaceModel alloc] init];
                        hotModel = [model.placeModel objectAtIndex:j];
                        myLocationModel *myModel = [[myLocationModel alloc] init];
                        myModel.city = model.cityName;
                        myModel.address = hotModel.place_name;
                        myModel.detailAddress = hotModel.place_address;
                        
                        NSArray *temp=[hotModel.local componentsSeparatedByString:@","];
                        
                        myModel.location = CLLocationCoordinate2DMake([[temp objectAtIndex:0] doubleValue], [[temp objectAtIndex:1] doubleValue]);
                        [_dataArray addObject:myModel];
                    }
                }
            }
            [self.myTableView reloadData];
        }
        else
        {
            _typeOfData = 2;
            if (_delegate && [_delegate respondsToSelector:@selector(CKSearchPlaceView:searchCity:keyWord:)])
            {
                [_delegate CKSearchPlaceView:self searchCity:_cityTF.text keyWord:_placeTF.text];
            }
        }
    }
    [self cotrolFrame];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _placeTF)
    {
        if (_cityTF.text.length == 0)
        {
            if (_delegate && [_delegate respondsToSelector:@selector(CKSearchPlaceView:toast:)])
            {
                [_delegate CKSearchPlaceView:self toast:@"请先填写城市"];
            }
            return NO;
        }
        
        if (_delegate && [_delegate respondsToSelector:@selector(CKSearchPlaceView:searchCity:keyWord:)])
        {
            [_delegate CKSearchPlaceView:self searchCity:_cityTF.text keyWord:_placeTF.text];
        }
        
    }
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self cotrolFrame];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_cityTF resignFirstResponder];
    [_placeTF resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _cityTF)
    {
        return NO;
    }
    return YES;
}

- (void)textFieldDidChangeValue:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(CKSearchPlaceView:searchCity:keyWord:)])
    {
        [_delegate CKSearchPlaceView:self searchCity:_cityTF.text keyWord:_placeTF.text];
    }
}


-(void)cotrolFrame
{
    if (_cityTF.isFirstResponder)
    {
        _cityTF.frame = CGRectMake(20*PROPORTION750, 70*PROPORTION750, 270*PROPORTION750, 35*PROPORTION750);
        line.frame = CGRectMake(_cityTF.right+20*PROPORTION750, _cityTF.top, 2*PROPORTION750, 35*PROPORTION750);
        _placeTF.frame = CGRectMake(line.right+20*PROPORTION750, _cityTF.top, 390*PROPORTION750, 35*PROPORTION750);

    }
    else
    {
        _cityTF.frame = CGRectMake(20*PROPORTION750, 70*PROPORTION750, 135*PROPORTION750, 35*PROPORTION750);
        line.frame = CGRectMake(_cityTF.right+20*PROPORTION750, _cityTF.top, 2*PROPORTION750, 35*PROPORTION750);
        _placeTF.frame = CGRectMake(line.right+20*PROPORTION750, _cityTF.top, 425*PROPORTION750, 35*PROPORTION750);
    }
    [self setNeedsLayout];
}

#pragma --mark uitableview 代理

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130*PROPORTION750;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.05;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.05;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.imageView.image = [UIImage imageNamed:@"ss"];
    if (_typeOfData == 0)
    {
        cell.textLabel.text = [_dataArray objectAtIndex:indexPath.row];
        
    }
    else if (_typeOfData == 1)
    {
        myLocationModel *model = [_dataArray objectAtIndex:indexPath.row];
        cell.textLabel.text = model.address;
        cell.detailTextLabel.text = model.detailAddress;
    }
    else if(_typeOfData == 2)
    {
        BMKPoiInfo *dic = [_dataArray objectAtIndex:indexPath.row];
        cell.textLabel.text = dic.name;
        cell.detailTextLabel.text = dic.address;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [_cityTF resignFirstResponder];
    [_placeTF resignFirstResponder];
    
//    BMKPoiInfo *dic = [_dataArray objectAtIndex:indexPath.row];
    if (_typeOfData == 0)
    {
        _cityTF.text = [_dataArray objectAtIndex:indexPath.row];
        [_cityTF resignFirstResponder];
        [_placeTF becomeFirstResponder];
    }
    else
    {
        if (_delegate && [_delegate respondsToSelector:@selector(CKSearchPlaceView:locationModel:)])
        {
            if (_typeOfData == 1)
            {
                myLocationModel *model = [_dataArray objectAtIndex:indexPath.row];
                
                _locationModel = [[myLocationModel alloc] init];
                _locationModel.city = model.city;
                _locationModel.address = model.address;
                _locationModel.detailAddress = model.detailAddress;
                _locationModel.location = model.location;
            }
            else if (_typeOfData == 2)
            {
                BMKPoiInfo *dic = [_dataArray objectAtIndex:indexPath.row];
                
                _locationModel = [[myLocationModel alloc] init];
                _locationModel.city = _cityTF.text;
                _locationModel.address = dic.name;
                _locationModel.detailAddress = dic.address;
                _locationModel.location = dic.pt;
            }
            
            
            if ([_cityTF.placeholder isEqualToString:@"出发城市"])
            {
                _locationModel.isStart = YES;
                [_delegate CKSearchPlaceView:self locationModel:_locationModel];
            }
            else
            {
                _locationModel.isStart = NO;
                [_delegate CKSearchPlaceView:self locationModel:_locationModel];
            }
        }
    }
    
}

-(void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
    _typeOfData = 2;
    if (_dataArray.count == 0)
    {
        if (_cityTF.text.length == 0)
        {
            _typeOfData = 0;
            [_cityTF becomeFirstResponder];
            _dataArray = [NSMutableArray array];
            for (int i = 0; i < _defaultModel.citysModel.count; i++)
            {
                CKCitysModel *model = [[CKCitysModel alloc] init];
                model = [_defaultModel.citysModel objectAtIndex:i];
                [_dataArray addObject:model.cityName];
            }
            [self.myTableView reloadData];
        }
        else
        {
            _typeOfData = 1;
            [_placeTF becomeFirstResponder];
            _dataArray = [NSMutableArray array];
            if (_placeTF.text.length == 0)
            {
                for (int i = 0; i < _defaultModel.citysModel.count; i++)
                {
                    CKCitysModel *model = [[CKCitysModel alloc] init ];
                    model = [_defaultModel.citysModel objectAtIndex:i];
                    if ([model.cityName hasPrefix:_cityTF.text])
                    {
                        for (int j = 0; j < model.placeModel.count; j++)
                        {
                            CKHotPlaceModel *hotModel = [[CKHotPlaceModel alloc] init];
                            hotModel = [model.placeModel objectAtIndex:j];
                            myLocationModel *myModel = [[myLocationModel alloc] init];
                            myModel.city = model.cityName;
                            myModel.address = hotModel.place_name;
                            myModel.detailAddress = hotModel.place_address;
                            
                            NSArray *temp=[hotModel.local componentsSeparatedByString:@","];
                            
                            myModel.location = CLLocationCoordinate2DMake([[temp objectAtIndex:0] doubleValue], [[temp objectAtIndex:1] doubleValue]);
                            [_dataArray addObject:myModel];
                        }
                    }
                }
            }
        }
    }
    [self.myTableView reloadData];
}


@end


@implementation myLocationModel



@end
