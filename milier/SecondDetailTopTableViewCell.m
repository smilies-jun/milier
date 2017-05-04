//
//  SecondDetailTopTableViewCell.m
//  milier
//
//  Created by amin on 17/5/2.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "SecondDetailTopTableViewCell.h"

@implementation SecondDetailTopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configUI:(NSIndexPath *)indexPath{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 470)];
    [self addSubview:imageView];
    TitleLabel = [[UILabel alloc]init];
    TitleLabel.text = @"米三－新密计划第一期";
    TitleLabel.font = [UIFont systemFontOfSize:13];
    TitleLabel.textAlignment = NSTextAlignmentCenter;
    [imageView addSubview:TitleLabel];
    [TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_left);
        make.top.mas_equalTo(imageView.mas_top).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(20);
        
    }];
    NumberLabel = [[UILabel alloc]init];
    NumberLabel.text = @"项目编号：251425";
    NumberLabel.font = [UIFont systemFontOfSize:10];
    NumberLabel.textAlignment = NSTextAlignmentCenter;
    [imageView addSubview:NumberLabel];
    [NumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_left);
        make.top.mas_equalTo(TitleLabel.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(10);
        
    }];
    ShapeLayer = [CAShapeLayer layer];
    ShapeLayer.fillColor = [UIColor clearColor].CGColor;//填充颜色为ClearColor
    //设置线条的宽度和颜色
    ShapeLayer.lineWidth = 1.0f;
    ShapeLayer.strokeColor = [UIColor redColor].CGColor;
    //创建出圆形贝塞尔曲线
    UIBezierPath *circlePath =  [UIBezierPath bezierPathWithArcCenter:CGPointMake(imageView.centerX, imageView.centerY-30) radius:120 startAngle:0.75f*M_PI endAngle:0.25f*M_PI clockwise:YES];
    
    //让贝塞尔曲线与CAShapeLayer产生联系
    ShapeLayer.path = circlePath.CGPath;
    
    //添加并显示
    [imageView.layer addSublayer:ShapeLayer];
    
    ProfitLabel  = [[UILabel alloc]init];
    ProfitLabel.text = @"年化收益";
    ProfitLabel.font = [UIFont systemFontOfSize:12];
    ProfitLabel.textAlignment = NSTextAlignmentCenter;
    [imageView addSubview:ProfitLabel];
    [ProfitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(NumberLabel.mas_centerX);
        make.top.mas_equalTo(NumberLabel.mas_bottom).offset(60);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
    
    ProfitPercentLabel  = [[UILabel alloc]init];
    ProfitPercentLabel.text = @"12.34%";
    ProfitPercentLabel.textColor = [UIColor blueColor];
    NSMutableAttributedString *newAttrStr = [[NSMutableAttributedString alloc] initWithString:@"12.34%"];
    [newAttrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:50] range:NSMakeRange(0,ProfitPercentLabel.text.length
                                                                                                          )];
    [newAttrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20] range:NSMakeRange(ProfitPercentLabel.text.length - 1
                                                                                                          ,1)];
    ProfitPercentLabel.attributedText = newAttrStr;
    ProfitPercentLabel.textAlignment = NSTextAlignmentCenter;
    [imageView addSubview:ProfitPercentLabel];
    [ProfitPercentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(NumberLabel.mas_centerX);
        make.top.mas_equalTo(ProfitLabel.mas_bottom).offset(30);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(40);
    }];
    
    BondLabel = [[UILabel alloc]init];
    BondLabel.text = @"39999.0债券";
    BondLabel.font = [UIFont systemFontOfSize:12];
    BondLabel.textAlignment = NSTextAlignmentRight;
    [imageView addSubview:BondLabel];
    [BondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_left).offset(80);
        make.top.mas_equalTo(ProfitPercentLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    BondTimeLabel = [[UILabel alloc]init];
    BondTimeLabel.text = @"260天期限";
    BondTimeLabel.font = [UIFont systemFontOfSize:12];
    BondTimeLabel.textAlignment = NSTextAlignmentLeft;
    [imageView addSubview:BondTimeLabel];
    [BondTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BondLabel.mas_right).offset(20);
        make.top.mas_equalTo(ProfitPercentLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    PercentProfitLabel = [[UILabel alloc]init];
    PercentProfitLabel.text = @"万份收益";
    PercentProfitLabel.font = [UIFont systemFontOfSize:12];
    PercentProfitLabel.textAlignment = NSTextAlignmentRight;
    [imageView addSubview:PercentProfitLabel];
    [PercentProfitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_left).offset(80);
        make.top.mas_equalTo(BondLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    PercentTimeLabel = [[UILabel alloc]init];
    PercentTimeLabel.text = @"1.23/天";
    PercentTimeLabel.font = [UIFont systemFontOfSize:12];
    PercentTimeLabel.textAlignment = NSTextAlignmentLeft;
    [imageView addSubview:PercentTimeLabel];
    [PercentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(PercentProfitLabel.mas_right).offset(20);
        make.top.mas_equalTo(BondLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    StyleLabel = [[UILabel alloc]init];
    StyleLabel.text = @"稳健型";
    StyleLabel.backgroundColor = [UIColor orangeColor];
    StyleLabel.font = [UIFont systemFontOfSize:11];
    [imageView addSubview:StyleLabel];
    [StyleLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_left).offset(100);
        make.top.mas_equalTo(PercentTimeLabel.mas_bottom).offset(30);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(15);
    }];
    InterestLabel = [[UILabel alloc]init];
    InterestLabel.text = @"到期还本利息";
    InterestLabel.backgroundColor = [UIColor orangeColor];
    InterestLabel.font = [UIFont systemFontOfSize:11];
    [imageView addSubview:InterestLabel];
    [InterestLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(StyleLabel.mas_right).offset(10);
        make.top.mas_equalTo(PercentTimeLabel.mas_bottom).offset(30);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(15);
    }];
    AddPercentLabdel = [[UILabel alloc]init];
    AddPercentLabdel.text = @"满标+0.5%";
    AddPercentLabdel.backgroundColor = [UIColor orangeColor];
    AddPercentLabdel.font = [UIFont systemFontOfSize:11];
    [imageView addSubview:AddPercentLabdel];
    [AddPercentLabdel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(InterestLabel.mas_right).offset(10);
        make.top.mas_equalTo(PercentTimeLabel.mas_bottom).offset(30);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(15);
    }];
    
    UIView *LineView = [[UIView alloc]init];
    LineView.backgroundColor = [UIColor greenColor];
    [imageView addSubview:LineView];
    [LineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_left).offset(10);
        make.top.mas_equalTo(AddPercentLabdel.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH- 20);
        make.height.mas_equalTo(2);
    }];
    LeftLabel = [[UILabel alloc]init];
    LeftLabel.text = @"剩余额度";
    LeftLabel.font = [UIFont systemFontOfSize:14];
    [imageView addSubview:LeftLabel];
    [LeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_left).offset(20);
        make.top.mas_equalTo(LineView.mas_bottom).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    LeftMoneyLabel = [[UILabel alloc]init];
    LeftMoneyLabel.text = @"222222222222.0元";
    LeftMoneyLabel.textAlignment = NSTextAlignmentRight;
    LeftMoneyLabel.font = [UIFont systemFontOfSize:14];
    [imageView addSubview:LeftMoneyLabel];
    [LeftMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(imageView.mas_right).offset(-20);
        make.top.mas_equalTo(LineView.mas_bottom).offset(10);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(30);
    }];
    
 
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
