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
        _NameLabel.font = [UIFont systemFontOfSize:14];
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
        make.height.mas_equalTo(35);
    }];
    _NameDetailLabel = [[UILabel alloc]init];
    _NameDetailLabel.text = @"2016:23:30";
    _NameDetailLabel.numberOfLines = 0;
    _NameDetailLabel.font = [UIFont systemFontOfSize:14];
    [_SecondBageView addSubview:_NameDetailLabel];
    [_NameDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_SecondBageView.mas_left).offset(10);
        make.top.mas_equalTo(_NameLabel.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH-40);
        make.height.mas_equalTo(35);
    }];
    

    _ThirdBageView = [[UIView alloc]init];
    _ThirdBageView.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
    [self addSubview:_ThirdBageView];
    [_ThirdBageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.top.mas_equalTo(_SecondBageView.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH - 20);
        make.height.mas_equalTo(15);
    }];
    
        _MyJiFenLabel = [[UILabel alloc]init];
        _MyJiFenLabel.text= @"232232";
        _MyJiFenLabel.font = [UIFont systemFontOfSize:14];
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


    UIImageView *image = [[UIImageView alloc]init];
    image.image = [UIImage imageNamed:@""];
    [self addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(18);
    }];

    _bottomView = [[UIView alloc]init];
    _bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom);
        make.left.mas_equalTo(self.mas_left);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(10);
    }];
    
    
}

- (void)setDuiHuanModel:(DuiHuanModel *)DuiHuanModel{
    if (DuiHuanModel != _DuiHuanModel) {
        _DuiHuanModel = DuiHuanModel;
//        if ([_DuiHuanModel.commodityType integerValue] == 1) {
//            _NameLabel.text =[NSString stringWithFormat:@"%@",_DuiHuanModel.commodityDesc];
//        }else{
//            _NameLabel.text =[NSString stringWithFormat:@"%@(%@)",_DuiHuanModel.person,_DuiHuanModel.phoneNumber];
//            _NameDetailLabel.text = [NSString stringWithFormat:@"%@",_DuiHuanModel.address];
//            _MyJiFenLabel.text=[NSString stringWithFormat:@"%@(%@)",_DuiHuanModel.logisticsName,_DuiHuanModel.logisticsNumber];
//
//        }
        _NameLabel.text =@"";
        _NameDetailLabel.text =@"";
        _MyJiFenLabel.text=@"";
        NSLog(@" === %@",_DuiHuanModel.commodityDescArray);
        switch ([_DuiHuanModel.commodityDescArray integerValue]) {
            case 1:
                _NameLabel.text =[NSString stringWithFormat:@"%@",_DuiHuanModel.commodityDesc];
 
                break;
            case 2:
                _NameLabel.text =[NSString stringWithFormat:@"%@(%@)",_DuiHuanModel.person,_DuiHuanModel.phoneNumber];
                _NameDetailLabel.text = [NSString stringWithFormat:@"地址：%@",_DuiHuanModel.address];

                break;
            case 3:
                _NameLabel.text =[NSString stringWithFormat:@"%@(%@)",_DuiHuanModel.person,_DuiHuanModel.phoneNumber];
                _NameDetailLabel.text = [NSString stringWithFormat:@"%@",_DuiHuanModel.address];
                _MyJiFenLabel.text=[NSString stringWithFormat:@"%@(单号：%@)",_DuiHuanModel.logisticsName,_DuiHuanModel.logisticsNumber];

                break;
            default:
                _NameLabel.text =@"";
                _NameDetailLabel.text =@"";
                _MyJiFenLabel.text=@"";
                break;
        }
       
    }
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object{
    CGFloat statuesHeight =  32 *[object integerValue];
    return statuesHeight;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
