//
//  SecondDetailTableViewCell.h
//  milier
//
//  Created by amin on 2017/5/5.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SecondDetailTableViewCell : UITableViewCell

@property (nonatomic , retain) UILabel *TitleLabel;

@property (nonatomic, retain) UIImageView *ArrowImageView;

- (void)configUI:(NSIndexPath *)indexPath;


@end
