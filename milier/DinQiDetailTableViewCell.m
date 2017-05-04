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
    _SailTimeImageView = [[UIImageView alloc]init];
    _SailTimeImageView.backgroundColor = [UIColor orangeColor];
    [self addSubview:_SailTimeImageView];
    [_SailTimeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
    }];
    _SailNameLabel = [[UILabel alloc]init];
    _SailNameLabel.text = @"购买时间:2015-02-30 23:32";
    _SailNameLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_SailNameLabel];
    [_SailNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_SailTimeImageView.mas_centerY);
        make.left.mas_equalTo(_SailTimeImageView.mas_right).offset(20);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(20);
    }];
    _LookSailLabel = [[UILabel alloc]init];
    _LookSailLabel.text = @"查看协议";
    _LookSailLabel.textAlignment = NSTextAlignmentRight;
    _LookSailLabel.backgroundColor = [UIColor orangeColor];
    _LookSailLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_LookSailLabel];
    [_LookSailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_SailTimeImageView.mas_centerY);
        make.right.mas_equalTo(self.mas_right).offset(-40);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(15);
    }];
    _LimitTimeImageView = [[UIImageView alloc]init];
    _LimitTimeImageView.backgroundColor = [UIColor orangeColor];
    [self addSubview:_LimitTimeImageView];
    [_LimitTimeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.top.mas_equalTo(_SailTimeImageView.mas_bottom).offset(10);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
    }];
    _LimitNameLabel = [[UILabel alloc]init];
    _LimitNameLabel.text = @"购买时间:2015-02-30 23:32";
    _LimitNameLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_LimitNameLabel];
    [_LimitNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_LimitTimeImageView.mas_centerY);
        make.left.mas_equalTo(_LimitTimeImageView.mas_right).offset(20);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(20);
    }];
    _LookLimitLabel = [[UILabel alloc]init];
    _LookLimitLabel.text = @"债券转让";
    _LookLimitLabel.textAlignment = NSTextAlignmentRight;
    _LookLimitLabel.backgroundColor = [UIColor orangeColor];
    _LookLimitLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_LookLimitLabel];
    [_LookLimitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_LimitTimeImageView.mas_centerY);
        make.right.mas_equalTo(self.mas_right).offset(-40);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(15);
    }];
    
    _BageView = [[UIView alloc]init];
    _BageView.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
    [self addSubview:_BageView];
    [_BageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.top.mas_equalTo(_LookLimitLabel.mas_bottom).offset(6);
        make.width.mas_equalTo(SCREEN_WIDTH - 20);
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
    CGFloat statuesHeight =  20 *[object integerValue];
    return statuesHeight;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
