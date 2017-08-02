//
//  UnYetTopTableViewCell.h
//  milier
//
//  Created by amin on 2017/8/1.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UnYetTopTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *TopMoneyLabel;

@property (nonatomic, strong) UILabel *LostMoneyLabel;

@property (nonatomic, strong) UILabel *LostMoneyNumberLabel;

@property (nonatomic, strong) UILabel *BackMoneyLabel;

@property (nonatomic, strong) UILabel *BackMoneyNumberLabel;

- (void)configUI:(NSIndexPath *)indexPath;


@end
