//
//  StageTableViewCell.m
//  milier
//
//  Created by amin on 17/4/25.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "StageTableViewCell.h"

@implementation StageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configUI:(NSIndexPath *)indexPath{
    _TypeImageView = [[UIImageView alloc]init];
    _TypeImageView.image = [UIImage imageNamed:@"qiye_xmq_01"];
    [self addSubview:_TypeImageView];
    [_TypeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.width.mas_equalTo(64);
        make.height.mas_equalTo(123);
    }];
    
    
   

    _TitleStateLable = [[UILabel alloc]init];
    _TitleStateLable.numberOfLines = 0;
    _TitleStateLable.text = @"随机小米卷";
    _TitleStateLable.textAlignment = NSTextAlignmentCenter;
    _TitleStateLable.font = [UIFont systemFontOfSize:16];
    _TitleStateLable.textColor = [UIColor whiteColor];
    [_TypeImageView addSubview:_TitleStateLable];
    [_TitleStateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_TypeImageView.mas_right).offset(-12);
        make.top.mas_equalTo(_TypeImageView.mas_top);
        make.width.mas_equalTo(20);
        make.bottom.mas_equalTo(_TypeImageView.mas_bottom);
    }];
    

    _RightImageView = [[UIImageView alloc]init];
    _RightImageView.image = [UIImage imageNamed:@"tese_xmq_03"];
    [self addSubview:_RightImageView];
    [_RightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.width.mas_equalTo(105);
        make.height.mas_equalTo(123);
    }];
    UIImageView *MiddleImageView = [[UIImageView alloc]init];
    MiddleImageView.image = [UIImage imageNamed:@"quan_content"];
    [self addSubview:MiddleImageView];
    [MiddleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_TypeImageView.mas_right);
        make.right.mas_equalTo(_RightImageView.mas_left);
        make.top.mas_equalTo(_RightImageView.mas_top);
        make.bottom.mas_equalTo(_RightImageView.mas_bottom);
    }];
    _TitleLable = [[UILabel alloc]init];
    _TitleLable.text = @"¥??????元";
    _TitleLable.textColor = [UIColor orangeColor];
    _TitleLable.font = [UIFont systemFontOfSize:15];
    [MiddleImageView addSubview:_TitleLable];
    [_TitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MiddleImageView.mas_left).offset(5);
        make.top.mas_equalTo(MiddleImageView.mas_top).offset(10);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
    }];
    _SaileTimeLable = [[UILabel alloc]init];
    _SaileTimeLable.textColor = colorWithRGB(0.27, 0.27, 0.27);
    _SaileTimeLable.text = @"投资时间：3月以上";
    _SaileTimeLable.textAlignment = NSTextAlignmentLeft;
    _SaileTimeLable.font = [UIFont systemFontOfSize:11];
    [MiddleImageView addSubview:_SaileTimeLable];
    [_SaileTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_TitleLable.mas_left);
        make.top.mas_equalTo(_TitleLable.mas_bottom).offset(5);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
    
    _SailMoneyLable = [[UILabel alloc]init];
    _SailMoneyLable.textColor = colorWithRGB(0.27, 0.27, 0.27);
    _SailMoneyLable.textAlignment = NSTextAlignmentLeft;
    _SailMoneyLable.text = @"投资金额：3月以上";
    _SailMoneyLable.font = [UIFont systemFontOfSize:11];
    [MiddleImageView addSubview:_SailMoneyLable];
    [_SailMoneyLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_TitleLable.mas_left);
        make.top.mas_equalTo(_SaileTimeLable.mas_bottom);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
       }];
    _BuyTitleLable = [[UILabel alloc]init];
    _BuyTitleLable.text = @"车贷";
    _BuyTitleLable.textColor = [UIColor whiteColor];
    _BuyTitleLable.textAlignment = NSTextAlignmentCenter;
    _BuyTitleLable.backgroundColor = [UIColor whiteColor];
    _BuyTitleLable.font = [UIFont systemFontOfSize:11];
    [MiddleImageView addSubview:_BuyTitleLable];
    [_BuyTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_TitleLable.mas_left);
        make.top.mas_equalTo(_SailMoneyLable.mas_bottom).offset(5);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(18);
    }];
    _InterentTitleLable = [[UILabel alloc]init];
    _InterentTitleLable.text = @"网贷";
    _InterentTitleLable.textAlignment = NSTextAlignmentCenter;
    _InterentTitleLable.backgroundColor = [UIColor whiteColor];
    _InterentTitleLable.textColor = [UIColor whiteColor];
    _InterentTitleLable.font = [UIFont systemFontOfSize:11];
    [MiddleImageView addSubview:_InterentTitleLable];
    [_InterentTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_BuyTitleLable.mas_right).offset(2);
        make.centerY.mas_equalTo(_BuyTitleLable.mas_centerY);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(18);
    }];
    _QiYeTitleLable = [[UILabel alloc]init];
    _QiYeTitleLable.textColor = [UIColor whiteColor];
    _QiYeTitleLable.text = @"企业贷";
    _QiYeTitleLable.backgroundColor = [UIColor whiteColor];
    _QiYeTitleLable.textAlignment = NSTextAlignmentCenter;
    _QiYeTitleLable.font = [UIFont systemFontOfSize:11];
    [MiddleImageView addSubview:_QiYeTitleLable];
    [_QiYeTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_InterentTitleLable.mas_right).offset(2);
        make.centerY.mas_equalTo(_BuyTitleLable.mas_centerY);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(18);
    }];
    _PersonTitleLable = [[UILabel alloc]init];
    _PersonTitleLable.textColor = [UIColor whiteColor];
    _PersonTitleLable.backgroundColor = [UIColor whiteColor];
    _PersonTitleLable.textAlignment = NSTextAlignmentCenter;
    _PersonTitleLable.text = @"个人贷";
    _PersonTitleLable.font = [UIFont systemFontOfSize:11];
    [MiddleImageView addSubview:_PersonTitleLable];
    [_PersonTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_QiYeTitleLable.mas_right).offset(2);
        make.centerY.mas_equalTo(_BuyTitleLable.mas_centerY);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(18);
    }];

    _UseTitleLable = [[UILabel alloc]init];
    _UseTitleLable.text = @"立即使用";
    _UseTitleLable.font = [UIFont systemFontOfSize:15];
    _UseTitleLable.textAlignment = NSTextAlignmentCenter;
    _UseTitleLable.textColor = [UIColor whiteColor];
    [_RightImageView addSubview:_UseTitleLable];
    [_UseTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_RightImageView.mas_centerX);
        make.centerY.mas_equalTo(_RightImageView.mas_centerY).offset(-10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
    
    _UseTimeTitleLable = [[UILabel alloc]init];
    _UseTimeTitleLable.font = [UIFont systemFontOfSize:12];
    _UseTimeTitleLable.text = @"剩余1天过期";
    _UseTimeTitleLable.textAlignment = NSTextAlignmentCenter;
    _UseTimeTitleLable.textColor = [UIColor whiteColor];
    [_RightImageView addSubview:_UseTimeTitleLable];
    [_UseTimeTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_UseTitleLable.mas_centerX);
        make.top.mas_equalTo(_UseTitleLable.mas_bottom);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
}
- (void)setStageModel:(StageModel *)stageModel{
    if (stageModel != _stageModel) {
        _stageModel = stageModel;
        NSString *stageType = [NSString stringWithFormat:@"%@",_stageModel.type];
        switch ([stageType integerValue]) {
            case 1:
                _TitleStateLable.text = @"加 息 卷";
                _RightImageView.image = [UIImage imageNamed:@"wangdai_xmq_03"];
                _TypeImageView.image = [UIImage imageNamed:@"wangdai_xmq_01"];
                break;
            case 2:
                _TitleStateLable.text = @"小 米 卷";
                _RightImageView.image = [UIImage imageNamed:@"gold_xmq_03"];
                _TypeImageView.image = [UIImage imageNamed:@"gold_xmq_01"];
                break;
            case 3:
                _TitleStateLable.text = @"新 手 卷";
                _RightImageView.image = [UIImage imageNamed:@"new_xmq_03"];
                _TypeImageView.image = [UIImage imageNamed:@"new_xmq_01"];
                break;
            case 4:
                _TitleStateLable.text = @"金 米 卷";
                _RightImageView.image = [UIImage imageNamed:@"qiye_xmq_03"];
                _TypeImageView.image = [UIImage imageNamed:@"qiye_xmq_01"];
                break;
                
            default:
                break;
        }
     
        
        
        _TitleLable.text = [NSString stringWithFormat:@"¥%@元",_stageModel.value];

        _SailMoneyLable.text =[NSString stringWithFormat:@"投资金额：%@月以上",_stageModel.value];

        
        if ([_stageModel.state integerValue] ==1) {
            _UseTitleLable.text = @"已使用";
            _UseTimeTitleLable.hidden = YES;

        }else if ([_stageModel.state integerValue] ==2){
            _UseTitleLable.text = @"使用";
            _UseTimeTitleLable.text = [NSString stringWithFormat:@"剩余%@天过期",_stageModel.expireTime];
        }
        
        else{
            _UseTitleLable.text = @"已过期";
            _UseTimeTitleLable.hidden = YES;
            _RightImageView.image = [UIImage imageNamed:@"gray_quan_03"];
            _TypeImageView.image = [UIImage imageNamed:@"gray_quan_01"];


        }
        
        for (int i = 0; i < _stageModel.productCategoryIds.count; i++) {
            NSString *MyStageType = [_stageModel.productCategoryIds objectAtIndex:i];
            switch (i) {
                case 0:
                    switch ([MyStageType integerValue]) {
                        case 1:
                            _BuyTitleLable.text = @"网贷";
                            _BuyTitleLable.backgroundColor = colorWithRGB(0.62, 0.80, 0.09);

                            break;
                        case 3:
                            _BuyTitleLable.text = @"企业贷";
                            _BuyTitleLable.backgroundColor = colorWithRGB(0.99, 0.52, 0.18);

                            break;
                        case 4:
                            _BuyTitleLable.text = @"车贷";
                            _BuyTitleLable.backgroundColor = colorWithRGB(0.31, 0.69, 0.10);

                            break;
                        case 5:
                            _BuyTitleLable.text = @"个人贷";
                            _BuyTitleLable.backgroundColor = colorWithRGB(0.27, 0.78, 0.96);

                            break;
                        default:
                            break;
                    }
                    
                    break;
                case 1:
                    switch ([MyStageType integerValue]) {
                        case 1:
                            _InterentTitleLable.text = @"网贷";
                            _InterentTitleLable.backgroundColor = colorWithRGB(0.62, 0.80, 0.09);
                            
                            break;
                        case 3:
                            _InterentTitleLable.text = @"企业贷";
                            _InterentTitleLable.backgroundColor = colorWithRGB(0.99, 0.52, 0.18);
                            
                            break;
                        case 4:
                            _InterentTitleLable.text = @"车贷";
                            _InterentTitleLable.backgroundColor = colorWithRGB(0.31, 0.69, 0.10);
                            
                            break;
                        case 5:
                            _InterentTitleLable.text = @"个人贷";
                            _InterentTitleLable.backgroundColor = colorWithRGB(0.27, 0.78, 0.96);
                            
                            break;
                        default:
                            break;
                    }

                    break;
                case 2:
                    switch ([MyStageType integerValue]) {
                        case 1:
                            _QiYeTitleLable.text = @"网贷";
                            _QiYeTitleLable.backgroundColor = colorWithRGB(0.62, 0.80, 0.09);
                            
                            break;
                        case 3:
                            _QiYeTitleLable.text = @"企业贷";
                            _QiYeTitleLable.backgroundColor = colorWithRGB(0.99, 0.52, 0.18);
                            
                            break;
                        case 4:
                            _QiYeTitleLable.text = @"车贷";
                            _QiYeTitleLable.backgroundColor = colorWithRGB(0.31, 0.69, 0.10);
                            
                            break;
                        case 5:
                            _QiYeTitleLable.text = @"个人贷";
                            _QiYeTitleLable.backgroundColor = colorWithRGB(0.27, 0.78, 0.96);
                            
                            break;
                        default:
                            break;
                    }

                    break;
                case 3:
                    switch ([MyStageType integerValue]) {
                        case 1:
                            _PersonTitleLable.text = @"网贷";
                            _PersonTitleLable.backgroundColor = colorWithRGB(0.62, 0.80, 0.09);
                            
                            break;
                        case 3:
                            _PersonTitleLable.text = @"企业贷";
                            _PersonTitleLable.backgroundColor = colorWithRGB(0.99, 0.52, 0.18);
                            
                            break;
                        case 4:
                            _PersonTitleLable.text = @"车贷";
                            _PersonTitleLable.backgroundColor = colorWithRGB(0.31, 0.69, 0.10);
                            
                            break;
                        case 5:
                            _PersonTitleLable.text = @"个人贷";
                            _PersonTitleLable.backgroundColor = colorWithRGB(0.27, 0.78, 0.96);
                            
                            break;
                        default:
                            break;
                    }

                    break;
                default:
                    break;
            }
        }
        

        

    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
