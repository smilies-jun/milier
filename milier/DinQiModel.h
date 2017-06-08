//
//  DinQiModel.h
//  milier
//
//  Created by amin on 17/5/3.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DinQiModel : NSObject
@property(nonatomic,strong)NSArray *InstallmentInterestList;

@property(nonatomic,strong)NSString *InterestBearingEndTime;

@property(nonatomic,strong)NSString *InterestBearingStartTime;

@property(nonatomic,strong)NSString *cci;

@property(nonatomic,strong)NSString *ci;

@property(nonatomic,strong)NSString *createTime;

@property(nonatomic,strong)NSString *interestRate;

@property(nonatomic,strong)NSString *name;

@property(nonatomic,strong)NSString *oid;

@property(nonatomic,strong)NSString *state;

@property(nonatomic,strong)NSString *subname;

@property(nonatomic,strong)NSString *transferable;

@property(nonatomic,strong)NSString *progress;



@end
