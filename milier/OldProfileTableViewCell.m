//
//  OldProfileTableViewCell.m
//  milier
//
//  Created by amin on 17/4/24.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "OldProfileTableViewCell.h"

@implementation OldProfileTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configUI:(NSIndexPath *)indexPath{
    _NameLabel = [[UILabel alloc]init];
    _NameLabel.text =@"昨日收益29999";
    _NameLabel.textAlignment = NSTextAlignmentLeft;
    _NameLabel.textColor = [UIColor blackColor];
    _NameLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_NameLabel];
    [_NameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(30);
    }];
    _DetailLabel = [[UILabel alloc]init];
    _DetailLabel.text =@"昨日收益29999";
    _DetailLabel.textAlignment = NSTextAlignmentRight;
    _DetailLabel.textColor = colorWithRGB(0.95, 0.60, 0.11);
    _DetailLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_DetailLabel];
    [_DetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(30);
    }];
}
- (void)setProfileModel:(ProfileModel *)ProfileModel{
    if (ProfileModel != _ProfileModel) {
        _ProfileModel = ProfileModel;
        NSString *timeStr = [self getTimeStr:_ProfileModel.createTime withForMat:@"yyyy-MM-dd HH:mm:ss"];
        _NameLabel.text =[NSString stringWithFormat:@"%@",timeStr];
        _DetailLabel.text =[NSString stringWithFormat:@"+%.2f",[_ProfileModel.interest floatValue]];
        
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
