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
        make.left.mas_equalTo(self.mas_left).offset(14);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(90);
    }];
    _zheImageView = [[UIImageView alloc]init];
    _zheImageView.image= [UIImage imageNamed:@"65zhe"];
    _zheImageView.backgroundColor = [UIColor clearColor];
    [_NameImageView addSubview:_zheImageView];
    [_zheImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_NameImageView.mas_left);
        make.top.mas_equalTo(_NameImageView.mas_top);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(45);
    }];
    _NameLabel = [[UILabel alloc]init];
    _NameLabel.text =@"";
    _NameLabel.numberOfLines = 0;
    _NameLabel.textAlignment = NSTextAlignmentLeft;
    _NameLabel.textColor = colorWithRGB(0.27, 0.27, 0.27);
    
    _NameLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_NameLabel];
    [_NameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_NameImageView.mas_right).offset(10);
        make.top.mas_equalTo(self.mas_top).offset(15);
        make.width.mas_equalTo(SCREEN_WIDTH - 120);
        make.height.mas_equalTo(20);
    }];
    
    _NameDetailLabel = [[UILabel alloc]init];
    _NameDetailLabel.text = @"";
    _NameDetailLabel.numberOfLines = 0;
    _NameDetailLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _NameDetailLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_NameDetailLabel];
    [_NameDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_NameImageView.mas_right).offset(10);
        make.top.mas_equalTo(_NameLabel.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH-150);
        make.height.mas_equalTo(40);
    }];
  
    
    
    _MyJiFenLabel = [[UILabel alloc]init];
    _MyJiFenLabel.text= @"积分：";
    _MyJiFenLabel.textColor = colorWithRGB(0.95, 0.6, 0.11);
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:_MyJiFenLabel.text attributes:attribtDic];
    _MyJiFenLabel.attributedText = attribtStr;
    _MyJiFenLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_MyJiFenLabel];
    [_MyJiFenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_NameImageView.mas_right).offset(10);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
    _OldZheLabel = [[UILabel alloc]init];
    _OldZheLabel.text= @"积分：";
    _OldZheLabel.textColor = colorWithRGB(0.53, 0.53, 0.53);
    _OldZheLabel.font = [UIFont systemFontOfSize:15];
    
    [self addSubview:_OldZheLabel];
    [_OldZheLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_NameImageView.mas_right).offset(10);
        make.bottom.mas_equalTo(_MyJiFenLabel.mas_top);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
    _GorrowView = [[UIImageView alloc]init];
    _GorrowView.image = [UIImage imageNamed:@"goarrow"];
    [self addSubview:_GorrowView];
    [_GorrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(18);
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
        if ([_GiftModel.oldScore integerValue]) {
            NSString *myStr =[NSString stringWithFormat:@"积分:%@",_GiftModel.oldScore];
            NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
            NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:myStr attributes:attribtDic];
            _OldZheLabel.attributedText = attribtStr;
            _OldZheLabel.hidden = NO;
            _MyJiFenLabel.text= [NSString stringWithFormat:@"促销积分:%@",_GiftModel.score];
        }else{
             _MyJiFenLabel.text= [NSString stringWithFormat:@"积分:%@",_GiftModel.score];
            _OldZheLabel.hidden = YES;
        }
       
      
        if ([_GiftModel.promotion integerValue]) {
            _zheImageView.hidden= NO;
            _zheImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@zhe",_GiftModel.discount]];
        }else{
            _zheImageView.hidden= YES;

        }

    }
}



@end
