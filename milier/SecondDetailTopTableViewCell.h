//
//  SecondDetailTopTableViewCell.h
//  milier
//
//  Created by amin on 17/5/2.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailModel.h"

@interface SecondDetailTopTableViewCell : UITableViewCell{
    UILabel *TitleLabel;
    UILabel *NumberLabel;
    
    CAShapeLayer *ShapeLayer;
    UILabel *ProfitLabel;
    UILabel *ProfitPercentLabel;
    
    UILabel *BondLabel;
    UILabel *BondTimeLabel;
    
    UILabel *PercentProfitLabel;
    UILabel *PercentTimeLabel;
    
    UILabel *StyleLabel;
    UILabel *InterestLabel;
    UILabel *AddPercentLabdel;
    
    UILabel *LeftLabel;
    UILabel *LeftMoneyLabel;
    
    UILabel *DetailStyleLabel;
    UILabel *DetailInterestLabel;
    UILabel *DetailAddPercentLabel;
}
@property (nonatomic, strong)ProductDetailModel *detailModel;

@property (assign)int  ProductcatID;


- (void)configUI:(NSIndexPath *)indexPath;


@end
