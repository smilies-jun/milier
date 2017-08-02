//
//  DinQiTopTableViewCell.h
//  milier
//
//  Created by amin on 2017/7/26.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFChart.h"
#import "DinQiTopModel.h"

@interface DinQiTopTableViewCell : UITableViewCell<ZFPieChartDelegate,ZFPieChartDataSource>

@property (nonatomic, strong) ZFPieChart * pieChart;

@property (nonatomic, strong)UILabel *FirstCircleLabel;

@property (nonatomic, strong)UILabel *SecondCircleLabel;

@property (nonatomic, strong)UILabel *ThirdCircleLabel;

@property (nonatomic, strong)UILabel *FourCircleLabel;

@property (nonatomic, strong)UILabel *FiveCircleLabel;

@property (nonatomic, strong)UILabel *SixCircleLabel;



@property (nonatomic, strong)UILabel *OldLabel;
@property (nonatomic, strong)UILabel *AddLabel;

@property (nonatomic, strong)UIButton *OldDetailLabel;

@property (nonatomic, strong)UILabel *AddDetailLabel;

@property (nonatomic,retain)DinQiTopModel *topModel;

@property (nonatomic,retain)NSArray *myArray;

- (void)setTopModel:(DinQiTopModel *)topModel;

- (void)configUI:(NSIndexPath *)indexPath;
@end
