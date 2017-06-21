//
//  AleardyBundTableViewCell.m
//  milier
////  Created by amin on 2017/5/18.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "AleardyBundTableViewCell.h"

@implementation AleardyBundTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configUI:(NSIndexPath *)indexPath{
    _userImageView = [[UIImageView alloc]init];
    _userImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:_userImageView];
    [_userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    _NameLabel = [[UILabel alloc]init];
    _NameLabel.text = @"15110499204";
    _NameLabel.textColor = [UIColor redColor];
    _NameLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_NameLabel];
    [_NameLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_userImageView.mas_right).offset(5);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    _DetailLabel = [[UILabel alloc]init];
    _DetailLabel.text = @"好友绑定后可领取现金红包";
    _DetailLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_DetailLabel];
    [_DetailLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_userImageView.mas_right).offset(5);
        make.top.mas_equalTo(_NameLabel.mas_bottom);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
    
   
    
    
    
}

- (void)setShareModel:(ShareModel *)ShareModel{
    if (ShareModel != _ShareModel) {
        _ShareModel = ShareModel;
        [_userImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_ShareModel.avatar]] placeholderImage:[UIImage imageNamed:@"headpicUser"] options:SDWebImageAllowInvalidSSLCertificates];
        _NameLabel.text =[NSString stringWithFormat:@"%@",_ShareModel.phoneNumber];
        _DetailLabel.text = [NSString stringWithFormat:@"%@",_ShareModel.phoneNumber];
        switch ([_ShareModel.propType integerValue]) {
            case 1:
                _DetailLabel.text = [NSString stringWithFormat:@"成功领取%@小米卷",_ShareModel.propValue];

                break;
            case 2:
                _DetailLabel.text = [NSString stringWithFormat:@"成功领取%@%%加息卷",_ShareModel.propValue];

                break;
            default:
                _DetailLabel.text = @"成功邀请好友";

                break;
        }
        

        
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
