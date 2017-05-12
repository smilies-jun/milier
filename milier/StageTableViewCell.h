//
//  StageTableViewCell.h
//  milier
//
//  Created by amin on 17/4/25.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StageTableViewCell : UITableViewCell

@property (nonatomic,strong)UIImageView *LeftImageView;

@property (nonatomic,strong)UIImageView *TypeImageView;

@property (nonatomic,strong)UIImageView *RightImageView;

@property (nonatomic,strong)UILabel *TitleLable;

@property (nonatomic,strong)UILabel *TitleStateLable;

@property (nonatomic,strong)UILabel *SaileTimeLable;

@property (nonatomic,strong)UILabel *SailMoneyLable;

@property (nonatomic,strong)UILabel *BuyTitleLable;

@property (nonatomic,strong)UILabel *InterentTitleLable;

@property (nonatomic,strong)UILabel *QiYeTitleLable;

@property (nonatomic,strong)UILabel *PersonTitleLable;



@property (nonatomic,strong)UILabel *UseTitleLable;

@property (nonatomic,strong)UILabel *UseTimeTitleLable;

- (void)configUI:(NSIndexPath *)indexPath;


@end
