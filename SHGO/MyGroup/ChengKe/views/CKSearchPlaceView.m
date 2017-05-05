//
//  CKSearchPlaceView.m
//  SHGO
//
//  Created by Alen on 2017/3/23.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKSearchPlaceView.h"
#import "CKCitysListModel.h"
#import "PlaceModel.h"

@interface CKSearchPlaceView ()<UITableViewDelegate, UITableViewDataSource>
{
    UIView *line;
}

@property (nonatomic, strong) UITableView *myTableView;
///本地数据库的搜索历史数据
@property (nonatomic, strong) NSMutableArray<PlaceModel *> *dbDataSoure;
///当前要展示本地数据库的搜索历史数据
@property (nonatomic, strong) NSMutableArray<PlaceModel *> *dbShowDataSoure;

@end

@implementation CKSearchPlaceView

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
    _placeTF.placeholder = @"您要去哪儿";
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

#pragma --mark textField Delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _cityTF)
    {
        [self setTypeOfData:DataSourceTypeCity dataSource:nil];
    }
    else
    {
        if (_placeTF.text.length == 0)
        {
            [self setTypeOfData:DataSourceTypeHot dataSource:nil];
        }
        else
        {
            _typeOfData = DataSourceTypeBaidu;
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
    if (_placeTF.isFirstResponder && _placeTF.text.length == 0) {
        [self setTypeOfData:DataSourceTypeHot dataSource:nil];
    }else{
        if (_delegate && [_delegate respondsToSelector:@selector(CKSearchPlaceView:searchCity:keyWord:)])
        {
            [_delegate CKSearchPlaceView:self searchCity:_cityTF.text keyWord:_placeTF.text];
        }
    }
}

///修改navi 内部控件frame
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
    if (_typeOfData == DataSourceTypeCity)
    {
        cell.textLabel.text = [_dataArray objectAtIndex:indexPath.row];
        cell.imageView.image = nil;
    }
    else if (_typeOfData == DataSourceTypeHot || _typeOfData == DataSourceTypeBaidu)
    {
        if (_typeOfData == DataSourceTypeHot)
        {
            if (indexPath.row < _dbShowDataSoure.count)
            {
                cell.imageView.image = [UIImage imageNamed:@"p_history"];
            }
            else
            {
                cell.imageView.image = [UIImage imageNamed:@"p_hot"];
            }
        }
        else
        {
            cell.imageView.image = [UIImage imageNamed:@"p_search"];
        }
        PlaceModel *model = [_dataArray objectAtIndex:indexPath.row];
        cell.textLabel.text = model.address;
        cell.detailTextLabel.text = model.detailAddress;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [_cityTF resignFirstResponder];
    [_placeTF resignFirstResponder];
    
    if (_typeOfData == 0)
    {
        _cityTF.text = [_dataArray objectAtIndex:indexPath.row];
        [_cityTF resignFirstResponder];
        [_placeTF becomeFirstResponder];
        [self setTypeOfData:1 dataSource:nil];
    }
    else if(_typeOfData == DataSourceTypeHot || _typeOfData == DataSourceTypeBaidu)
    {
        PlaceModel *backModel = [[PlaceModel alloc] init];
        backModel = [_dataArray objectAtIndex:indexPath.row];
        if (_typeOfData == DataSourceTypeBaidu) {
            [self.dbDataSoure addObject:backModel];
            [[DBMake shareInstance] upDatePlace:[self.dbDataSoure mutableCopy]];
        }
        if (_delegate && [_delegate respondsToSelector:@selector(CKSearchPlaceView:locationModel:)])
        {
            [_delegate CKSearchPlaceView:self locationModel:backModel];
        }
    }
    
}


-(void)setDataArray:(NSMutableArray *)dataArray
{
    if (dataArray.count == 0)
    {
        if (_cityTF.text.length == 0)
        {
            [self setTypeOfData:DataSourceTypeCity dataSource:nil];
        }
        else
        {
            [self setTypeOfData:DataSourceTypeHot dataSource:nil];
        }
    }
    else
    {
        [self setTypeOfData:DataSourceTypeBaidu dataSource:dataArray];
    }
}

-(void)setTypeOfData:(DataSourceType)typeOfData dataSource:(NSMutableArray *)dataSource
{
    _typeOfData = typeOfData;
    _dataArray = [NSMutableArray array];
    if (typeOfData == DataSourceTypeCity)
    {
        [_cityTF becomeFirstResponder];
        for (int i = 0; i < _defaultModel.citysModel.count; i++)
        {
            CKCitysModel *model = [[CKCitysModel alloc] init];
            model = [_defaultModel.citysModel objectAtIndex:i];
            [_dataArray addObject:model.cityName];
        }
        [self.myTableView reloadData];
    }
    else if (typeOfData == DataSourceTypeHot)
    {
        [_placeTF becomeFirstResponder];
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
                        
                        PlaceModel *myModel = [[PlaceModel alloc] init];
                        myModel.cityName = model.cityName;
                        myModel.address = hotModel.place_name;
                        myModel.detailAddress = hotModel.place_address;
                        myModel.location = [MyHelperTool locationStringToLocationCoordinate:hotModel.local];
                        [_dataArray addObject:myModel];
                    }
                }
            }
            _dbDataSoure = [NSMutableArray arrayWithArray:[[DBMake shareInstance] getPlaceHistory]];
            _dbShowDataSoure = [NSMutableArray array];
            for (PlaceModel *model in _dbDataSoure)
            {
                if ([model.cityName isEqualToString:_cityTF.text])
                {
                    [_dbShowDataSoure addObject:model];
                }
            }
            [_dataArray insertObjects:_dbShowDataSoure atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, _dbShowDataSoure.count)]];
        }

    }
    else if (typeOfData == DataSourceTypeBaidu)
    {
        [_placeTF becomeFirstResponder];
        for (int i = 0; i<dataSource.count; i++)
        {
            BMKPoiInfo *dic = [dataSource objectAtIndex:i];
            PlaceModel *backModel = [[PlaceModel alloc] init];
            backModel.cityName = _cityTF.text;
            backModel.address = dic.name;
            backModel.detailAddress = dic.address;
            backModel.location = dic.pt;
            [_dataArray addObject:backModel];
        }
    }
    [self.myTableView reloadData];
}



@end

