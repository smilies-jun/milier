//
//  RiskViewController.m
//  milier
//
//  Created by amin on 17/4/26.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "RiskViewController.h"
#import "UserViewController.h"
#import "MHRadioButton.h"


@interface RiskViewController ()<MHRadioButtonDelegate>{
    UIImageView *FirstView;
    UIScrollView *RiskScroview;
    NSArray *TypeArray;
    
   
}

@property (nonatomic, strong) NSMutableArray * itmeArray;
@property (nonatomic, strong) UIImageView * imageView;
@end

@implementation RiskViewController
static NSString * const ID = @"CollectionCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"风险评估";
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(RiskTap) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    TypeArray = @[@"A",@"B",@"C",@"D",@"E"];
    
    RiskScroview = [[UIScrollView alloc]init];
    RiskScroview.backgroundColor = [UIColor grayColor];
    RiskScroview.frame = CGRectMake(0, 0, SCREEN_WIDTH, 400);
    RiskScroview.contentOffset = CGPointMake(0, 100);
    RiskScroview.contentSize = CGSizeMake(SCREEN_WIDTH*10, 400);
    RiskScroview.bounces = NO;
    RiskScroview.userInteractionEnabled = YES;
    RiskScroview.pagingEnabled = YES;
    RiskScroview.showsVerticalScrollIndicator = NO;
    RiskScroview.maximumZoomScale = 2;
    RiskScroview.minimumZoomScale = 0.8;
    [self.view addSubview:RiskScroview];

    for (int i = 0; i < 5; i++) {
        MHRadioButton *rb = [[MHRadioButton alloc] initWithGroupId:@"group1" atIndex:i];
        rb.frame = CGRectMake(20, 40 + 30 * i, 40, 40);
        [RiskScroview addSubview:rb];
        UILabel *TypeLabel = [[UILabel alloc]init];
        TypeLabel.frame = CGRectMake(40, 40 + 30 * i, 20, 20);
        TypeLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:TypeLabel];
        
        UILabel *NameLabel = [[UILabel alloc]init];
        NameLabel.frame = CGRectMake(60, 40 + 30 * i, 20, 20);
        NameLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:NameLabel];
    }

    for (int i = 0; i < 5; i++) {
        MHRadioButton *rb = [[MHRadioButton alloc] initWithGroupId:@"group2" atIndex:i];
        rb.frame = CGRectMake(SCREEN_WIDTH*1+20, 40 + 30 * i, 40, 40);
        [RiskScroview addSubview:rb];
        UILabel *TypeLabel = [[UILabel alloc]init];
        TypeLabel.frame = CGRectMake(SCREEN_WIDTH*1+40, 40 + 30 * i, 20, 20);
        TypeLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:TypeLabel];
        UILabel *NameLabel = [[UILabel alloc]init];
        NameLabel.frame = CGRectMake(SCREEN_WIDTH*1+60, 40 + 30 * i, 20, 20);
        NameLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:NameLabel];
    }
    for (int i = 0; i < 5; i++) {
        MHRadioButton *rb = [[MHRadioButton alloc] initWithGroupId:@"group3" atIndex:i];
        rb.frame = CGRectMake(SCREEN_WIDTH*2+20, 40 + 30 * i, 40, 40);
        [RiskScroview addSubview:rb];
        UILabel *TypeLabel = [[UILabel alloc]init];
        TypeLabel.frame = CGRectMake(SCREEN_WIDTH*2+40, 40 + 30 * i, 20, 20);
        TypeLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:TypeLabel];
        UILabel *NameLabel = [[UILabel alloc]init];
        NameLabel.frame = CGRectMake(SCREEN_WIDTH*2+60, 40 + 30 * i, 20, 20);
        NameLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:NameLabel];

    }
    for (int i = 0; i < 5; i++) {
        MHRadioButton *rb = [[MHRadioButton alloc] initWithGroupId:@"group4" atIndex:i];
        rb.frame = CGRectMake(SCREEN_WIDTH*3+20, 40 + 30 * i, 40, 40);
        [RiskScroview addSubview:rb];
        UILabel *TypeLabel = [[UILabel alloc]init];
        TypeLabel.frame = CGRectMake(SCREEN_WIDTH*3+40, 40 + 30 * i, 20, 20);
        TypeLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:TypeLabel];
        UILabel *NameLabel = [[UILabel alloc]init];
        NameLabel.frame = CGRectMake(SCREEN_WIDTH*3+60, 40 + 30 * i, 20, 20);
        NameLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:NameLabel];

    }
    for (int i = 0; i < 5; i++) {
        MHRadioButton *rb = [[MHRadioButton alloc] initWithGroupId:@"group5" atIndex:i];
        rb.frame = CGRectMake(SCREEN_WIDTH*4+20, 40 + 30 * i, 40, 40);
        [RiskScroview addSubview:rb];
        UILabel *TypeLabel = [[UILabel alloc]init];
        TypeLabel.frame = CGRectMake(SCREEN_WIDTH*4+40, 40 + 30 * i, 20, 20);
        TypeLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:TypeLabel];
        UILabel *NameLabel = [[UILabel alloc]init];
        NameLabel.frame = CGRectMake(SCREEN_WIDTH*4+60, 40 + 30 * i, 20, 20);
        NameLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:NameLabel];

    }
    for (int i = 0; i < 5; i++) {
        MHRadioButton *rb = [[MHRadioButton alloc] initWithGroupId:@"group6" atIndex:i];
        rb.frame = CGRectMake(SCREEN_WIDTH*5+20, 40 + 30 * i, 40, 40);
        [RiskScroview addSubview:rb];
        UILabel *TypeLabel = [[UILabel alloc]init];
        TypeLabel.frame = CGRectMake(SCREEN_WIDTH*5+40, 40 + 30 * i, 20, 20);
        TypeLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:TypeLabel];
        UILabel *NameLabel = [[UILabel alloc]init];
        NameLabel.frame = CGRectMake(SCREEN_WIDTH*5+60, 40 + 30 * i, 20, 20);
        NameLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:NameLabel];

    }
    for (int i = 0; i < 5; i++) {
        MHRadioButton *rb = [[MHRadioButton alloc] initWithGroupId:@"group7" atIndex:i];
        rb.frame = CGRectMake(SCREEN_WIDTH*6+20, 40 + 30 * i, 40, 40);
        [RiskScroview addSubview:rb];
        UILabel *TypeLabel = [[UILabel alloc]init];
        TypeLabel.frame = CGRectMake(SCREEN_WIDTH*6+40, 40 + 30 * i, 20, 20);
        TypeLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:TypeLabel];
        UILabel *NameLabel = [[UILabel alloc]init];
        NameLabel.frame = CGRectMake(SCREEN_WIDTH*6+60, 40 + 30 * i, 20, 20);
        NameLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:NameLabel];

    }
    for (int i = 0; i < 5; i++) {
        MHRadioButton *rb = [[MHRadioButton alloc] initWithGroupId:@"group8" atIndex:i];
        rb.frame = CGRectMake(SCREEN_WIDTH*7+20, 40 + 30 * i, 40, 40);
        [RiskScroview addSubview:rb];
        UILabel *TypeLabel = [[UILabel alloc]init];
        TypeLabel.frame = CGRectMake(SCREEN_WIDTH*7+40, 40 + 30 * i, 20, 20);
        TypeLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:TypeLabel];
        UILabel *NameLabel = [[UILabel alloc]init];
        NameLabel.frame = CGRectMake(SCREEN_WIDTH*7+60, 40 + 30 * i, 20, 20);
        NameLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:NameLabel];

    }
    for (int i = 0; i < 5; i++) {
        MHRadioButton *rb = [[MHRadioButton alloc] initWithGroupId:@"group9" atIndex:i];
        rb.frame = CGRectMake(SCREEN_WIDTH*8+20, 40 + 30 * i, 40, 40);
        [RiskScroview addSubview:rb];
        UILabel *TypeLabel = [[UILabel alloc]init];
        TypeLabel.frame = CGRectMake(SCREEN_WIDTH*8+40, 40 + 30 * i, 20, 20);
        TypeLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:TypeLabel];
        UILabel *NameLabel = [[UILabel alloc]init];
        NameLabel.frame = CGRectMake(SCREEN_WIDTH*8+60, 40 + 30 * i, 20, 20);
        NameLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:NameLabel];

    }
    for (int i = 0; i < 5; i++) {
        MHRadioButton *rb = [[MHRadioButton alloc] initWithGroupId:@"group10" atIndex:i];
        rb.frame = CGRectMake(SCREEN_WIDTH*9+20, 40 + 30 * i, 40, 40);
        [RiskScroview addSubview:rb];
        UILabel *TypeLabel = [[UILabel alloc]init];
        TypeLabel.frame = CGRectMake(SCREEN_WIDTH*9+40, 40 + 30 * i, 20, 20);
        TypeLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:TypeLabel];
        UILabel *NameLabel = [[UILabel alloc]init];
        NameLabel.frame = CGRectMake(SCREEN_WIDTH*9+60, 40 + 30 * i, 20, 20);
        NameLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:NameLabel];

    }
    
    [MHRadioButton addObserver:self forFroupId:@"group1"];
    [MHRadioButton addObserver:self forFroupId:@"group2"];
    [MHRadioButton addObserver:self forFroupId:@"group3"];
    [MHRadioButton addObserver:self forFroupId:@"group4"];
    [MHRadioButton addObserver:self forFroupId:@"group5"];
    [MHRadioButton addObserver:self forFroupId:@"group6"];
    [MHRadioButton addObserver:self forFroupId:@"group7"];
    [MHRadioButton addObserver:self forFroupId:@"group8"];
    [MHRadioButton addObserver:self forFroupId:@"group9"];
    [MHRadioButton addObserver:self forFroupId:@"group10"];
    
    


}

// 代理方法 监控按钮选中状态的改变
- (void)radioButtonSelectedAtIndex:(NSUInteger)index inGroup:(NSString *)groupID{
    NSLog(@"%@ %lu", groupID, (unsigned long)index);
    
  //  NSLog(@"%lu", [MHRadioButton getIndexWithGroupId:@"group"]);
}
- (void)RiskTap{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[UserViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
