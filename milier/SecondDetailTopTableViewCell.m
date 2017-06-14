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
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 480)];
    [self addSubview:imageView];
    TitleLabel = [[UILabel alloc]init];
    TitleLabel.text = @"";
    TitleLabel.font = [UIFont systemFontOfSize:18];
    TitleLabel.textAlignment = NSTextAlignmentCenter;
    [imageView addSubview:TitleLabel];
    [TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_left);
        make.top.mas_equalTo(imageView.mas_top).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(30);
        
    }];
    NumberLabel = [[UILabel alloc]init];
    NumberLabel.text = @"";
    NumberLabel.textColor = colorWithRGB(0.63, 0.63, 0.63);
    NumberLabel.font = [UIFont systemFontOfSize:12];
    NumberLabel.textAlignment = NSTextAlignmentCenter;
    [imageView addSubview:NumberLabel];
    [NumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_left);
        make.top.mas_equalTo(TitleLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(10);
        
    }];
    ShapeLayer = [CAShapeLayer layer];
    ShapeLayer.fillColor = [UIColor clearColor].CGColor;//填充颜色为ClearColor
    //设置线条的宽度和颜色
    ShapeLayer.lineWidth = 8.0f;
    //创建出圆形贝塞尔曲线
    UIBezierPath *circlePath =  [UIBezierPath bezierPathWithArcCenter:CGPointMake(imageView.centerX, imageView.centerY-60) radius:110 startAngle:0.75f*M_PI endAngle:0.25f*M_PI clockwise:YES];
    
    //让贝塞尔曲线与CAShapeLayer产生联系
    ShapeLayer.path = circlePath.CGPath;
    
    //添加并显示
    [imageView.layer addSublayer:ShapeLayer];
    
    ProfitLabel  = [[UILabel alloc]init];
    ProfitLabel.text = @"预计年化收益";
    ProfitLabel.textColor = colorWithRGB(0.63, 0.63, 0.63);
    ProfitLabel.font = [UIFont systemFontOfSize:15];
    ProfitLabel.textAlignment = NSTextAlignmentCenter;
    [imageView addSubview:ProfitLabel];
    [ProfitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(NumberLabel.mas_centerX);
        make.top.mas_equalTo(NumberLabel.mas_bottom).offset(60);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
    }];
    
    ProfitPercentLabel  = [[UILabel alloc]init];
    ProfitPercentLabel.text = @"12.34%";
    NSMutableAttributedString *newAttrStr = [[NSMutableAttributedString alloc] initWithString:@"12.34%"];
    [newAttrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:30] range:NSMakeRange(0,ProfitPercentLabel.text.length
                                                                                                          )];
    [newAttrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:NSMakeRange(ProfitPercentLabel.text.length - 1
                                                                                                          ,1)];
    ProfitPercentLabel.attributedText = newAttrStr;
    ProfitPercentLabel.textAlignment = NSTextAlignmentCenter;
    [imageView addSubview:ProfitPercentLabel];
    [ProfitPercentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(NumberLabel.mas_centerX);
        make.top.mas_equalTo(ProfitLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(30);
    }];
    
    BondLabel = [[UILabel alloc]init];
    BondLabel.text = @"1000000元起购";
    BondLabel.font = [UIFont systemFontOfSize:12];
    BondLabel.textAlignment = NSTextAlignmentCenter;
    [imageView addSubview:BondLabel];
    [BondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ProfitLabel.mas_centerX);
        make.top.mas_equalTo(ProfitPercentLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    BondTimeLabel = [[UILabel alloc]init];
    BondTimeLabel.text = @"260天期限";
    BondTimeLabel.font = [UIFont systemFontOfSize:12];
    BondTimeLabel.textAlignment = NSTextAlignmentCenter;
    [imageView addSubview:BondTimeLabel];
    [BondTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(BondLabel.mas_centerX);
        make.top.mas_equalTo(BondLabel.mas_bottom).offset(2);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    PercentProfitLabel = [[UILabel alloc]init];
    PercentProfitLabel.text = @"万份收益1.23/天";
    PercentProfitLabel.font = [UIFont systemFontOfSize:12];
    PercentProfitLabel.textAlignment = NSTextAlignmentCenter;
    [imageView addSubview:PercentProfitLabel];
    [PercentProfitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(BondLabel.mas_centerX);
        make.top.mas_equalTo(BondTimeLabel.mas_bottom).offset(2);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    UIView *LineView = [[UIView alloc]init];
    LineView.backgroundColor = colorWithRGB(0.83, 0.83, 0.83);
    [imageView addSubview:LineView];
    [LineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_left).offset(10);
        make.top.mas_equalTo(PercentProfitLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH- 20);
        make.height.mas_equalTo(0.5);
    }];
    LeftLabel = [[UILabel alloc]init];
    LeftLabel.text = @"剩余额度";
    LeftLabel.font = [UIFont systemFontOfSize:15];
    [imageView addSubview:LeftLabel];
    [LeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_left).offset(20);
        make.top.mas_equalTo(LineView.mas_bottom).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    LeftMoneyLabel = [[UILabel alloc]init];
    LeftMoneyLabel.text = @"0.0元";
    LeftMoneyLabel.textAlignment = NSTextAlignmentRight;
    LeftMoneyLabel.font = [UIFont systemFontOfSize:15];
    [imageView addSubview:LeftMoneyLabel];
    [LeftMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(imageView.mas_right).offset(-20);
        make.top.mas_equalTo(LineView.mas_bottom).offset(10);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(30);
    }];
    UIView *BottomLineView = [[UIView alloc]init];
    BottomLineView.backgroundColor = colorWithRGB(0.97, 0.97, 0.97);
    [self.contentView addSubview:BottomLineView];
    [BottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.top.mas_equalTo(LeftMoneyLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(5);
    }];
    
   
 
}
- (void)setDetailModel:(ProductDetailModel *)detailModel{
    if (detailModel != _detailModel) {
        
       
        
        _detailModel = detailModel;
        switch (_ProductcatID) {
            case 1:
                TitleLabel.textColor = colorWithRGB(0.62, 0.80, 0.09);
                ShapeLayer.strokeColor = colorWithRGB(0.62, 0.80, 0.09).CGColor;
                LeftMoneyLabel.textColor = colorWithRGB(0.62, 0.80, 0.09);
                ProfitPercentLabel.textColor = colorWithRGB(0.62, 0.80, 0.09);
                
                
                
                break;
            case 2:
                TitleLabel.textColor = colorWithRGB(0.99, 0.79, 0.09);
                ShapeLayer.strokeColor = colorWithRGB(0.99, 0.79, 0.09).CGColor;
                LeftMoneyLabel.textColor = colorWithRGB(0.99, 0.79, 0.09);
                ProfitPercentLabel.textColor = colorWithRGB(0.99, 0.79, 0.09);
                
                break;
            case 3:
                TitleLabel.textColor = colorWithRGB(0.99, 0.52, 0.18);
                ShapeLayer.strokeColor = colorWithRGB(0.99, 0.52, 0.18).CGColor;
                LeftMoneyLabel.textColor = colorWithRGB(0.99, 0.52, 0.18);
                ProfitPercentLabel.textColor = colorWithRGB(0.99, 0.52, 0.18);
                
                break;
            case 4:
                TitleLabel.textColor = colorWithRGB(0.27, 0.78, 0.96);
                ShapeLayer.strokeColor = colorWithRGB(0.27, 0.78, 0.96).CGColor;
                LeftMoneyLabel.textColor = colorWithRGB(0.27, 0.78, 0.96);
                ProfitPercentLabel.textColor = colorWithRGB(0.27, 0.78, 0.96);
                
                break;
            case 5:
                TitleLabel.textColor = colorWithRGB(0.31, 0.69, 0.10);
                ShapeLayer.strokeColor = colorWithRGB(0.31, 0.69, 0.10).CGColor;
                LeftMoneyLabel.textColor = colorWithRGB(0.31, 0.69, 0.10);
                ProfitPercentLabel.textColor = colorWithRGB(0.31, 0.69, 0.10);
                
                break;
            case 6:
                TitleLabel.textColor = colorWithRGB(0.19, 0.39, 0.9);
                ShapeLayer.strokeColor = colorWithRGB(0.19, 0.39, 0.9).CGColor;
                LeftMoneyLabel.textColor = colorWithRGB(0.19, 0.39, 0.9);
                ProfitPercentLabel.textColor = colorWithRGB(0.19, 0.39, 0.9);
                
                break;
                
            default:
                break;
        }
        if (_ProductcatID == 6) {
            TitleLabel.text = [NSString stringWithFormat:@"%@",_detailModel.name];
            NumberLabel.text = [NSString stringWithFormat:@"项目编号：%@",_detailModel.productNo];
            ProfitPercentLabel.text = [NSString stringWithFormat:@"%.2f%%",[_detailModel.interestRate doubleValue] ];
            
            BondLabel.text = [NSString stringWithFormat:@"%@元债权",_detailModel.bondTotal];
            if ([_detailModel.oid integerValue] == 375) {
                BondTimeLabel.text = @"随时提现";
                
            }else{
                BondTimeLabel.text = [NSString stringWithFormat:@"%@天期限",_detailModel.investmentHorizon];
                
            }
            
            PercentProfitLabel.text = [NSString stringWithFormat:@"万份收益%@/天",_detailModel.tenThousandIncome];
            
            
            NSString *totalStr = [NSString stringWithFormat:@"%@",_detailModel.aggregateAmount];
            double totalDouble = [totalStr doubleValue];
            
            NSString *sellStr = [NSString stringWithFormat:@"%@",_detailModel.sellTotal];
            double sellDouble = [sellStr doubleValue];
            
            LeftMoneyLabel.text = [NSString stringWithFormat:@"%.2f元",totalDouble - sellDouble];
        }else{
            TitleLabel.text = [NSString stringWithFormat:@"%@",_detailModel.name];
            NumberLabel.text = [NSString stringWithFormat:@"项目编号：%@",_detailModel.productNo];
            ProfitPercentLabel.text = [NSString stringWithFormat:@"%.2f%%",[_detailModel.interestRate doubleValue] ];
            BondLabel.text = [NSString stringWithFormat:@"%@元起购",_detailModel.minimumInvestmentAmount];
            if ([_detailModel.oid integerValue] == 375) {
                BondTimeLabel.text = @"随时提现";
                
            }else{
                BondTimeLabel.text = [NSString stringWithFormat:@"%@天期限",_detailModel.investmentHorizon];
                
            }
            
            PercentProfitLabel.text = [NSString stringWithFormat:@"万份收益%@/天",_detailModel.tenThousandIncome];
            NSString *totalStr = [NSString stringWithFormat:@"%@",_detailModel.aggregateAmount];
            double totalDouble = [totalStr doubleValue];
            
            NSString *sellStr = [NSString stringWithFormat:@"%@",_detailModel.sellTotal];
            double sellDouble = [sellStr doubleValue];
            
            LeftMoneyLabel.text = [NSString stringWithFormat:@"%.2f元",totalDouble - sellDouble];
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
