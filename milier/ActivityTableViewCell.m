//
//  ActivityTableViewCell.m
//  milier
//
//  Created by amin on 2017/5/9.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "ActivityTableViewCell.h"

@implementation ActivityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configUI:(NSIndexPath *)indexPath{
    _BagView = [[UIView alloc]init];
    _BagView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_BagView];
    [_BagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH- 20);
        make.height.mas_equalTo(260);
    }];
    _TitleLabel = [[UILabel alloc]init];
    _TitleLabel.font = [UIFont systemFontOfSize:14];
    _TitleLabel.text = @"投资即送礼";
    [_BagView addSubview:_TitleLabel];
    [_TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_BagView.mas_left).offset(5);
        make.top.mas_equalTo(_BagView.mas_top).offset(5);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
    _DetailLabel = [[UILabel alloc]init];
    _DetailLabel.font = [UIFont systemFontOfSize:12];
    _DetailLabel.text = @"副标题";
    [_BagView addSubview:_DetailLabel];
    [_DetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_BagView.mas_left).offset(5);
        make.top.mas_equalTo(_TitleLabel.mas_bottom);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
    _ActivityTypeImageView = [[UIImageView alloc]init];
    _ActivityTypeImageView.image = [UIImage imageNamed:@"begin"];
    [_BagView addSubview:_ActivityTypeImageView];
    [_ActivityTypeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_BagView.mas_right);
        make.top.mas_equalTo(_BagView.mas_top);
        make.width.mas_equalTo(74);
        make.height.mas_equalTo(48);
    }];
    
    _ActivityImageView = [[UIImageView alloc]init];
    _ActivityImageView.backgroundColor = [UIColor blueColor];
    [_BagView addSubview:_ActivityImageView];
    [_ActivityImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_BagView.mas_left).offset(5);
        make.top.mas_equalTo(_DetailLabel.mas_bottom);
        make.right.mas_equalTo(_BagView.mas_right);
        make.height.mas_equalTo(140);
    }];

    _ActivityLabel = [[UILabel alloc]init];
    _ActivityLabel.numberOfLines = 0;
    _ActivityLabel.font = [UIFont systemFontOfSize:11];
    _ActivityLabel.text = @"，每年到了卡萨诺，妈蛋什么， 上，美女地方，慢慢，是你的，阿MSN什么，安定么";
    [_BagView addSubview:_ActivityLabel];
    [_ActivityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_BagView.mas_left).offset(5);
        make.top.mas_equalTo(_ActivityImageView.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH - 30);
        make.height.mas_equalTo(40);
    }];
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
    [_BagView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_BagView.mas_left);
        make.top.mas_equalTo(_ActivityLabel.mas_bottom).offset(2);
        make.width.mas_equalTo(SCREEN_WIDTH - 30);
        make.height.mas_equalTo(0.5);
    }];
    
    
    _LookLabel = [[UILabel alloc]init];
    _LookLabel.text = @"查看详细";
    _LookLabel.font = [UIFont systemFontOfSize:12];
    [_BagView addSubview:_LookLabel];
    [_LookLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_BagView.mas_left).offset(5);
        make.top.mas_equalTo(lineView.mas_bottom).offset(2);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    UIImageView *ArrowImageView = [[UIImageView alloc]init];
    ArrowImageView.image = [UIImage imageNamed:@"goarrow"];
    [_BagView addSubview:ArrowImageView];
    [ArrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_BagView.mas_right).offset(-5);
        make.top.mas_equalTo(lineView.mas_bottom).offset(12);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
}


- (void)setActivityModel:(ActivityModel *)ActivityModel{
    if (ActivityModel != _ActivityModel) {
        _ActivityModel = ActivityModel;
        _TitleLabel.text = [NSString stringWithFormat:@"%@",_ActivityModel.name];
        _DetailLabel.text = [NSString stringWithFormat:@"%@",_ActivityModel.subname];
        _ActivityLabel.text = [NSString stringWithFormat:@"%@",_ActivityModel.desc];
        if ([_ActivityModel.state integerValue] == 2) {
            _ActivityTypeImageView.image = [UIImage imageNamed:@"begin"];
            
        }else{
            _ActivityTypeImageView.image = [UIImage imageNamed:@"end"];

        }
        
    }
    [_ActivityImageView  sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_ActivityModel.poster]] placeholderImage:[UIImage imageNamed:@"bannerpic"]];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
