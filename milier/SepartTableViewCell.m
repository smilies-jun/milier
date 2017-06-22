//
//  SepartTableViewCell.m
//  milier
//
//  Created by amin on 2017/5/19.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "SepartTableViewCell.h"

@implementation SepartTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configUI:(NSIndexPath *)indexPath{
    _TitleLabel  = [[UILabel alloc]init];
    _TitleLabel.text= @"2017-05-15";
    _TitleLabel.textColor = colorWithRGB(0.27, 0.27, 0.27);
    _TitleLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_TitleLabel];
    [_TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
    }];
    
    _TypeLabel = [[UILabel alloc]init];
    _TypeLabel.text = @"下家存量总金额";
    _TypeLabel.textAlignment = NSTextAlignmentCenter;
    _TypeLabel.font = [UIFont systemFontOfSize:13];
    _TypeLabel.textColor = colorWithRGB(0.95, 0.6, 0.11);
    [self addSubview:_TypeLabel];
    [_TypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
    }];
    
    _TimeLabel = [[UILabel alloc]init];
    _TimeLabel.text  =@"+2323";
    _TimeLabel.textAlignment = NSTextAlignmentRight;
    _TimeLabel.font = [UIFont systemFontOfSize:13];
    _TimeLabel.textColor = colorWithRGB(0.95, 0.6, 0.11);
    [self addSubview:_TimeLabel];
    [_TimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
    }];
//    if (indexPath.row == 0) {
//        _TitleLabel.text= @"时间";
//        _TypeLabel.text = @"下家存量总金额";
//        _TimeLabel.text  =@"我的分成";
//
//
//    }
    

}
- (NSString *)getTimeStr:(NSString *)MyTimeStr withForMat:(NSString *)formatStr{
    NSTimeInterval interval=[MyTimeStr doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:formatStr];
    NSString * timeStr = [NSString stringWithFormat:@"%@",[objDateformat stringFromDate: date]];
    return timeStr;
}
- (void)setSepartModel:(SepartModel *)SepartModel{
    if (SepartModel != _SepartModel) {
        _SepartModel = SepartModel;
        NSString *timeStr = [self getTimeStr:_SepartModel.createTime withForMat:@"yyyy-MM-dd"];
        _TitleLabel.text= [NSString stringWithFormat:@"%@",timeStr];;
        _TimeLabel.text  =[NSString stringWithFormat:@"+%@",_SepartModel.amount];
        _TypeLabel.text = [NSString stringWithFormat:@"%.2f",[_SepartModel.stock doubleValue]];
    }
}

@end
