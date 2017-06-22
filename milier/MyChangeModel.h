//
//  MyChangeModel.h
//  milier
//
//  Created by amin on 2017/5/31.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyChangeModel : NSObject

@property(nonatomic,strong)NSString *aggregateAmount;//回款金额

@property(nonatomic,strong)NSString *bondTotal;//价值

@property(nonatomic,strong)NSString *interestRate;//单日转让率

@property(nonatomic,strong)NSString *investmentHorizon;

@property(nonatomic,strong)NSArray *minimumInvestmentAmount;

@property(nonatomic,strong)NSString *name;

@property(nonatomic,strong)NSString *oid;

@property(nonatomic,strong)NSString *progress;

@property(nonatomic,strong)NSString *progressMessage;

@property(nonatomic,strong)NSString *state;

@property(nonatomic,strong)NSString *expireTime;

@property(nonatomic,strong)NSString *fee;

@end
