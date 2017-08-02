//
//  DinQiJiXiDetailTableViewCell.m
//  milier
//
//  Created by amin on 2017/7/31.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "DinQiJiXiDetailTableViewCell.h"

@implementation DinQiJiXiDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configUI:(NSIndexPath *)indexPath{
    
    _SaleImageView =[[UIImageView alloc]init];
    _SaleImageView.image = [UIImage imageNamed:@""];
    _SaleImageView.frame =CGRectMake(10, 20, 20, 20);
    [self addSubview:_SaleImageView];

    
    _SaleLabel = [[UILabel alloc]init];
    _SaleLabel.text = @"第一次计息: 2017-08-23 12:20";
    _SaleLabel.font = [UIFont systemFontOfSize:14];
    _SaleLabel.frame = CGRectMake(40, 10, SCREEN_WIDTH - 120, 25);
    [self addSubview:_SaleLabel];
    
    _MoneyLabel = [[UILabel alloc]init];
    _MoneyLabel.text = @"10000元";
    _MoneyLabel.textAlignment = NSTextAlignmentRight;
    _MoneyLabel.font = [UIFont systemFontOfSize:14];
    _MoneyLabel.textColor = colorWithRGB(0.96, 0.6, 0.11);
    [self addSubview:_MoneyLabel];
    [_MoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(25);
        
    }];
}
- (void)setFrame:(CGRect)frame{
    frame.size.height -= 1;
    
    [super setFrame:frame];
}
- (NSString *)getTimeStr:(NSString *)MyTimeStr withForMat:(NSString *)formatStr{
    NSTimeInterval interval=[MyTimeStr doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:formatStr];
    NSString * timeStr = [NSString stringWithFormat:@"%@",[objDateformat stringFromDate: date]];
    return timeStr;
}
- (void)setJixiModel:(DinQiModel *)JixiModel{
    if (JixiModel != _JixiModel) {
        _JixiModel = JixiModel;
       // _SaleLabel.text = @"第一次计息: 2017-08-23 12:20";
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
