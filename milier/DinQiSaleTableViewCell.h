//
//  DinQiSaleTableViewCell.h
//  milier
//
//  Created by amin on 2017/7/31.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DinQiSaleTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel *SaleLabel;

- (void)configUI:(NSIndexPath *)indexPath;
@end
