//
//  CYXPhotoCell.m
//  CYCollectionViewTest
//
//  Created by apple开发 on 16/3/8.
//  Copyright © 2016年 cyx. All rights reserved.
//

#import "CYXPhotoCell.h"

@interface CYXPhotoCell ()

@property (nonatomic, weak) UIImageView *imageView; /**< <#注释#> */

@end

@implementation CYXPhotoCell

- (void)configUI:(NSIndexPath *)indexPath{
    self.layer.borderWidth = 2;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 15.0;

    UIImageView  *imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    imageView.backgroundColor = [UIColor redColor];
    imageView.userInteractionEnabled = YES;
    [self.contentView addSubview:imageView];

    _TitleLabel = [[UILabel alloc]init];
    _TitleLabel.userInteractionEnabled = YES;
    _TitleLabel.font = [UIFont systemFontOfSize:14];
    _TitleLabel.text =  @"1/10题";
    _TitleLabel.textColor = [UIColor whiteColor];
    _TitleLabel.frame = CGRectMake(20, 20, 120, 10);
    [imageView addSubview:_TitleLabel];
    
    _FirstLabel = [[UILabel alloc]init];
    _FirstLabel.userInteractionEnabled = YES;
    _FirstLabel.text = @"111111111111111";
    _FirstLabel.tag = 100+indexPath.row;
    _FirstLabel.font = [UIFont systemFontOfSize:11];
    _FirstLabel.textColor = [UIColor whiteColor];
    _FirstLabel.frame = CGRectMake(20, 20*1+20, 120, 10);
    [imageView addSubview:_FirstLabel];

    _SecondLabel = [[UILabel alloc]init];
    _SecondLabel.userInteractionEnabled = YES;
    _SecondLabel.text = @"111111111111111";

    _SecondLabel.frame = CGRectMake(20, 20*2+20, 120, 10);
    _SecondLabel.tag = 200+indexPath.row;
    _SecondLabel.font = [UIFont systemFontOfSize:11];
    _SecondLabel.textColor = [UIColor whiteColor];
    [imageView addSubview:_SecondLabel];

    _ThreeLabel = [[UILabel alloc]init];
    _ThreeLabel.userInteractionEnabled = YES;
    _ThreeLabel.text = @"111111111111111";

    _ThreeLabel.frame = CGRectMake(20, 20*3+20, 120, 10);
    _ThreeLabel.tag = 300+indexPath.row;
    _ThreeLabel.font = [UIFont systemFontOfSize:11];
    _ThreeLabel.textColor = [UIColor whiteColor];
    [imageView addSubview:_ThreeLabel];

    _FourLabel = [[UILabel alloc]init];
    _FourLabel.userInteractionEnabled = YES;
    _FourLabel.text = @"111111111111111";

    _FourLabel.frame = CGRectMake(20, 20*4+20, 120, 10);
    _FourLabel.tag = 400 +indexPath.row;
    _FourLabel.font = [UIFont systemFontOfSize:11];
    _FourLabel.textColor = [UIColor whiteColor];
    [imageView addSubview:_FourLabel];

    _FiveLabel = [[UILabel alloc]init];
    _FiveLabel.userInteractionEnabled = YES;
    _FiveLabel.text = @"111111111111111";

    _FiveLabel.frame = CGRectMake(20, 20*5+20, 120, 10);
    _FiveLabel.tag = 500+indexPath.row;
    _FiveLabel.font = [UIFont systemFontOfSize:11];
    _FiveLabel.textColor = [UIColor whiteColor];
    [imageView addSubview:_FiveLabel];

    

}
- (void)setRiskModel:(RiskModel *)riskModel{
    if (riskModel != _riskModel) {
        _riskModel = riskModel;
        
    }
}
- (void)setImageName:(NSString *)imageName{
    
    _imageName = [imageName copy];
    
    self.imageView.image = [UIImage imageNamed:imageName];
    
}

@end
