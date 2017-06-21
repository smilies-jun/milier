//
//  MyLeftDetailTableViewCell.m
//  milier
//
//  Created by amin on 17/4/24.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "MyLeftDetailTableViewCell.h"

@implementation MyLeftDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configUI:(NSIndexPath *)indexPath{
    
    _NameLabel = [[UILabel alloc]init];
    _NameLabel.text = @"";
    _NameLabel.font = [UIFont systemFontOfSize:14];
    _NameLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_NameLabel];
    [_NameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    
    }];
    _DetailLabel = [[UILabel alloc]init];
    _DetailLabel.text = @"";
    _DetailLabel.textColor = colorWithRGB(0.56, 0.56, 0.56);
    _DetailLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_DetailLabel];
    [_DetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.top.mas_equalTo(_NameLabel.mas_bottom);
        make.width.mas_equalTo(220);
        make.height.mas_equalTo(20);
    }];
    _TimeLabel = [[UILabel alloc]init];
    _TimeLabel.textColor = colorWithRGB(0.56, 0.56, 0.56);
    _TimeLabel.text = @"";
    _TimeLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_TimeLabel];
    [_TimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.top.mas_equalTo(_DetailLabel.mas_bottom);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    _NumberlLabel = [[UILabel alloc]init];
    _NumberlLabel.textColor = [UIColor orangeColor];
    _NumberlLabel.textAlignment = NSTextAlignmentRight;
    _NumberlLabel.text = @"";
    _NumberlLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_NumberlLabel];
    [_NumberlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.top.mas_equalTo(self.mas_top).offset(20);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    _StatelLabel = [[UILabel alloc]init];
    _StatelLabel.textAlignment = NSTextAlignmentRight;
    _StatelLabel.text = @"支付成功";
    _StatelLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_StatelLabel];
    [_StatelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.top.mas_equalTo(_NumberlLabel.mas_bottom);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
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
- (void)setLeftModel:(MyLeftModel *)LeftModel{
    if (LeftModel != _LeftModel) {
        _LeftModel = LeftModel;
        _NameLabel.text = [NSString stringWithFormat:@"%@",_LeftModel.orderNumber];
        _DetailLabel.text = [NSString stringWithFormat:@"%@",_LeftModel.desc];
        NSString *timeStr = [self getTimeStr:_LeftModel.createTime withForMat:@"yyyy-MM-dd"];
        if ([_LeftModel.type integerValue] == 2) {
            _NumberlLabel.text = [NSString stringWithFormat:@"-%@",_LeftModel.amount];

        }else if ([_LeftModel.type integerValue] == 7){
            _NumberlLabel.text = [NSString stringWithFormat:@"-%@",_LeftModel.amount];

        }else if ([_LeftModel.type integerValue] == 17){
            _NumberlLabel.text = [NSString stringWithFormat:@"-%@",_LeftModel.amount];

        }else{
            _NumberlLabel.text = [NSString stringWithFormat:@"+%@",_LeftModel.amount];

        }
        
        _TimeLabel.text = [NSString stringWithFormat:@"%@",timeStr];

        if ([_LeftModel.state integerValue] == 1) {
            _StatelLabel.text = @"处理中";
            _StatelLabel.textColor = colorWithRGB(0.95, 0.6, 0.11);

        }else if ([_LeftModel.state integerValue] == 2){
            _StatelLabel.text = @"处理失败";
            _StatelLabel.textColor = colorWithRGB(1, 0.09, 0.01);

        }else{
            _StatelLabel.text = @"处理成功";
            _StatelLabel.textColor = colorWithRGB(0.57, 0.72, 0.13);

        }
        

    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
