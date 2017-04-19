//
//  SecondTableViewCell.m
//  milier
//
//  Created by amin on 17/4/11.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "SecondTableViewCell.h"
#import "YJCircleProgressView.h"

@implementation SecondTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configUI:(NSIndexPath *)indexPath{
    _TitleLabel  = [[UILabel alloc]init];
    _TitleLabel.text= @"投米宝－优选中期";
    _TitleLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_TitleLabel];
    [_TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(6);
        make.left.mas_equalTo(self.contentView.mas_left).offset(20);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(25);
    }];
    
    _TypeLabel = [[UILabel alloc]init];
    _TypeLabel.font = [UIFont systemFontOfSize:10];
    _TypeLabel.backgroundColor = [UIColor orangeColor];
    _TypeLabel.textColor = [UIColor whiteColor];
    _TypeLabel.text = @"保守型";
    [self.contentView addSubview:_TypeLabel];
    [_TypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_TitleLabel.mas_bottom).offset(1);
        make.left.mas_equalTo(self.contentView.mas_left).offset(20);
        make.width.mas_equalTo(33);
        make.height.mas_equalTo(13);
    }];
    
    _TimeLabel = [[UILabel alloc]init];
    _TimeLabel.font = [UIFont systemFontOfSize:10];
    _TimeLabel.backgroundColor = [UIColor greenColor];
    _TimeLabel.textColor = [UIColor whiteColor];
    _TimeLabel.text = @"买入起即起息";
    [self.contentView addSubview:_TimeLabel];
    [_TimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_TitleLabel.mas_bottom).offset(1);
        make.left.mas_equalTo(_TypeLabel.mas_right).offset(10);
        make.width.mas_equalTo(63);
        make.height.mas_equalTo(13);
    }];

    _ProfitLabel = [[UILabel alloc]init];
    _ProfitLabel.font = [UIFont systemFontOfSize:14];
    _ProfitLabel.textColor = [UIColor blackColor];
    _ProfitLabel.text = @"预计年化收益";
    [self.contentView addSubview:_ProfitLabel];
    [_ProfitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_TypeLabel.mas_bottom).offset(1);
        make.left.mas_equalTo(self.contentView.mas_left).offset(20);
        make.width.mas_equalTo(93);
        make.height.mas_equalTo(20);
    }];
    
    _MoneyLabel = [[UILabel alloc]init];
    _MoneyLabel.text = @"10.32%";
    _MoneyLabel.textColor  = [UIColor blackColor];
    NSMutableAttributedString *newAttrStr = [[NSMutableAttributedString alloc] initWithString:@"12.34%"];
    [newAttrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:18] range:NSMakeRange(0,_MoneyLabel.text.length
)];
    [newAttrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:NSMakeRange(_MoneyLabel.text.length - 1
,1)];
    _MoneyLabel.attributedText = newAttrStr;
    [self.contentView addSubview:_MoneyLabel];
    [_MoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_ProfitLabel.mas_bottom);
        make.left.mas_equalTo(self.contentView.mas_left).offset(20);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(30);
    }];
    
    
    _shapeLayer = [CAShapeLayer layer];
   _shapeLayer.position = self.contentView.center;
    _shapeLayer.frame = CGRectMake(250, 40, 80, 80);//设置shapeLayer的尺寸和位置

    _shapeLayer.fillColor = [UIColor clearColor].CGColor;//填充颜色为ClearColor
    _shapeLayer.strokeStart = 0;
    
    _shapeLayer.strokeEnd = 1.0f;
    //设置线条的宽度和颜色
    _shapeLayer.lineWidth = 1.0f;
    _shapeLayer.strokeColor = [UIColor redColor].CGColor;
    
    //创建出圆形贝塞尔曲线
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 80, 80)];
    
    //让贝塞尔曲线与CAShapeLayer产生联系
    _shapeLayer.path = circlePath.CGPath;
    
    //添加并显示
    [self.contentView.layer addSublayer:_shapeLayer];
  
    _PercentLabel = [[UILabel alloc]init];
    _PercentLabel.text = @"12.34%";
    _PercentLabel.font = [UIFont systemFontOfSize:16];
    _PercentLabel.textAlignment = NSTextAlignmentCenter;
    _PercentLabel.textColor = [UIColor greenColor];
    _PercentLabel.frame =   CGRectMake(250, 40, 80, 80);
    [self.contentView addSubview:_PercentLabel];
  
    
}

- (void)setProductMoel:(ProuctModel *)productMoel{
    if (productMoel != _productMoel) {
        _productMoel = productMoel;
        
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
