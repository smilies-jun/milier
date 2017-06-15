//
//  ConvertTableViewCell.m
//  milier
//
//  Created by amin on 17/5/3.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "ConvertTableViewCell.h"

@implementation ConvertTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configUI:(NSIndexPath *)indexPath{
    
    _NameImageView = [[UIImageView alloc]init];
    _NameImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:_NameImageView];
    [_NameImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    
    _NameLabel = [[UILabel alloc]init];
    _NameLabel.text =@"";
    _NameLabel.textAlignment = NSTextAlignmentLeft;
    _NameLabel.textColor = [UIColor blackColor];
    _NameLabel.font = [UIFont systemFontOfSize:10];
    [self addSubview:_NameLabel];
    [_NameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_NameImageView.mas_right).offset(10);
        make.top.mas_equalTo(self.mas_top).offset(20);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(15);
    }];
    
    _NameDetailLabel = [[UILabel alloc]init];
    _NameDetailLabel.text = @"";
    _NameDetailLabel.numberOfLines = 0;
    _NameDetailLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _NameDetailLabel.font = [UIFont systemFontOfSize:10];
    [self addSubview:_NameDetailLabel];
    [_NameDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_NameImageView.mas_right).offset(10);
        make.top.mas_equalTo(_NameLabel.mas_bottom);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(25);
    }];
    
    _MyJiFenLabel = [[UILabel alloc]init];
    _MyJiFenLabel.text= @"积分：";
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:_MyJiFenLabel.text attributes:attribtDic];
    _MyJiFenLabel.attributedText = attribtStr;
    _MyJiFenLabel.font = [UIFont systemFontOfSize:10];
    [self addSubview:_MyJiFenLabel];
    [_MyJiFenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_NameImageView.mas_right).offset(10);
        make.top.mas_equalTo(_NameDetailLabel.mas_bottom);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
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

- (void)setGiftModel:(giftModel *)GiftModel{
    if (GiftModel != _GiftModel) {
        _GiftModel = GiftModel;
        [_NameImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_GiftModel.image]] placeholderImage:[UIImage imageNamed:@"jifenpic"]];
        _NameLabel.text =[NSString stringWithFormat:@"%@",_GiftModel.name];
        _NameDetailLabel.text =[NSString stringWithFormat:@"%@",_GiftModel.desc];
        _MyJiFenLabel.text= [NSString stringWithFormat:@"积分:%@",_GiftModel.score];

    }
}



@end
