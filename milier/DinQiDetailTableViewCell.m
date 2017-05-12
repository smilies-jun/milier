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
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(20);
    }];
    _LookSailLabel = [[UILabel alloc]init];
    _LookSailLabel.text = @"查看协议>>";
    _LookSailLabel.textColor = colorWithRGB(0.96, 0.6, 0.11);
    _LookSailLabel.textAlignment = NSTextAlignmentRight;
    _LookSailLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_LookSailLabel];
    [_LookSailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_SailNameLabel.mas_centerY);
        make.right.mas_equalTo(self.mas_right).offset(-40);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(15);
    }];
    _LimitNameLabel = [[UILabel alloc]init];
    _LimitNameLabel.text = @"购买时间:2015-02-30 23:32";
    _LimitNameLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_LimitNameLabel];
    [_LimitNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.top.mas_equalTo(_SailNameLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(20);
    }];
    _LookLimitLabel = [[UILabel alloc]init];
    _LookLimitLabel.textColor = colorWithRGB(0.96, 0.6, 0.11);
    _LookLimitLabel.text = @"债券转让";
    _LookLimitLabel.textAlignment = NSTextAlignmentRight;
    _LookLimitLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_LookLimitLabel];
    [_LookLimitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_LimitNameLabel.mas_centerY);
        make.right.mas_equalTo(self.mas_right).offset(-40);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(15);
    }];
    
    _BageView = [[UIView alloc]init];
    _BageView.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
    [self addSubview:_BageView];
    [_BageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.top.mas_equalTo(_LookLimitLabel.mas_bottom).offset(6);
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
    _FirstNameLabel.font = [UIFont systemFontOfSize:11];
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
    _FirstSailLabel.font = [UIFont systemFontOfSize:11];
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
    _SecondNameLabel.font = [UIFont systemFontOfSize:11];
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
    _SecondSailLabel.font = [UIFont systemFontOfSize:11];
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
    _ThirdNameLabel.font = [UIFont systemFontOfSize:11];
    _ThirdNameLabel.text = @"第3次付息：2015:12:12";
    [_ThirdBageView addSubview:_ThirdNameLabel];
    [_ThirdNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_ThirdImageView.mas_right).offset(5);
        make.centerY.mas_equalTo(_ThirdImageView.mas_centerY);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(10);
    }];
    _FirstSailLabel = [[UILabel alloc]init];
    _FirstSailLabel.text = @"30000元";
    _FirstSailLabel.font = [UIFont systemFontOfSize:11];
    _FirstSailLabel.textAlignment = NSTextAlignmentRight;
    _FirstSailLabel.textColor = [UIColor orangeColor];
    [_ThirdBageView addSubview:_FirstSailLabel];
    [_FirstSailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
}

- (void)setCellDataWithStatusName:(NSString *)status{
    
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object{
    NSLog(@"object = %@",object);
    CGFloat statuesHeight =  25 *[object integerValue];
    return statuesHeight;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
