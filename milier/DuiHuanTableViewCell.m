//
//  DuiHuanTableViewCell.m
//  milier
//
//  Created by amin on 17/5/3.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "DuiHuanTableViewCell.h"

@implementation DuiHuanTableViewCell


- (void)configUI:(NSIndexPath *)indexPath{

    
    _BageView = [[UIView alloc]init];
    _BageView.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
    [self.contentView addSubview:_BageView];
    [_BageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.top.mas_equalTo(self.contentView.mas_top).offset(6);
        make.width.mas_equalTo(SCREEN_WIDTH - 20);
        make.height.mas_equalTo(25);
    }];
        _NameLabel = [[UILabel alloc]init];
        _NameLabel.text =@"苏泊尔双层电动锅";
        _NameLabel.textAlignment = NSTextAlignmentLeft;
        _NameLabel.textColor = [UIColor blackColor];
        _NameLabel.font = [UIFont systemFontOfSize:10];
        [_BageView addSubview:_NameLabel];
        [_NameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_BageView.mas_left).offset(10);
            make.top.mas_equalTo(_BageView.mas_top);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(20);
        }];
    
    _SecondBageView = [[UIView alloc]init];
    _SecondBageView.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
    [self addSubview:_SecondBageView];
    [_SecondBageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.top.mas_equalTo(_BageView.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH - 20);
        make.height.mas_equalTo(25);
    }];
    _NameDetailLabel = [[UILabel alloc]init];
    _NameDetailLabel.text = @"2016:23:30";
    _NameDetailLabel.font = [UIFont systemFontOfSize:10];
    [_SecondBageView addSubview:_NameDetailLabel];
    [_NameDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_SecondBageView.mas_left).offset(10);
        make.top.mas_equalTo(_NameLabel.mas_bottom);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
    

    _ThirdBageView = [[UIView alloc]init];
    _ThirdBageView.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
    [self addSubview:_ThirdBageView];
    [_ThirdBageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.top.mas_equalTo(_SecondBageView.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH - 20);
        make.height.mas_equalTo(25);
    }];
    
        _MyJiFenLabel = [[UILabel alloc]init];
        _MyJiFenLabel.text= @"232232";
        _MyJiFenLabel.font = [UIFont systemFontOfSize:10];
        [_ThirdBageView addSubview:_MyJiFenLabel];
        [_MyJiFenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_ThirdBageView.mas_left).offset(10);
            make.top.mas_equalTo(_NameDetailLabel.mas_bottom);
            make.width.mas_equalTo(SCREEN_WIDTH - 20);
            make.height.mas_equalTo(20);
        }];
    

    
    _StaticImageView = [[UIImageView alloc]init];
    _StaticImageView.image = [UIImage imageNamed:@"smallarrow"];
    [self addSubview:_StaticImageView];
    [_StaticImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_BageView.mas_left).offset(20);
        make.bottom.mas_equalTo(_BageView.mas_top);
        make.width.mas_equalTo(11);
        make.height.mas_equalTo(6);
    }];




    
    
    
}

- (void)setDuiHuanModel:(DuiHuanModel *)DuiHuanModel{
    if (DuiHuanModel != _DuiHuanModel) {
        _DuiHuanModel = DuiHuanModel;
        if ([_DuiHuanModel.commodityType integerValue] == 1) {
            _NameLabel.text =[NSString stringWithFormat:@"%@",_DuiHuanModel.commodityDesc];
        }else{
            _NameLabel.text =[NSString stringWithFormat:@"%@(%@)",_DuiHuanModel.person,_DuiHuanModel.phoneNumber];
            _NameDetailLabel.text = [NSString stringWithFormat:@"%@",_DuiHuanModel.address];
            _MyJiFenLabel.text=[NSString stringWithFormat:@"%@",_DuiHuanModel.logisticsName];


        }
        
        
        
    }
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object{
    CGFloat statuesHeight =  25 *[object integerValue];
    return statuesHeight;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
