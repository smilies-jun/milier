//
//  ChoseBankTableViewCell.h
//  milier
//
//  Created by amin on 2017/11/21.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChoseModel.h"


@interface ChoseBankTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *BankImageView;

@property (nonatomic, strong) UILabel *BankLabel;

@property (nonatomic, strong) UILabel *BankDayLabel;

@property(nonatomic,strong)ChoseModel *ChoseModel;
- (void)setChoseModel:(ChoseModel *)ChoseModel;
- (void)configUI:(NSIndexPath *)indexPath;
@end
