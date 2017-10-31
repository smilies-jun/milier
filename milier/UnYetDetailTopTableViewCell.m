//
//  UnYetDetailTopTableViewCell.m
//  milier
//
//  Created by amin on 2017/8/2.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "UnYetDetailTopTableViewCell.h"

@implementation UnYetDetailTopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configUI:(NSIndexPath *)indexPath{
    _ImageView = [[UIView alloc]init];
    _ImageView.backgroundColor = [UIColor orangeColor];
    _ImageView.frame = CGRectMake(0, 25, 2, 60);
    [self addSubview:_ImageView];
    
    _DinQiLabel = [[UILabel alloc]init];
    _DinQiLabel.text = @"21324";
    _DinQiLabel.font = [UIFont systemFontOfSize:15];
    _DinQiLabel.frame = CGRectMake(10, 10, SCREEN_WIDTH-20, 20);
    [self addSubview:_DinQiLabel];
    
    _DinQiDetailLabel = [[UILabel alloc]init];
    _DinQiDetailLabel.text = @"投资金额：2000000";
    _DinQiDetailLabel.textColor = colorWithRGB(0.27, 0.27, 0.27);
    _DinQiDetailLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_DinQiDetailLabel];
    [_DinQiDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.top.mas_equalTo(_DinQiLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(SCREEN_WIDTH/2);
        make.height.mas_equalTo(20);
    }];
    _DaoQiLabel = [[UILabel alloc]init];
    _DaoQiLabel.text = @"到期日期：2017-18-18";
    _DaoQiLabel.textColor = colorWithRGB(0.27, 0.27, 0.27);
    _DaoQiLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_DaoQiLabel];
    [_DaoQiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_DinQiDetailLabel.mas_right);
        make.top.mas_equalTo(_DinQiLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(SCREEN_WIDTH/2);
        make.height.mas_equalTo(20);
    }];
    _MoneyLabel = [[UILabel alloc]init];
    _MoneyLabel.text = @"代收金额：2017-18-18";
    _MoneyLabel.textColor = colorWithRGB(0.94, 0.6, 0.11);
    _MoneyLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_MoneyLabel];
    [_MoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.top.mas_equalTo(_DaoQiLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(SCREEN_WIDTH/2);
        make.height.mas_equalTo(20);
    }];
    _StateImageView = [[UIImageView alloc]init];
    _StateImageView.image = [UIImage imageNamed:@"assignment"];
    _StateImageView.frame = CGRectMake(SCREEN_WIDTH - 40, 0, 40, 40);
    [self addSubview:_StateImageView];
    
    _RowImageView = [[UIImageView alloc]init];
    _RowImageView.image = [UIImage imageNamed:@"goarrow"];
    _RowImageView.frame = CGRectMake(SCREEN_WIDTH - 38, 50, 18, 18);
    [self addSubview:_RowImageView];
    
}

- (void)setLostModel:(MoneyModel *)LostModel{
    if (LostModel != _LostModel) {
        _LostModel = LostModel;
        NSString *timeStr = [self getTimeStr:_LostModel.date withForMat:@"yyyy-MM-dd"];
        
        _DinQiLabel.text = [NSString stringWithFormat:@"%@",_LostModel.name];
        _DinQiDetailLabel.text = [NSString stringWithFormat:@"投资金额:%@",_LostModel.payTotal];
        _DaoQiLabel.text = [NSString stringWithFormat:@"到期时间:%@",timeStr];
        NSString *MoneyStr = [NSString stringWithFormat:@"待收金额:%@",_LostModel.total];
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",MoneyStr]];
        NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:@"待收金额:"].location, [[noteStr string] rangeOfString:@"待收金额:"].length);
        //需要设置的位置
        [noteStr addAttribute:NSForegroundColorAttributeName value:colorWithRGB(0.27, 0.27, 0.27) range:redRange];
        //设置颜色
        [_MoneyLabel setAttributedText:noteStr];
        
        switch ([_LostModel.state integerValue]) {
            case 1:
                _StateImageView.image = [UIImage imageNamed:@"interest"];
                break;
            case 2:
                _StateImageView.image = [UIImage imageNamed:@"yuqi"];
                break;
            case 3:
                _StateImageView.image = [UIImage imageNamed:@"huaizhang"];
                break;
            case 4:
                _StateImageView.image = [UIImage imageNamed:@"repayment"];
                break;
            case 5:
                _StateImageView.image = [UIImage imageNamed:@"yijieshu"];
                break;
            default:
                break;
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
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
