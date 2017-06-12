//
//  SecondTypeTableViewCell.m
//  milier
//
//  Created by amin on 2017/5/5.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "SecondTypeTableViewCell.h"

@implementation SecondTypeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configUI:(NSIndexPath *)indexPath{
    _TypeImageView  = [[UIImageView alloc]init];
    _TypeImageView.image = [UIImage imageNamed:@"wendingleixing"];
    [self.contentView addSubview:_TypeImageView];
    [_TypeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(16);
    }];
    _TypeLabel = [[UILabel alloc]init];
    _TypeLabel.text = @"稳健型";
    _TypeLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_TypeLabel];
    [_TypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_TypeImageView.mas_right).offset(5);
        make.centerY.mas_equalTo(_TypeImageView.mas_centerY);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(20);
    }];
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = colorWithRGB(0.83, 0.83, 0.83);
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(5);
        make.top.mas_equalTo(_TypeLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 10);
        make.height.mas_equalTo(0.5);
    }];
    _TypeDetailLabel = [[UILabel alloc]init];
    _TypeDetailLabel.text = @"中低风险，收益可观，适合稳健型投资者";
    _TypeDetailLabel.font = [UIFont systemFontOfSize:15];
    _TypeDetailLabel.textColor = colorWithRGB(0.83, 0.83, 0.83);
    [self.contentView addSubview:_TypeDetailLabel];
    [_TypeDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.top.mas_equalTo(lineView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 20);
        make.height.mas_equalTo(20);
    }];
    
    
    UIView *MyLineView = [[UIView alloc]init];
    MyLineView.backgroundColor = colorWithRGB(0.97, 0.97, 0.97);
    [self.contentView addSubview:MyLineView];
    [MyLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.top.mas_equalTo(_TypeDetailLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(5);
    }];
    
    _DaoQiTypeImageView  = [[UIImageView alloc]init];
    _DaoQiTypeImageView.image = [UIImage imageNamed:@"jixifangshi"];
    [self.contentView addSubview:_DaoQiTypeImageView];
    [_DaoQiTypeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(MyLineView.mas_bottom).offset(10);
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(16);
    }];
    _DaoQiTypeLabel = [[UILabel alloc]init];
    _DaoQiTypeLabel.text = @"到期还本付息";
    _DaoQiTypeLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_DaoQiTypeLabel];
    [_DaoQiTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_DaoQiTypeImageView.mas_right).offset(5);
        make.centerY.mas_equalTo(_DaoQiTypeImageView.mas_centerY);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    UIView *DaoQilineView = [[UIView alloc]init];
    DaoQilineView.backgroundColor = colorWithRGB(0.83, 0.83, 0.83);
    [self.contentView addSubview:DaoQilineView];
    [DaoQilineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(5);
        make.top.mas_equalTo(_DaoQiTypeLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 10);
        make.height.mas_equalTo(0.5);
    }];
    _DaoQiTypeDetailLabel = [[UILabel alloc]init];
    _DaoQiTypeDetailLabel.text = @"中低风险，收益可观，适合稳健型投资者";
    _DaoQiTypeDetailLabel.font = [UIFont systemFontOfSize:15];
    _DaoQiTypeDetailLabel.textColor = colorWithRGB(0.83, 0.83, 0.83);
    [self.contentView addSubview:_DaoQiTypeDetailLabel];
    [_DaoQiTypeDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.top.mas_equalTo(DaoQilineView.mas_bottom).offset(5);
        make.width.mas_equalTo(SCREEN_WIDTH - 20);
        make.height.mas_equalTo(20);
    }];
    UIView *daoqiLineView = [[UIView alloc]init];
    daoqiLineView.backgroundColor = colorWithRGB(0.97, 0.97, 0.97);
    [self.contentView addSubview:daoqiLineView];
    [daoqiLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.top.mas_equalTo(_DaoQiTypeDetailLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(5);
    }];
    
    _IsFullImageView  = [[UIImageView alloc]init];
    _IsFullImageView.image = [UIImage imageNamed:@"manbiaojl"];
    [self.contentView addSubview:_IsFullImageView];
    [_IsFullImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(daoqiLineView.mas_bottom).offset(10);
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(16);
    }];
    _IsFullLabel = [[UILabel alloc]init];
    _IsFullLabel.text = @"到期还本付息";
    _IsFullLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_IsFullLabel];
    [_IsFullLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_IsFullImageView.mas_right).offset(5);
        make.centerY.mas_equalTo(_IsFullImageView.mas_centerY);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    _IsFulllineView = [[UIView alloc]init];
    _IsFulllineView.backgroundColor = colorWithRGB(0.83, 0.83, 0.83);
    [self.contentView addSubview:_IsFulllineView];
    [_IsFulllineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(5);
        make.top.mas_equalTo(_IsFullLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 10);
        make.height.mas_equalTo(0.5);
    }];
    _IsFullDetailLabel = [[UILabel alloc]init];
    _IsFullDetailLabel.text = @"投资者全部买入该标的，可享受额外0.5%加息";
    _IsFullDetailLabel.font = [UIFont systemFontOfSize:15];
    _IsFullDetailLabel.textColor = colorWithRGB(0.83, 0.83, 0.83);
    [self.contentView addSubview:_IsFullDetailLabel];
    [_IsFullDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.top.mas_equalTo(_IsFulllineView.mas_bottom).offset(5);
        make.width.mas_equalTo(SCREEN_WIDTH - 20);
        make.height.mas_equalTo(20);
    }];

    
    _BottomLineView = [[UIView alloc]init];
    _BottomLineView.backgroundColor = colorWithRGB(0.97, 0.97, 0.97);
    [self.contentView addSubview:_BottomLineView];
    [_BottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.top.mas_equalTo(_IsFullDetailLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(5);
    }];
    
    
    

}

- (void)setDetailModel:(ProductDetailModel *)detailModel{
    if (detailModel != _detailModel) {
        _detailModel = detailModel;
        
        switch ([_detailModel.riskLevel integerValue]) {
            case 1:
                _TypeLabel.text = @"保守型";
                _TypeDetailLabel.text = @"收益适中 适合保守型投资者";
                break;
            case 2:
                _TypeLabel.text = @"稳健";
                _TypeDetailLabel.text = @"收益可观 适合稳健型投资者";
                break;
            case 3:
                _TypeLabel.text = @"积极型";
                _TypeDetailLabel.text = @"收益较高  适合积极型投资者";
                break;
            default:
                break;
        }
        
        
        switch ([_detailModel.modeOfRepayment integerValue]) {
            case 0:
                _DaoQiTypeLabel.text = @"买入即起息";
                _DaoQiTypeDetailLabel.text = @"购买成功即开始计算收益";
 
                break;
            case 1:
                _DaoQiTypeLabel.text = @"到期还本付息";
                _DaoQiTypeDetailLabel.text = @"项目到期后一次性支付本金及收益";

                break;
            case 2:
                _DaoQiTypeLabel.text = @"按月付息到期还本";
                _DaoQiTypeDetailLabel.text = @"每个月支付该阶段收益";

                break;
            case 3:
                _DaoQiTypeLabel.text = @"按季付息到期还本";
                _DaoQiTypeDetailLabel.text = @"每三个月支付该阶段收益";

                break;
            case 4:
                _DaoQiTypeLabel.text = @"按半年付息到期还本";
                _DaoQiTypeDetailLabel.text = @"每半年支付该阶段收益";

                break;
            case 5:
                _DaoQiTypeLabel.text = @"按年付息到期还本";
                _DaoQiTypeDetailLabel.text = @"每年月支付该阶段收益";
                
                break;
                
            default:
                break;
        }
       

    }
    if ([_detailModel.isFullScaleReward integerValue] == 1) {
        _IsFullDetailLabel.text = [NSString stringWithFormat:@"投资者全部买入该标的，可享受额外%@%%加息",_detailModel.fullScaleReward];

        
        
    }else{
        _IsFullImageView.hidden = YES;
        _IsFullLabel.hidden = YES;
        _IsFullDetailLabel.hidden = YES;
        _IsFulllineView.hidden= YES;
        _BottomLineView.hidden = YES;
    }
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
