//
//  JiFenRecordViewController.m
//  milier
//
//  Created by amin on 17/4/24.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "JiFenRecordViewController.h"
#import "JiFenRecordTableViewCell.h"



@interface JiFenRecordViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(strong, nonatomic)UITableView *tableView;

@end

@implementation JiFenRecordViewController
static NSString * const cellId = @"cellID";

- (void)viewDidLoad{
    
    [super viewDidLoad];
    UIView *saleView = [[UIView alloc]init];
    saleView.backgroundColor = [UIColor whiteColor];
    saleView.frame = CGRectMake(0, SCREEN_HEIGHT - 64-44, SCREEN_WIDTH, 44);
    [self.view addSubview:saleView];
    
    UILabel *SaleLbel =  [[UILabel alloc]init];
    SaleLbel.text = @"兑换礼品";
    SaleLbel.userInteractionEnabled = YES;
    SaleLbel.backgroundColor = [UIColor orangeColor];
    SaleLbel.textAlignment = NSTextAlignmentCenter;
    SaleLbel.textColor = [UIColor whiteColor];
    SaleLbel.layer.cornerRadius = 10;
    SaleLbel.layer.masksToBounds = YES;
    [saleView addSubview:SaleLbel];
    [SaleLbel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(saleView.mas_centerX);
        make.centerY.mas_equalTo(saleView.mas_centerY);
        make.width.mas_equalTo(SCREEN_WIDTH - 80);
        make.height.mas_equalTo(30);
    }];
    
    UITapGestureRecognizer *SaleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(JiFenBtnClick
                                                                                                          )];
    [SaleLbel addGestureRecognizer:SaleTap];

    
    
}

- (void)JiFenBtnClick{
    
}
- (void)zj_viewDidLoadForIndex:(NSInteger)index {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    [self.view addSubview:self.tableView];
}
- (void)zj_viewDidAppearForIndex:(NSInteger)index {
//    self.index = index;
//    NSLog(@"已经出现   标题: --- %@  index: -- %ld", self.title, index);
//    
//    if (index%2==0) {
//        self.view.backgroundColor = [UIColor blueColor];
//    } else {
//        self.view.backgroundColor = [UIColor greenColor];
//        
//    }
//    // 加载数据
//    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//    self.data = @[@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa"];
    [self.tableView reloadData];
    //    });
}
#pragma mark- ZJScrollPageViewChildVcDelegate

#pragma mark- UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"StageTotalidentifier";
    
    JiFenRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[JiFenRecordTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        [cell configUI:indexPath];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"点击了%ld行----", indexPath.row);
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    
//    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
//    
//    [super viewWillDisappear:animated];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
