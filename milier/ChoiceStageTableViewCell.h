//
//  ChoiceStageTableViewCell.h
//  milier
//
//  Created by amin on 2017/5/12.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChoiceStageTableViewCell : UITableViewCell
- (void)configUI:(NSIndexPath *)indexPath;
@property (nonatomic,strong)UIImageView *TotalImageView;

@property (nonatomic,strong)UILabel *TitleLable;

@property (nonatomic,strong)UILabel *DetailLable;

@end
