//
//  DinQiTopTableViewCell.m
//  milier
//
//  Created by amin on 2017/7/26.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "DinQiTopTableViewCell.h"


@implementation DinQiTopTableViewCell



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setFrame:(CGRect)frame{
    frame.size.height -= 20;

    [super setFrame:frame];
}
- (void)configUI:(NSIndexPath *)indexPath{
    self.pieChart = [[ZFPieChart alloc] initWithFrame:CGRectMake(40, 30, 100, 100)];
    self.pieChart.userInteractionEnabled = NO;
    self.pieChart.dataSource= self;
    self.pieChart.delegate = self;
    self.pieChart.piePatternType = kPieChartPatternTypeForCirque;
    self.pieChart.isShadow = NO;
    self.pieChart.isShowPercent = NO;
    [self.pieChart strokePath];
    [self  addSubview:self.pieChart];
    
//    UILabel *TitleLabel = [[UILabel alloc]init];
//    TitleLabel.textAlignment = NSTextAlignmentCenter;
//    TitleLabel.text = @"在投资产";
//    TitleLabel.font = [UIFont systemFontOfSize:15];
//    TitleLabel.textColor = colorWithRGB(0.53, 0.53, 0.53);
//    [self.pieChart addSubview:TitleLabel];
//    [TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.pieChart.mas_centerX);
//        make.top.mas_equalTo(self.mas_top).offset(60);
//        make.width.mas_equalTo(80);
//        make.height.mas_equalTo(15);
//    }];
//    
//    UILabel *MoneyLabel = [[UILabel alloc]init];
//    MoneyLabel.textAlignment = NSTextAlignmentCenter;
//    MoneyLabel.text = @"234";
//    MoneyLabel.font = [UIFont systemFontOfSize:16];
//    [self.pieChart addSubview:MoneyLabel];
//    [MoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(TitleLabel.mas_centerX);
//        make.top.mas_equalTo(TitleLabel.mas_bottom).offset(5);
//        make.width.mas_equalTo(100);
//        make.height.mas_equalTo(20);
//    }];

    UIImageView *FirstImageView = [[UIImageView alloc]init];
    FirstImageView.layer.cornerRadius = 5;
    FirstImageView.clipsToBounds = YES;
    FirstImageView.backgroundColor = colorWithRGB(0.62, 0.80, 0.09);
    [self addSubview:FirstImageView];
    [FirstImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-170);
        make.top.mas_equalTo(self.mas_top).offset(40);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
    }];
    _FirstCircleLabel = [[UILabel alloc]init];
    _FirstCircleLabel.textColor = colorWithRGB(0.53, 0.53, 0.53);

    _FirstCircleLabel.textAlignment = NSTextAlignmentLeft;
    _FirstCircleLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_FirstCircleLabel];
    [_FirstCircleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(FirstImageView.mas_centerY);
        make.left.mas_equalTo(FirstImageView.mas_right).offset(5);
        make.width.mas_equalTo(130);
        make.height.mas_equalTo(20);
    }];
    
    UIImageView *SecondImageView = [[UIImageView alloc]init];
    SecondImageView.layer.cornerRadius = 5;
    SecondImageView.clipsToBounds = YES;
    
    SecondImageView.backgroundColor = colorWithRGB(0.99, 0.79, 0.09);
    [self addSubview:SecondImageView];
    [SecondImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(FirstImageView.mas_centerX);
        make.top.mas_equalTo(FirstImageView.mas_bottom).offset(5);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
    }];
    _SecondCircleLabel = [[UILabel alloc]init];
    _SecondCircleLabel.textColor = colorWithRGB(0.53, 0.53, 0.53);
    _SecondCircleLabel.textAlignment = NSTextAlignmentLeft;
    _SecondCircleLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_SecondCircleLabel];
    [_SecondCircleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(SecondImageView.mas_centerY);
        make.left.mas_equalTo(SecondImageView.mas_right).offset(5);
        make.width.mas_equalTo(130);
        make.height.mas_equalTo(20);
    }];
    
    UIImageView *ThirdImageView = [[UIImageView alloc]init];
    ThirdImageView.layer.cornerRadius = 5;
    ThirdImageView.clipsToBounds = YES;
    
    ThirdImageView.backgroundColor = colorWithRGB(0.99, 0.52, 0.18);
    [self addSubview:ThirdImageView];
    [ThirdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-170);
        make.top.mas_equalTo(SecondImageView.mas_bottom).offset(5);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
    }];
    _ThirdCircleLabel = [[UILabel alloc]init];
    _ThirdCircleLabel.textColor = colorWithRGB(0.53, 0.53, 0.53);
    _ThirdCircleLabel.textAlignment = NSTextAlignmentLeft;
    _ThirdCircleLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_ThirdCircleLabel];
    [_ThirdCircleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(ThirdImageView.mas_centerY);
        make.left.mas_equalTo(ThirdImageView.mas_right).offset(5);
        make.width.mas_equalTo(130);
        make.height.mas_equalTo(20);
    }];
    
    
    UIImageView *FourImageView = [[UIImageView alloc]init];
    FourImageView.layer.cornerRadius = 5;
    FourImageView.clipsToBounds = YES;
    
    FourImageView.backgroundColor = colorWithRGB(0.27, 0.78, 0.96);
    [self addSubview:FourImageView];
    [FourImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-170);
        make.top.mas_equalTo(ThirdImageView.mas_bottom).offset(5);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
    }];
    _FourCircleLabel = [[UILabel alloc]init];
    _FourCircleLabel.textColor = colorWithRGB(0.53, 0.53, 0.53);
    _FourCircleLabel.textAlignment = NSTextAlignmentLeft;
    _FourCircleLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_FourCircleLabel];
    [_FourCircleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(FourImageView.mas_centerY);
        make.left.mas_equalTo(FourImageView.mas_right).offset(5);
        make.width.mas_equalTo(130);
        make.height.mas_equalTo(20);
    }];
    
    UIImageView *FiveImageView = [[UIImageView alloc]init];
    FiveImageView.layer.cornerRadius = 5;
    FiveImageView.clipsToBounds = YES;
    
    FiveImageView.backgroundColor = colorWithRGB(0.31, 0.69, 1);
    [self addSubview:FiveImageView];
    [FiveImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self .mas_right).offset(-170);
        make.top.mas_equalTo(FourImageView.mas_bottom).offset(5);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
    }];
    _FiveCircleLabel = [[UILabel alloc]init];
    _FiveCircleLabel.textColor = colorWithRGB(0.53, 0.53, 0.53);
    _FiveCircleLabel.textAlignment = NSTextAlignmentLeft;
    _FiveCircleLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_FiveCircleLabel];
    [_FiveCircleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(FiveImageView.mas_centerY);
        make.left.mas_equalTo(FiveImageView.mas_right).offset(5);
        make.width.mas_equalTo(130);
        make.height.mas_equalTo(20);
    }];
    
    
    UIImageView *SixImageView = [[UIImageView alloc]init];
    SixImageView.layer.cornerRadius = 5;
    SixImageView.clipsToBounds = YES;
    SixImageView.backgroundColor = colorWithRGB(0.19, 0.39, 0.9);
    [self addSubview:SixImageView];
    [SixImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-170);
        make.top.mas_equalTo(FiveImageView.mas_bottom).offset(5);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
    }];
    _SixCircleLabel = [[UILabel alloc]init];
    _SixCircleLabel.textColor = colorWithRGB(0.53, 0.53, 0.53);
    _SixCircleLabel.textAlignment = NSTextAlignmentLeft;
    _SixCircleLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_SixCircleLabel];
    [_SixCircleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(SixImageView.mas_centerY);
        make.left.mas_equalTo(SixImageView.mas_right).offset(5);
        make.width.mas_equalTo(130);
        make.height.mas_equalTo(20);
    }];
    UIView *ImageLineView  = [[UIView alloc]init];
    ImageLineView.backgroundColor = [UIColor whiteColor];
    [self addSubview:ImageLineView];
    [ImageLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.top.mas_equalTo(_SixCircleLabel.mas_bottom).offset(40);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(1);
    }];
    //昨日收益
    UIView *OldView = [[UIView alloc]init];
    OldView.userInteractionEnabled = YES;
    OldView.backgroundColor = [UIColor whiteColor];
    [self addSubview:OldView];
    [OldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.top.mas_equalTo(ImageLineView.mas_bottom).offset(0.5);
        make.width.mas_equalTo(SCREEN_WIDTH/2);
        make.height.mas_equalTo(60);
    }];
    UIView *segeLineView = [[UIView alloc]init];
    segeLineView.backgroundColor = [UIColor whiteColor];
    [self addSubview:segeLineView];
    [segeLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(OldView.mas_right);
        make.centerY.mas_equalTo(OldView.mas_centerY);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(50);
    }];
    UILabel *OldNamelabel = [[UILabel alloc]init];
    OldNamelabel.text = @"昨日收益";
    OldNamelabel.textAlignment = NSTextAlignmentCenter;
    OldNamelabel.font = [UIFont systemFontOfSize:12];
    OldNamelabel.textColor = colorWithRGB(0.61, 0.61, 0.61);
    [OldView addSubview:OldNamelabel];
    [OldNamelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(OldView.mas_left);
        make.top.mas_equalTo(ImageLineView.mas_bottom).offset(5);
        make.width.mas_equalTo(SCREEN_WIDTH/2);
        make.height.mas_equalTo(20);
    }];
    _OldLabel = [[UILabel alloc]init];
    _OldLabel.textAlignment = NSTextAlignmentCenter;
    _OldLabel.textColor = [UIColor orangeColor];
    _OldLabel.font = [UIFont systemFontOfSize:14];
    [OldView addSubview:_OldLabel];
    [_OldLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(OldNamelabel.mas_left);
        make.top.mas_equalTo(OldNamelabel.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH/2);
        make.height.mas_equalTo(30);
    }];
    _OldDetailLabel = [UIButton buttonWithType:UIButtonTypeCustom];
    [_OldDetailLabel setTitle:@"详情" forState:UIControlStateNormal];
  
    _OldDetailLabel.layer.borderColor = ZFOrange.CGColor;
    _OldDetailLabel.layer.borderWidth = 0.5f;
    _OldDetailLabel.layer.masksToBounds = YES;
    _OldDetailLabel.layer.cornerRadius = 10;
    [_OldDetailLabel setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    _OldDetailLabel.titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_OldDetailLabel];
    [_OldDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_OldLabel.mas_centerX);
        make.top.mas_equalTo(_OldLabel.mas_bottom);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(20);
    }];
    
    UIView *AddView = [[UIView alloc]init];
    AddView.userInteractionEnabled = YES;
    AddView.backgroundColor = [UIColor whiteColor];
    [self addSubview:AddView];
    [AddView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right);
        make.top.mas_equalTo(ImageLineView.mas_bottom).offset(0.5);
        make.width.mas_equalTo(SCREEN_WIDTH/2);
        make.height.mas_equalTo(60);
    }];
    UILabel *AddNamelabel = [[UILabel alloc]init];
    AddNamelabel.textAlignment = NSTextAlignmentCenter;
    AddNamelabel.text = @"累计收益";
    AddNamelabel.font = [UIFont systemFontOfSize:12];
    AddNamelabel.textColor = colorWithRGB(0.61, 0.61, 0.61);
    [AddView addSubview:AddNamelabel];
    [AddNamelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(AddView.mas_left);
        make.top.mas_equalTo(ImageLineView.mas_bottom).offset(5);
        make.width.mas_equalTo(SCREEN_WIDTH/2);
        make.height.mas_equalTo(20);
    }];
    _AddLabel = [[UILabel alloc]init];
    _AddLabel.textAlignment = NSTextAlignmentCenter;
    _AddLabel.textColor = [UIColor orangeColor];
    _AddLabel.font = [UIFont systemFontOfSize:14];
    [AddView addSubview:_AddLabel];
    [_AddLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(AddView.mas_left);
        make.top.mas_equalTo(AddNamelabel.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH/2);
        make.height.mas_equalTo(30);
    }];
    _AddDetailLabel = [[UILabel alloc]init];
    _AddDetailLabel.text = @"详情";
    _AddDetailLabel.userInteractionEnabled = YES;
    _AddDetailLabel.layer.borderColor = ZFOrange.CGColor;
    _AddDetailLabel.layer.borderWidth = 0.5f;
    _AddDetailLabel.layer.masksToBounds = YES;
    _AddDetailLabel.layer.cornerRadius = 10;
    _AddDetailLabel.textAlignment = NSTextAlignmentCenter;
    _AddDetailLabel.textColor = [UIColor orangeColor];
    _AddDetailLabel.font = [UIFont systemFontOfSize:14];
    [self  addSubview:_AddDetailLabel];
    [_AddDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_AddLabel.mas_centerX);
        make.top.mas_equalTo(_AddLabel.mas_bottom);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(20);
    }];

}
- (void)setTopModel:(DinQiTopModel *)topModel{
    if (topModel != _topModel) {
        _topModel = topModel;
        _FirstCircleLabel.text =[NSString stringWithFormat:@"网贷基金   %@",_topModel.p2pLoanInvestmentAmount];
        _SecondCircleLabel.text = [NSString stringWithFormat:@"新手专享   %@",_topModel.noviceExclusiveInvestmentAmount];
        _ThirdCircleLabel.text = [NSString stringWithFormat:@"企业贷款   %@",_topModel.enterpriseLoanInvestmentAmount];
        _FourCircleLabel.text = [NSString stringWithFormat:@"个人贷款   %@",_topModel.personalLoanInvestmentAmount];
        _FiveCircleLabel.text = [NSString stringWithFormat:@"购车贷款   %@",_topModel.carLoanInvestmentAmount];
        _SixCircleLabel.text =[NSString stringWithFormat:@"债权转让   %@",_topModel.debentureTransferInvestmentAmount];
        _OldLabel.text = [NSString stringWithFormat:@"¥%.2f",[_topModel.yesterdayEarnings doubleValue]];
        _AddLabel.text =[NSString stringWithFormat:@"¥%.2f",[_topModel.accumulatedEarnings doubleValue]];

        
        double p2p1 = [_topModel.p2pLoanInvestmentAmount doubleValue];
        double p2p2 =[_topModel.noviceExclusiveInvestmentAmount doubleValue];
        double p2p3 =[_topModel.enterpriseLoanInvestmentAmount doubleValue] ;
        double p2p4 =[_topModel.personalLoanInvestmentAmount doubleValue];
        double p2p5 = [_topModel.carLoanInvestmentAmount doubleValue];
        double p2p6 =[_topModel.debentureTransferInvestmentAmount doubleValue] ;
        double value1; double value2; double value3; double value4; double value5; double value6;
        if (p2p1) {
            value1 = p2p1;
        }else{
            value1 = 0;
            
        }
        
        if (p2p2) {
            value2 = p2p2;
            
        }else{
            value2 =0;
            
        }
        if (p2p3) {
            value3 = p2p3;
            
        }else{
            value3 = 0;
            
        }
        if (p2p4) {
            value4 = p2p4;
            
            
        }else{
            value4 = 0;
            
        }
        if (p2p5) {
            value5 = p2p6;
            
            
        }else{
            value5 = 0;
            
        }
        if (p2p6) {
            value6 = p2p6;
            
            
        }else{
            value6 = 0;
            
        }
        _myArray  = [[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"%.2f",value1],[NSString stringWithFormat:@"%.2f",value2],[NSString stringWithFormat:@"%.2f",value3],[NSString stringWithFormat:@"%.2f",value4],[NSString stringWithFormat:@"%.2f",value5],[NSString stringWithFormat:@"%.2f",value6], nil];
        
        
        [_pieChart strokePath];
        
        UILabel *TitleLabel = [[UILabel alloc]init];
        TitleLabel.textAlignment = NSTextAlignmentCenter;
        TitleLabel.text = @"在投资产";
        TitleLabel.font = [UIFont systemFontOfSize:15];
        TitleLabel.textColor = colorWithRGB(0.53, 0.53, 0.53);
        [self.pieChart addSubview:TitleLabel];
        [TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.pieChart.mas_centerX);
            make.top.mas_equalTo(self.mas_top).offset(60);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(15);
        }];
        
        UILabel *MoneyLabel = [[UILabel alloc]init];
        MoneyLabel.textAlignment = NSTextAlignmentCenter;
        if ([topModel.investmentAmount integerValue]) {
            MoneyLabel.text =[NSString stringWithFormat:@"%@",topModel.investmentAmount];

        }else{
            MoneyLabel.text =@"0.0";

        }
        MoneyLabel.font = [UIFont systemFontOfSize:16];
        [self.pieChart addSubview:MoneyLabel];
        [MoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(TitleLabel.mas_centerX);
            make.top.mas_equalTo(TitleLabel.mas_bottom).offset(5);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(20);
        }];

    }
}
#pragma mark - ZFPieChartDataSource

- (NSArray *)valueArrayInPieChart:(ZFPieChart *)chart{
    if ([[_myArray objectAtIndex:0]integerValue]==0 && [[_myArray objectAtIndex:1]integerValue]==0 && [[_myArray objectAtIndex:2]integerValue]==0 && [[_myArray objectAtIndex:3]integerValue]==0 &&[[_myArray objectAtIndex:4]integerValue]==0 &&[[_myArray objectAtIndex:5]integerValue]==0) {
        
        return @[@"100"];
    }else{
        return _myArray;
        
    }

}

- (NSArray *)colorArrayInPieChart:(ZFPieChart *)chart{

    if ([[_myArray objectAtIndex:0]integerValue]==0 && [[_myArray objectAtIndex:1]integerValue]==0 && [[_myArray objectAtIndex:2]integerValue]==0 && [[_myArray objectAtIndex:3]integerValue]==0 &&[[_myArray objectAtIndex:4]integerValue]==0 &&[[_myArray objectAtIndex:5]integerValue]==0) {
        return @[colorWithRGB(0.83, 0.83, 0.83)];
    }else{
        return @[colorWithRGB(0.62, 0.80, 0.09),colorWithRGB(0.99, 0.79, 0.09), colorWithRGB(0.99, 0.52, 0.18), colorWithRGB(0.31, 0.69, 1), colorWithRGB(0.27, 0.78, 0.96), colorWithRGB(0.19, 0.39, 0.9)];
    }

    
}

#pragma mark - ZFPieChartDelegate

- (void)pieChart:(ZFPieChart *)pieChart didSelectPathAtIndex:(NSInteger)index{
    NSLog(@"第%ld个",(long)index);
}

- (CGFloat)allowToShowMinLimitPercent:(ZFPieChart *)pieChart{
    return 5.f;
}

- (CGFloat)radiusForPieChart:(ZFPieChart *)pieChart{
    return 80.f;
}

/** 此方法只对圆环类型(kPieChartPatternTypeForCirque)有效 */
- (CGFloat)radiusAverageNumberOfSegments:(ZFPieChart *)pieChart{
    return 2.f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
