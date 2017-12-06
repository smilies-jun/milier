//
//  SecondDetailTopTableViewCell.h
//  milier
//
//  Created by amin on 17/5/2.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailModel.h"
#import "ZYProgressView.h"

@interface SecondDetailTopTableViewCell : UITableViewCell{
    UILabel *TitleLabel;
    UILabel *NumberLabel;
    
    CAShapeLayer *ShapeLayer;
    UILabel *ProfitLabel;
    UILabel *ProfitPercentLabel;
    
    UILabel *BondLabel;
    UILabel *BondTimeLabel;
    
    UILabel *PercentProfitLabel;
    UILabel *MoneyPercentLabel;
    UILabel *PercentTimeLabel;
    
    UILabel *StyleLabel;
    UILabel *InterestLabel;
    UILabel *AddPercentLabdel;
    
    UILabel *LeftLabel;
    UILabel *LeftMoneyLabel;
    
    UILabel *DetailStyleLabel;
    UILabel *DetailInterestLabel;
    UILabel *DetailAddPercentLabel;
    UIView *BottomLineView1;
    ZYProgressView *progressView;
    
}

@property (nonatomic, weak) ZYProgressView *progressView;
@property (nonatomic, strong) NSArray *titles;

@property (assign)NSInteger state;
@property (nonatomic ,retain) NSString *increase_type;
@property (nonatomic ,retain) NSString *percent;
@property (nonatomic, strong)ProductDetailModel *detailModel;
@property (assign)int  ProductcatID;


- (void)configUI:(NSIndexPath *)indexPath;


@end
