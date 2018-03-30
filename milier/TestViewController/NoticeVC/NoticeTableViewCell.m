//
//  NoticeTableViewCell.m
//  milier
//
//  Created by amin on 2018/3/29.
//  Copyright © 2018年 yj. All rights reserved.
//

#import "NoticeTableViewCell.h"

@implementation NoticeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configUI:(NSIndexPath *)indexPath{
    _NoticeLabel     = [[UILabel alloc]init];
    _NoticeLabel.text = @"XXXXXXXXXXXXXXXXXXXXXX";
    _NoticeLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_NoticeLabel];
    [_NoticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(30);
    }];
    
    _NoticeImageView  = [[UIImageView alloc]init];
    _NoticeImageView.image = [UIImage imageNamed:@"goarrow"];
    [self.contentView addSubview:_NoticeImageView];
    [_NoticeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(20);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
}

- (void)setNoticelModel:(NoticeModel *)noticelModel{
    if (noticelModel    != _noticelModel) {
        _noticelModel = noticelModel;
    }
    _NoticeLabel.text = [NSString stringWithFormat:@"%@",_noticelModel.title];
    
    
}
@end
