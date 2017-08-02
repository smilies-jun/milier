//
//  DinQiListTableViewCell.m
//  milier
//
//  Created by amin on 2017/7/26.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "DinQiListTableViewCell.h"

@implementation DinQiListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setFrame:(CGRect)frame{
    frame.size.height -= 20;
    
    [super setFrame:frame];
}
- (void)configUI:(NSIndexPath *)indexPath{
    _ImageView = [[UIView alloc]init];
    _ImageView.backgroundColor = [UIColor orangeColor];
    _ImageView.frame = CGRectMake(0, 25, 2, 60);
    [self addSubview:_ImageView];
    
    _DinQiLabel = [[UILabel alloc]init];
    _DinQiLabel.text = @"21324";
    _DinQiLabel.font = [UIFont systemFontOfSize:13];
    _DinQiLabel.frame = CGRectMake(10, 32, SCREEN_WIDTH-20, 20);
    [self addSubview:_DinQiLabel];
    
    _DinQiDetailLabel = [[UILabel alloc]init];
    _DinQiDetailLabel.text = @"555555";
    _DinQiDetailLabel.textColor = colorWithRGB(0.27, 0.27, 0.27);
    _DinQiDetailLabel.font = [UIFont systemFontOfSize:13];
    _DinQiDetailLabel.frame = CGRectMake(10, 55, SCREEN_WIDTH-20, 20);
    [self addSubview:_DinQiDetailLabel];
    
    UILabel *DinQiNameLabel = [[UILabel alloc]init];
    DinQiNameLabel.text = @"当前资产";
    DinQiNameLabel.font = [UIFont systemFontOfSize:13];
    DinQiNameLabel.frame = CGRectMake(10, 80, 200, 20);
    [self addSubview:DinQiNameLabel];
    
    
    _DinQiNnumberLabel = [[UILabel alloc]init];
    _DinQiNnumberLabel.text = @"232323";
    _DinQiNnumberLabel.textColor = colorWithRGB(0.96, 0.6, 0.11);
    _DinQiNnumberLabel.textAlignment = NSTextAlignmentRight;
    _DinQiNnumberLabel.font = [UIFont systemFontOfSize:12];
    _DinQiNnumberLabel.frame = CGRectMake(SCREEN_WIDTH-200, 80, 100, 18);
    [self addSubview:_DinQiNnumberLabel];
    
    _DinQiTotalNnumberLabel = [[UILabel alloc]init];
    _DinQiTotalNnumberLabel.text = @"232323";
    _DinQiTotalNnumberLabel.textColor = [UIColor blackColor];
    _DinQiTotalNnumberLabel.textAlignment = NSTextAlignmentLeft;
    _DinQiTotalNnumberLabel.font = [UIFont systemFontOfSize:12];
    _DinQiTotalNnumberLabel.frame = CGRectMake(SCREEN_WIDTH- 100, 80, 100, 18);
    [self     addSubview:_DinQiTotalNnumberLabel];




    _StateImageView = [[UIImageView alloc]init];
    _StateImageView.image = [UIImage imageNamed:@"assignment"];
    _StateImageView.frame = CGRectMake(SCREEN_WIDTH - 40, 0, 40, 40);
    [self addSubview:_StateImageView];

    _RowImageView = [[UIImageView alloc]init];
    _RowImageView.image = [UIImage imageNamed:@"goarrow"];
    _RowImageView.frame = CGRectMake(SCREEN_WIDTH - 38, 50, 18, 18);
    [self addSubview:_RowImageView];


    _processView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    _processView.frame = CGRectMake(10, 106,SCREEN_WIDTH-20-30, 6);
    _processView.transform = CGAffineTransformMakeScale(1.0f, 2.0f);
    _processView.progressTintColor = colorWithRGB(0.96, 0.6, 0.12);

    [_processView setProgress:0.5 animated:YES];
    _processView.trackTintColor = colorWithRGB(0.93, 0.93, 0.93);
    [self addSubview:_processView]; 
}

- (void)setDinqiModel:(DinQiModel *)DinqiModel{
    if (DinqiModel != _DinqiModel) {
        _DinqiModel = DinqiModel;

        _DinQiLabel.text = [NSString stringWithFormat:@"%@(%@)",_DinqiModel.name,_DinqiModel.nameSuffix];
        _DinQiDetailLabel.text =  [NSString stringWithFormat:@"预计年化收益 %@",_DinqiModel.subname];
        [_processView setProgress:[_DinqiModel.progress doubleValue]/10000 animated:YES];
        _DinQiNnumberLabel.text = [NSString stringWithFormat:@"%.2f",[_DinqiModel.cci doubleValue]];
        _DinQiTotalNnumberLabel.text =[NSString stringWithFormat:@"%.2f",[_DinqiModel.ci doubleValue]];
        switch ([_DinqiModel.state integerValue]) {
            case 1:
                _StateImageView.image = [UIImage imageNamed:@"raise"];//募集
                
                break;
            case 2:
                _StateImageView.image = [UIImage imageNamed:@"interest"];//计息
                
                break;
            case 3:
                _StateImageView.image = [UIImage imageNamed:@"repayment"];//一到期
                
                break;
            case 4:
                // StateImageView.image = [UIImage imageNamed:@"repayment"];//已还款
                
                break;
            case 5:
                _StateImageView.image = [UIImage imageNamed:@"assignment"];//转让
                
                break;
            default:
                _StateImageView.image = [UIImage imageNamed:@"repayment"];//已到期
                
                break;
        }
        switch ([_DinqiModel.productCategoryId integerValue]) {
            case 1:
                _ImageView.backgroundColor =  colorWithRGB(0.62, 0.80, 0.09);
                
                break;
            case 2:
                _ImageView.backgroundColor = colorWithRGB(0.99, 0.79, 0.09);
                
                break;
            case 3:
                _ImageView.backgroundColor =  colorWithRGB(0.99, 0.52, 0.18);
                
                break;
            case 4:
                _ImageView.backgroundColor =colorWithRGB(0.27, 0.78, 0.96);
                
                break;
            case 5:
                _ImageView.backgroundColor = colorWithRGB(0.31, 0.69, 1);
                
                break;
            case 6:
                _ImageView.backgroundColor = colorWithRGB(0.19, 0.39, 1);
                break;
            case 7:
                _ImageView.backgroundColor = colorWithRGB(0.99, 0.79, 0.09);
                break;
            case 8:
                _ImageView.backgroundColor = colorWithRGB(0.99, 0.79, 0.09);
                break;
            default:
                break;
        }


    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
