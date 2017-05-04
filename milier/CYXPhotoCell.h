//
//  CYXPhotoCell.h
//  CYCollectionViewTest
//
//  Created by apple开发 on 16/3/8.
//  Copyright © 2016年 cyx. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RiskModel.h"

@interface CYXPhotoCell : UICollectionViewCell
@property (nonatomic, strong) RiskModel *riskModel;

@property (nonatomic, copy) NSString *imageName;

@property (nonatomic,strong)UILabel *TitleLabel;

@property (nonatomic,strong)UILabel *FirstLabel;

@property (nonatomic,strong)UILabel *SecondLabel;

@property (nonatomic,strong)UILabel *ThreeLabel;

@property (nonatomic,strong)UILabel *FourLabel;

@property (nonatomic,strong)UILabel *FiveLabel;

@property (nonatomic, copy) NSString *Numberstr;


- (void)configUI:(NSIndexPath *)indexPath;

@end
