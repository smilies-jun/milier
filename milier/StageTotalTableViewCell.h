//
//  StageTotalTableViewCell.h
//  milier
//
//  Created by amin on 2017/5/5.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StageTotalTableViewCell : UITableViewCell

@property (nonatomic,strong)UIImageView *TotalImageView;

@property (nonatomic,strong)UILabel *TitleLable;

- (void)configUI:(NSIndexPath *)indexPath;


@end
