//
//  UnYetDetailTableViewCell.m
//  milier
//
//  Created by amin on 2017/8/1.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "UnYetDetailTableViewCell.h"

@implementation UnYetDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configUI:(NSIndexPath *)indexPath{
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = colorWithRGB(0.97, 0.97, 0.97);
    topView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    [self addSubview:topView];
    
    _TitleLabel = [[UILabel alloc]init];
    _TitleLabel.font = [UIFont systemFontOfSize:13];
    [topView addSubview:_TitleLabel];
    [_TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topView.mas_left).offset(10);
        make.centerY.mas_equalTo(topView.mas_centerY);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(20);
    }];
    _DetailLabel = [[UILabel alloc]init];
    if (indexPath.row == 1) {
        _DetailLabel.text = @"到期本息:";
  
    }else if (indexPath.row == 2){
        _DetailLabel.text = @"逾期金额:";
    }else{
        _DetailLabel.text = @"收款金额:";
    }
    _DetailLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_DetailLabel];
    [_DetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.top.mas_equalTo(topView.mas_bottom);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(40);
    }];
    _DetailMoneyLabel = [[UILabel alloc]init];
    _DetailMoneyLabel.textColor = colorWithRGB(0.95, 0.6, 0.11);
    _DetailMoneyLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_DetailMoneyLabel];
    [_DetailMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_DetailLabel.mas_right);
        make.top.mas_equalTo(topView.mas_bottom);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(40);
    }];
    
    _TimeLabel = [[UILabel alloc]init];
    _TimeLabel.text = @"2017 10 :10 ";
    _TimeLabel.textAlignment = NSTextAlignmentRight;
    _TimeLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_TimeLabel];
    [_TimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.top.mas_equalTo(topView.mas_bottom);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(40);
    }];
    
    
}
- (NSString *)getTimeStr:(NSString *)MyTimeStr withForMat:(NSString *)formatStr{
    NSTimeInterval interval=[MyTimeStr doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:formatStr];
    NSString * timeStr = [NSString stringWithFormat:@"%@",[objDateformat stringFromDate: date]];
    return timeStr;
}

- (void)setDetailModel:(YetDetailModel *)DetailModel{
    if (DetailModel != _DetailModel) {
        _DetailModel = DetailModel;
        _TitleLabel.text = [NSString stringWithFormat:@"%@",_DetailModel.title];
        switch ([_DetailModel.type integerValue]) {
            case 1:
                 _DetailLabel.text = @"到期本息:";
                _DetailMoneyLabel.text = [NSString stringWithFormat:@"+%.2f",[_DetailModel.total doubleValue] ];
                break;
            case 2:
                _DetailLabel.text = @"逾期金额:";
                 _DetailMoneyLabel.text = [NSString stringWithFormat:@"+%.2f",[_DetailModel.total doubleValue] ];
                break;
            case 3:
                 _DetailLabel.text = @"收款金额:";
                 _DetailMoneyLabel.text = [NSString stringWithFormat:@"+%.2f",[_DetailModel.total doubleValue] ];
                break;
            default:
                break;
        }
       
        NSString *timeStr = [self getTimeStr:_DetailModel.date withForMat:@"yyyy-MM-dd hh:mm"];

         _TimeLabel.text = [NSString stringWithFormat:@"%@",timeStr];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
