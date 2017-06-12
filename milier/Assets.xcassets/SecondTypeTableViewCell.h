//
//  SecondTypeTableViewCell.h
//  milier
//
//  Created by amin on 2017/5/5.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailModel.h"

@interface SecondTypeTableViewCell : UITableViewCell

@property (nonatomic, strong)ProductDetailModel *detailModel;

@property(nonatomic, retain)UIImageView *TypeImageView;

@property (nonatomic , retain) UILabel *TypeLabel;

@property (nonatomic , retain) UILabel *TypeDetailLabel;



@property(nonatomic, retain)UIImageView *DaoQiTypeImageView;

@property (nonatomic , retain) UILabel *DaoQiTypeLabel;

@property (nonatomic , retain) UILabel *DaoQiTypeDetailLabel;


@property(nonatomic, retain)UIImageView *IsFullImageView;

@property (nonatomic , retain) UILabel *IsFullLabel;

@property (nonatomic , retain) UILabel *IsFullDetailLabel;

@property (nonatomic , retain) UIView *IsFulllineView;

@property (nonatomic , retain) UIView *BottomLineView;

- (void)configUI:(NSIndexPath *)indexPath;

@end
