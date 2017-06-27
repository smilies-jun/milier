//
//  DinQiDetailTableViewCell.m
//  milier
//
//  Created by amin on 17/4/25.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "DinQiDetailTableViewCell.h"

@implementation DinQiDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configUI:(NSIndexPath *)indexPath{
    _SailNameLabel = [[UILabel alloc]init];
    _SailNameLabel.text = @"购买时间:2015-02-30 23:32";
    _SailNameLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_SailNameLabel];
    [_SailNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.top.mas_equalTo(self.mas_top).offset(5);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(20);
    }];
    _LookSailLabel =  [UIButton buttonWithType:UIButtonTypeCustom];
    _LookSailLabel.tag = indexPath.section + 200 -1;
    [_LookSailLabel setTitle:@"查看协议>>" forState:UIControlStateNormal ];
    [_LookSailLabel setTitleColor:colorWithRGB(0.95, 0.6, 0.11) forState:UIControlStateNormal];
    _LookSailLabel.titleLabel.font = [UIFont systemFontOfSize:12];

    [self addSubview:_LookSailLabel];
    [_LookSailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_SailNameLabel.mas_centerY);
        if (SCREEN_WIDTH == 320) {
            make.right.mas_equalTo(self.mas_right).offset(-20);
            
        }else{
            make.right.mas_equalTo(self.mas_right).offset(-40);
            
        }
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(15);
    }];
    _LimitNameLabel = [[UILabel alloc]init];
    _LimitNameLabel.text = @"计息时间:2015-02-30 23:32";
    _LimitNameLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_LimitNameLabel];
    [_LimitNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.top.mas_equalTo(_SailNameLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(20);
    }];
    _LookLimitLabel =  [UIButton buttonWithType:UIButtonTypeCustom];
    [_LookLimitLabel setTitleColor:colorWithRGB(0.95, 0.6, 0.11) forState:UIControlStateNormal];
    _LookLimitLabel.hidden = YES;
    _LookLimitLabel.tag = 100 + indexPath.section-1;
    _LookLimitLabel.titleLabel.text = @"债权转让>>";
    _LookLimitLabel.titleLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_LookLimitLabel];
    [_LookLimitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_LimitNameLabel.mas_centerY);
        if (SCREEN_WIDTH == 320) {
            make.right.mas_equalTo(self.mas_right).offset(-20);

        }else{
            make.right.mas_equalTo(self.mas_right).offset(-40);
 
        }
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(15);
    }];
    
    _BageView = [[UIView alloc]init];
    _BageView.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
    [self addSubview:_BageView];
    [_BageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.top.mas_equalTo(_LookLimitLabel.mas_bottom).offset(15);
        make.width.mas_equalTo(SCREEN_WIDTH - 20);
        make.height.mas_equalTo(25);
    }];
    _FirstImageView = [[UIImageView alloc]init];
    _FirstImageView.image = [UIImage imageNamed:@"yifuxi"];
    [_BageView addSubview:_FirstImageView];
    [_FirstImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_BageView.mas_left).offset(5);
        make.centerY.mas_equalTo(_BageView.mas_centerY);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
    }];
    _FirstNameLabel = [[UILabel alloc]init];
    _FirstNameLabel.font = [UIFont systemFontOfSize:12];
    _FirstNameLabel.text = @"第一次付息：2015:12:12";
    [_BageView addSubview:_FirstNameLabel];
    [_FirstNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_FirstImageView.mas_right).offset(5);
        make.centerY.mas_equalTo(_FirstImageView.mas_centerY);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(10);
    }];
    _FirstSailLabel = [[UILabel alloc]init];
    _FirstSailLabel.text = @"30000元";
    _FirstSailLabel.font = [UIFont systemFontOfSize:12];
    _FirstSailLabel.textAlignment = NSTextAlignmentRight;
    _FirstSailLabel.textColor = [UIColor orangeColor];
    [_BageView addSubview:_FirstSailLabel];
    [_FirstSailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_BageView.mas_right).offset(-5);
        make.centerY.mas_equalTo(_BageView.mas_centerY);
        make.width.mas_equalTo(100);
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
    _SecondImageView = [[UIImageView alloc]init];
    _SecondImageView.image = [UIImage imageNamed:@"yifuxi"];
    [_SecondBageView addSubview:_SecondImageView];
    [_SecondImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_SecondBageView.mas_left).offset(5);
        make.centerY.mas_equalTo(_SecondBageView.mas_centerY);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
    }];
    _SecondNameLabel = [[UILabel alloc]init];
    _SecondNameLabel.font = [UIFont systemFontOfSize:12];
    _SecondNameLabel.text = @"第2次付息：2015:12:12";
    [_SecondBageView addSubview:_SecondNameLabel];
    [_SecondNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_SecondImageView.mas_right).offset(5);
        make.centerY.mas_equalTo(_SecondImageView.mas_centerY);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(10);
    }];
    _SecondSailLabel = [[UILabel alloc]init];
    _SecondSailLabel.text = @"30000元";
    _SecondSailLabel.font = [UIFont systemFontOfSize:12];
    _SecondSailLabel.textAlignment = NSTextAlignmentRight;
    _SecondSailLabel.textColor = [UIColor orangeColor];
    [_SecondBageView addSubview:_SecondSailLabel];
    [_SecondSailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_SecondBageView.mas_right).offset(-5);
        make.centerY.mas_equalTo(_SecondBageView.mas_centerY);
        make.width.mas_equalTo(100);
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
    _ThirdImageView = [[UIImageView alloc]init];
    _ThirdImageView.image = [UIImage imageNamed:@"yifuxi"];
    [_ThirdBageView addSubview:_ThirdImageView];
    [_ThirdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_ThirdBageView.mas_left).offset(5);
        make.centerY.mas_equalTo(_ThirdBageView.mas_centerY);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
    }];
    _ThirdNameLabel = [[UILabel alloc]init];
    _ThirdNameLabel.font = [UIFont systemFontOfSize:12];
    _ThirdNameLabel.text = @"第3次付息：2015:12:12";
    [_ThirdBageView addSubview:_ThirdNameLabel];
    [_ThirdNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_ThirdImageView.mas_right).offset(5);
        make.centerY.mas_equalTo(_ThirdImageView.mas_centerY);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(10);
    }];
    _ThirdSailLabel = [[UILabel alloc]init];
    _ThirdSailLabel.text = @"30000元";
    _ThirdSailLabel.font = [UIFont systemFontOfSize:12];
    _ThirdSailLabel.textAlignment = NSTextAlignmentRight;
    _ThirdSailLabel.textColor = [UIColor orangeColor];
    [_ThirdBageView addSubview:_ThirdSailLabel];
    [_ThirdSailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_ThirdBageView.mas_right).offset(-5);
        make.centerY.mas_equalTo(_ThirdBageView.mas_centerY);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    
    
    _FourBageView = [[UIView alloc]init];
    _FourBageView.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
    [self addSubview:_FourBageView];
    [_FourBageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.top.mas_equalTo(_ThirdBageView.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH - 20);
        make.height.mas_equalTo(25);
    }];

    _FourImageView = [[UIImageView alloc]init];
    _FourImageView.image = [UIImage imageNamed:@"yifuxi"];
    [_FourBageView addSubview:_FourImageView];
    [_FourImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_FourBageView.mas_left).offset(5);
        make.centerY.mas_equalTo(_FourBageView.mas_centerY);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
    }];
    _FourNameLabel = [[UILabel alloc]init];
    _FourNameLabel.font = [UIFont systemFontOfSize:11];
    _FourNameLabel.text = @"第4次付息：2015:12:12";
    [_FourBageView addSubview:_FourNameLabel];
    [_FourNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_FourImageView.mas_right).offset(5);
        make.centerY.mas_equalTo(_FourImageView.mas_centerY);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(10);
    }];
    _FourSailLabel  = [[UILabel alloc]init];
    _FourSailLabel.text = @"30000元";
    _FourSailLabel.font = [UIFont systemFontOfSize:11];
    _FourSailLabel.textAlignment = NSTextAlignmentRight;
    _FourSailLabel.textColor = [UIColor orangeColor];
    [_FourBageView addSubview:_FourSailLabel];
    [_FourSailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_FourBageView.mas_right).offset(-5);
        make.centerY.mas_equalTo(_FourBageView.mas_centerY);
        make.width.mas_equalTo(100);
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
    
    UIView* _bottomView = [[UIView alloc]init];
    _bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom);
        make.left.mas_equalTo(self.mas_left);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(10);
    }];

    
}
- (void)setDinQiModel:(DinQiModel *)DinQiModel{
    if (DinQiModel != _DinQiModel) {
        _DinQiModel = DinQiModel;
//        NSTimeInterval interval=[_DinQiModel.createTime doubleValue] / 1000.0;
//        NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
//        NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
//        [objDateformat setDateFormat:@"yyyy-MM-dd"];
//        NSString * timeStr = [NSString stringWithFormat:@"%@",[objDateformat stringFromDate: date]];
        NSString *CreateTimeStr = [self getTimeStr:_DinQiModel.createTime withForMat:@"yyyy-MM-dd HH:mm:ss"];
        
        
        _SailNameLabel.text =[NSString stringWithFormat:@"购买时间:%@",CreateTimeStr];
        
        NSString *startTimeStr = [self getTimeStr:_DinQiModel.InterestBearingStartTime withForMat:@"yyyy-MM-dd"];
        NSString *endTimeStr = [self getTimeStr:_DinQiModel.InterestBearingEndTime withForMat:@"yyyy-MM-dd"];
        _LimitNameLabel.text = [NSString stringWithFormat:@"计息时间:%@到%@",startTimeStr,endTimeStr];
        
        if ([_DinQiModel.transferable integerValue] == 1) {
            _LookLimitLabel.hidden = NO;
            if ([_DinQiModel.state integerValue]  == 2) {
                [_LookLimitLabel setTitle:@"债权转让>>" forState:UIControlStateNormal];

            }else{


            }
        }else{
            if ([_DinQiModel.state integerValue]  == 5) {
                [_LookLimitLabel setTitle:@"取消转让>>" forState:UIControlStateNormal];
                _LookLimitLabel.hidden = NO;

            }else{
                _LookLimitLabel.hidden = YES;
  
            }
            


        }
        if (_DinQiModel.InstallmentInterestList.count) {
            
            for (int i = 0; i<_DinQiModel.InstallmentInterestList.count; i++) {
                if (i== 0) {
                    
                    NSDictionary *dic = [_DinQiModel.InstallmentInterestList objectAtIndex:0];
                    if ([[dic objectForKey:@"state"] integerValue] == 1) {
                        _FirstImageView.hidden = NO;
                       
                    }else{
                        _FirstImageView.hidden = YES;
 
                    }
                    NSString *TimeStr = [self getTimeStr:[dic objectForKey:@"repaymentTime"] withForMat:@"yyyy-MM-dd"];
                    _FirstNameLabel.text = [NSString stringWithFormat:@"第一次付息：%@",TimeStr];
                    _FirstSailLabel.text = [NSString stringWithFormat:@"%.2f元",[[dic objectForKey:@"amount"] doubleValue]];
                }
                if (i == 1) {
                    NSDictionary *dic = [_DinQiModel.InstallmentInterestList objectAtIndex:1];
                    if ([[dic objectForKey:@"state"] integerValue] == 1) {
                        _SecondImageView.hidden = NO;
                       

                    }else{
                        _SecondImageView.hidden = YES;
 
                    }
                    NSString *TimeStr = [self getTimeStr:[dic objectForKey:@"repaymentTime"] withForMat:@"yyyy-MM-dd"];
                    _SecondNameLabel.text = [NSString stringWithFormat:@"第二次付息：%@",TimeStr];
                    _SecondSailLabel.text = [NSString stringWithFormat:@"%.2f元",[[dic objectForKey:@"amount"]doubleValue]];

                }
                if (i ==2) {
                    NSDictionary *dic = [_DinQiModel.InstallmentInterestList objectAtIndex:2];
                    if ([[dic objectForKey:@"state"] integerValue] == 1) {
                        _ThirdImageView.hidden = NO;
                      
                    }else{
                        _ThirdImageView.hidden = YES;
 
                    }
                    NSString *TimeStr = [self getTimeStr:[dic objectForKey:@"repaymentTime"] withForMat:@"yyyy-MM-dd"];
                    
                    _ThirdNameLabel.text = [NSString stringWithFormat:@"第三次付息：%@",TimeStr];
                    _ThirdSailLabel.text = [NSString stringWithFormat:@"%.2f元",[[dic objectForKey:@"amount"]doubleValue]];

                }
                if (i == 3) {
                    NSDictionary *dic = [_DinQiModel.InstallmentInterestList objectAtIndex:3];
                    if ([[dic objectForKey:@"state"] integerValue] == 1) {
                        _FourImageView.hidden = NO;
                       
                    }else{
                        _FourImageView.hidden = YES;
  
                    }
                    NSString *TimeStr = [self getTimeStr:[dic objectForKey:@"repaymentTime"] withForMat:@"yyyy-MM-dd"];
                    
                    _FourNameLabel.text = [NSString stringWithFormat:@"第四次付息：%@",TimeStr];
                    _FourSailLabel.text = [NSString stringWithFormat:@"%.2f元",[[dic objectForKey:@"amount"]doubleValue]];

                }
            }
            

        }
        
        
    }
}
- (NSString *)getTimeStr:(NSString *)MyTimeStr withForMat:(NSString *)formatStr{
    NSTimeInterval interval=[MyTimeStr doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:formatStr];
    NSString * timeStr = [NSString stringWithFormat:@"%@",[objDateformat stringFromDate: date]];
    return timeStr;
}
- (void)setCellDataWithStatusName:(NSString *)status{
    
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object{
    CGFloat statuesHeight =  28 *[object integerValue];
    return statuesHeight;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
