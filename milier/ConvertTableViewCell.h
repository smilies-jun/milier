//
//  ConvertTableViewCell.h
//  milier
//
//  Created by amin on 17/5/3.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConvertTableViewCell : UITableViewCell

@property (nonatomic , retain) UIImageView *NameImageView;

@property (nonatomic , retain) UILabel *NameLabel;

@property (nonatomic , retain) UILabel *NameDetailLabel;

@property (nonatomic , retain) UILabel *MyJiFenLabel;

@property (nonatomic , retain) UILabel *ProductLabel;


- (void)configUI:(NSIndexPath *)indexPath;
@end
