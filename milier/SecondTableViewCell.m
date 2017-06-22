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
    _TitleLabel.textColor = colorWithRGB(0.27, 0.27, 0.27);
    _TitleLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_TitleLabel];
    [_TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(20);
        make.left.mas_equalTo(self.contentView.mas_left).offset(20);
        make.width.mas_equalTo(260);
        make.height.mas_equalTo(20);
    }];

    _ProfitLabel = [[UILabel alloc]init];
    _ProfitLabel.font = [UIFont systemFontOfSize:15];
    _ProfitLabel.textColor = colorWithRGB(0.53, 0.53, 0.53);
    _ProfitLabel.text = @"预计年化收益";
    [self.contentView addSubview:_ProfitLabel];
    [_ProfitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_TitleLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.contentView.mas_left).offset(20);
        make.width.mas_equalTo(93);
        make.height.mas_equalTo(20);
    }];
    
    _MoneyLabel = [[UILabel alloc]init];
    _MoneyLabel.text = @"10.32%";
    _MoneyLabel.font = [UIFont systemFontOfSize:26];
    _MoneyLabel.textColor = colorWithRGB(0.99, 0.79, 0.09);
//    NSMutableAttributedString *newAttrStr = [[NSMutableAttributedString alloc] initWithString:@"12.34%"];
//    [newAttrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:26] range:NSMakeRange(0,_MoneyLabel.text.length
//)];
//    [newAttrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:NSMakeRange(_MoneyLabel.text.length - 1
//,1)];
//    _MoneyLabel.attributedText = newAttrStr;
    [self.contentView addSubview:_MoneyLabel];
    [_MoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_ProfitLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(self.contentView.mas_left).offset(20);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(30);
    }];
    
    _limitTimeLabel = [[UILabel alloc]init];
    _limitTimeLabel.text = @"投资期限 6个月";
    _limitTimeLabel.font = [UIFont systemFontOfSize:15];
    _limitTimeLabel.textColor = colorWithRGB(0.53, 0.53, 0.53);
    [self addSubview:_limitTimeLabel];
    [_limitTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_ProfitLabel.mas_right).offset(45);
        make.centerY.mas_equalTo(_ProfitLabel.mas_centerY);
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(15);
    }];
    _ChangeLabel = [[UILabel alloc]init];
    _ChangeLabel.text = @"投资期限 6个月";

    _ChangeLabel.font = [UIFont systemFontOfSize:15];
    _ChangeLabel.textColor = colorWithRGB(0.53, 0.53, 0.53);
    [self addSubview:_ChangeLabel];
    [_ChangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_ProfitLabel.mas_right).offset(45);
        make.top.mas_equalTo(_limitTimeLabel.mas_bottom).offset(3);
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(15);
    }];

    
    _BeginMoneyLabel = [[UILabel alloc]init];
    _BeginMoneyLabel.text = @"起购金额 10000元";
    _BeginMoneyLabel.font = [UIFont systemFontOfSize:15];
    _BeginMoneyLabel.textColor = colorWithRGB(0.53, 0.53, 0.53);
    [self addSubview:_BeginMoneyLabel];
    [_BeginMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_limitTimeLabel.mas_left);
        make.bottom.mas_equalTo(_MoneyLabel.mas_bottom);
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(20);
    }];
    
    _BageLayer = [CAShapeLayer layer];
    _BageLayer.position = self.contentView.center;
    _BageLayer.frame = CGRectMake(SCREEN_WIDTH- 80, 40, 60, 60);//设置shapeLayer的尺寸和位置
    
    _BageLayer.fillColor = [UIColor clearColor].CGColor;//填充颜色为ClearColor
    _BageLayer.strokeStart = 0;
    
    _BageLayer.strokeEnd = 1.0f;
    //设置线条的宽度和颜色
    _BageLayer.lineWidth = 2.0f;
    _BageLayer.strokeColor = colorWithRGB(0.90, 0.90, 0.90).CGColor;
    
    //创建出圆形贝塞尔曲线
    UIBezierPath *BagcirclePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 60, 60)];
    
    //让贝塞尔曲线与CAShapeLayer产生联系
    _BageLayer.path = BagcirclePath.CGPath;
    
    //添加并显示
    [self.contentView.layer addSublayer:_BageLayer];
    
    
    _shapeLayer = [CAShapeLayer layer];
   _shapeLayer.position = self.contentView.center;
    _shapeLayer.frame = CGRectMake(SCREEN_WIDTH- 80, 40, 60, 60);//设置shapeLayer的尺寸和位置

    _shapeLayer.fillColor = [UIColor clearColor].CGColor;//填充颜色为ClearColor
    _shapeLayer.strokeStart = 0;
    
    _shapeLayer.strokeEnd = 0.40f;
    //设置线条的宽度和颜色
    _shapeLayer.lineWidth = 2.0f;
    _shapeLayer.strokeColor = colorWithRGB(0.99, 0.79, 0.09).CGColor;
    
    //创建出圆形贝塞尔曲线
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 60, 60)];
    
    //让贝塞尔曲线与CAShapeLayer产生联系
    _shapeLayer.path = circlePath.CGPath;
    
    //添加并显示
    [self.contentView.layer addSublayer:_shapeLayer];
  
    _PercentLabel = [[UILabel alloc]init];
    _PercentLabel.text = @"售罄";
    _PercentLabel.font = [UIFont systemFontOfSize:13];
    _PercentLabel.textAlignment = NSTextAlignmentCenter;
    _PercentLabel.textColor = [UIColor greenColor];
    _PercentLabel.frame =   CGRectMake(SCREEN_WIDTH- 80,60, 60, 20);
    [self.contentView addSubview:_PercentLabel];
  
    
}

- (void)setProductMoel:(ProuctModel *)productMoel{
    if (productMoel != _productMoel) {
        _productMoel = productMoel;
        _TitleLabel.text = _productMoel.name;
        float interestRate = [[NSString stringWithFormat:@"%@%%",_productMoel.interestRate]floatValue];
        _MoneyLabel.text = [NSString stringWithFormat:@"%.2f%%",interestRate];
        NSInteger limitTime = [[NSString stringWithFormat:@"%@",_productMoel.investmentHorizon] integerValue];
        if ([_productMoel.productCategoryId integerValue] == 6) {
            _limitTimeLabel.text =[NSString stringWithFormat:@"投资期限 %ld天",(long)limitTime];
            _BeginMoneyLabel.text =[NSString stringWithFormat:@"债权包价值 %.2f元",[_productMoel.bondTotal doubleValue]];
            _ChangeLabel.text =[NSString stringWithFormat:@"购买金额 %@元",_productMoel.aggregateAmount];

        }else{
            _limitTimeLabel.text =[NSString stringWithFormat:@"投资期限 %ld个月",(long)limitTime/30];
            _BeginMoneyLabel.text =[NSString stringWithFormat:@"起购金额 %@元",_productMoel.minimumInvestmentAmount];
            _ChangeLabel.hidden = YES;
        }
        
     
        
        
    }
    switch ([_productMoel.productCategoryId integerValue]) {
        case 1:
            _MoneyLabel.textColor = colorWithRGB(0.62, 0.80, 0.09);
            _PercentLabel.textColor = colorWithRGB(0.62, 0.80, 0.09);

            _shapeLayer.strokeColor =colorWithRGB(0.62, 0.80, 0.09).CGColor;

            break;
        case 2:
            _MoneyLabel.textColor = colorWithRGB(0.99, 0.79, 0.09);
            _PercentLabel.textColor = colorWithRGB(0.99, 0.79, 0.09);

            _shapeLayer.strokeColor = colorWithRGB(0.99, 0.79, 0.09).CGColor;
            
            break;
        case 3:
            _MoneyLabel.textColor = colorWithRGB(0.99, 0.52, 0.18);
            _PercentLabel.textColor = colorWithRGB(0.99, 0.52, 0.18);

            _shapeLayer.strokeColor = colorWithRGB(0.99, 0.52, 0.18).CGColor;
            
            break;
        case 4:
            _MoneyLabel.textColor = colorWithRGB(0.27, 0.78, 0.96);
            _PercentLabel.textColor = colorWithRGB(0.27, 0.78, 0.96);

            _shapeLayer.strokeColor = colorWithRGB(0.27, 0.78, 0.96).CGColor;
            
            break;
        case 5:
            _MoneyLabel.textColor = colorWithRGB(0.31, 0.69, 0.10);
            _PercentLabel.textColor =  colorWithRGB(0.31, 0.69, 0.10);

            _shapeLayer.strokeColor = colorWithRGB(0.31, 0.69, 0.10).CGColor;
            
            break;
        case 6:
            _MoneyLabel.textColor = colorWithRGB(0.19, 0.39, 0.9);
            _PercentLabel.textColor = colorWithRGB(0.19, 0.39, 0.9);

            _shapeLayer.strokeColor = colorWithRGB(0.19, 0.39, 0.9).CGColor;
            
            break;
            
        default:
            break;
    }
    
    if ([_productMoel.state intValue] == 2) {
        _PercentLabel.textColor = colorWithRGB(0.99, 0.79, 0.09);
        _PercentLabel.text = [NSString stringWithFormat:@"%@%%",_productMoel.progressMessage];
        _shapeLayer.strokeEnd = [_productMoel.progress floatValue]/100;
        
    }else if ([_productMoel.state intValue]   == 4){
        _PercentLabel.textColor = colorWithRGB(0.53, 0.53, 0.53);
        _PercentLabel.text = @"售罄";
        _shapeLayer.strokeEnd = 1.0f;
        _shapeLayer.strokeColor = colorWithRGB(0.90, 0.90, 0.90).CGColor;
        
        
    }else{
        _PercentLabel.text = @"计息";
        _PercentLabel.textColor = colorWithRGB(0.53, 0.53, 0.53);
        _shapeLayer.strokeEnd = 1.0f;
        _shapeLayer.strokeColor = colorWithRGB(0.90, 0.90, 0.90).CGColor;
        
        
    }
    
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    
    CGContextFillRect(context, rect);
    
    //上分割线，
    //CGContextSetStrokeColorWithColor(context, COLORWHITE.CGColor);
    //CGContextStrokeRect(context, CGRectMake(5, -1, rect.size.width - 10, 1));
    
    //下分割线
    CGContextSetStrokeColorWithColor(context,colorWithRGB(0.83, 0.83, 0.83).CGColor);
    CGContextStrokeRect(context,CGRectMake(0, rect.size.height-0.5, SCREEN_WIDTH,0.5));
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
