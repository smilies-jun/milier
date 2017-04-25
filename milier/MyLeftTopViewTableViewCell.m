//
//  MyLeftTopViewTableViewCell.m
//  milier
//
//  Created by amin on 17/4/24.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "MyLeftTopViewTableViewCell.h"

@implementation MyLeftTopViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configUI:(NSIndexPath *)indexPath{
    _NameLabel = [[UILabel alloc]init];
    _NameLabel.text =@"29999";
    _NameLabel.textAlignment = NSTextAlignmentCenter;
    _NameLabel.textColor = [UIColor orangeColor];
    _NameLabel.font = [UIFont systemFontOfSize:50];
    [self addSubview:_NameLabel];
    [_NameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(100);
    }];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
