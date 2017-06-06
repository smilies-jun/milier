//
//  MyJiFenViewController.m
//  milier
//
//  Created by amin on 17/4/24.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "MyJiFenViewController.h"
#import "JiFenRecordViewController.h"
#import "JiFenConvertViewController.h"
#import "MJRefresh.h"
#import "UserViewController.h"
#import "ConvertViewController.h"
#import "ZJScrollPageView.h"
#import "ZJPageTableViewController.h"


static CGFloat const segmentViewHeight = 44.0;
static CGFloat const naviBarHeight = 64.0;
static CGFloat const headViewHeight = 200.0;


@interface MyJiFenViewController ()<ZJScrollPageViewDelegate, ZJPageViewControllerDelegate, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) UIActivityIndicatorView *loadingView;
@property (strong, nonatomic) NSArray<NSString *> *titles;
@property (strong, nonatomic) UIView *containerView;
@property (strong, nonatomic) ZJScrollSegmentView *segmentView;
@property (strong, nonatomic) ZJContentView *contentView;
@property (strong, nonatomic) UIView *headView;
@property (strong, nonatomic) UIScrollView *childScrollView;
@property (strong, nonatomic) UITableView *tableView;
@end
static NSString * const cellID = @"cellID";

NSString *const ZJParentTableViewDidLeaveFromTopNotification = @"ZJParentTableViewDidLeaveFromTopNotification";
@implementation MyJiFenViewController
/// 返回YES同时识别多个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的积分";
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(JifenTap) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self.view addSubview:self.tableView];
//    __weak typeof(self) weakself = self;

//    [self.loadingView startAnimating];
//    [self.loadingView stopAnimating];
//    YNJianShuDemoViewController *viewController = [self getJianShuDemoViewController];
//    [viewController addSelfToParentViewController:self isAfterLoadData:YES];
//    
    UIView *saleView = [[UIView alloc]init];
    saleView.backgroundColor = [UIColor whiteColor];
    saleView.frame = CGRectMake(0, SCREEN_HEIGHT - 64-44, SCREEN_WIDTH, 44);
    [self.view addSubview:saleView];
    
    UILabel *SaleLbel =  [[UILabel alloc]init];
    SaleLbel.text = @"兑换礼品";
    SaleLbel.userInteractionEnabled = YES;
    SaleLbel.backgroundColor = colorWithRGB(0.95, 0.6, 0.11);
    SaleLbel.textAlignment = NSTextAlignmentCenter;
    SaleLbel.textColor = [UIColor whiteColor];
    SaleLbel.layer.cornerRadius = 10;
    SaleLbel.layer.masksToBounds = YES;
    [saleView addSubview:SaleLbel];
    [SaleLbel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(saleView.mas_centerX);
        make.centerY.mas_equalTo(saleView.mas_centerY);
        make.width.mas_equalTo(SCREEN_WIDTH - 80);
        make.height.mas_equalTo(44);
    }];
    
    UITapGestureRecognizer *SaleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(JiFenBtnClick
                                                                                                          )];
    [SaleLbel addGestureRecognizer:SaleTap];
}

- (void)JiFenBtnClick{
    ConvertViewController    *ConvertVC = [[ConvertViewController alloc]init];
    [self.navigationController pushViewController:ConvertVC animated:NO];
}
- (void)JifenTap{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[UserViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}


#pragma ZJScrollPageViewDelegate 代理方法
- (NSInteger)numberOfChildViewControllers {
    return self.titles.count;
}

- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    UIViewController<ZJScrollPageViewChildVcDelegate> *childVc = reuseViewController;
    
    if (!childVc) {
        if (index%2==0) {
            childVc = [[JiFenRecordViewController alloc] init];
            JiFenRecordViewController *vc = (JiFenRecordViewController *)childVc;
            vc.delegate = self;
        } else {
            childVc = [[JiFenConvertViewController alloc] init];
            JiFenConvertViewController *vc = (JiFenConvertViewController *)childVc;
            vc.delegate = self;
            
        }
        
    }
    return childVc;
}


#pragma mark- ZJPageViewControllerDelegate

- (void)scrollViewIsScrolling:(UIScrollView *)scrollView {
    _childScrollView = scrollView;
    if (self.tableView.contentOffset.y < headViewHeight) {
        scrollView.contentOffset = CGPointZero;
        scrollView.showsVerticalScrollIndicator = NO;
    }
    else {
        self.tableView.contentOffset = CGPointMake(0.0f, headViewHeight);
        scrollView.showsVerticalScrollIndicator = YES;
    }
    
}

#pragma mark- UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.childScrollView && _childScrollView.contentOffset.y > 0) {
        self.tableView.contentOffset = CGPointMake(0.0f, headViewHeight);
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    if(offsetY < headViewHeight) {
        [[NSNotificationCenter defaultCenter] postNotificationName:ZJParentTableViewDidLeaveFromTopNotification object:nil];
        
    }
}

#pragma mark- UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [cell.contentView addSubview:self.contentView];
    
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.segmentView;
}

#pragma mark- setter getter
- (ZJScrollSegmentView *)segmentView {
    if (_segmentView == nil) {
        ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
        style.showCover = NO;
        style.showLine = YES;
        style.scrollLineColor = [UIColor orangeColor];
        // 渐变
        style.gradualChangeTitleColor = NO;
        // 遮盖背景颜色
        style.coverBackgroundColor = colorWithRGB(0.93, 0.93, 0.93);
        //标题一般状态颜色 --- 注意一定要使用RGB空间的颜色值
        style.normalTitleColor = colorWithRGB(0.53, 0.53, 0.53);
        //标题选中状态颜色 --- 注意一定要使用RGB空间的颜色值
        style.selectedTitleColor = [UIColor orangeColor];
        style.autoAdjustTitlesWidth = YES;
        self.titles = @[@"积分纪录",
                        @"兑换纪录",
                        ];
        
        // 注意: 一定要避免循环引用!!
        __weak typeof(self) weakSelf = self;
        ZJScrollSegmentView *segment = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(0, naviBarHeight + headViewHeight, self.view.bounds.size.width, segmentViewHeight) segmentStyle:style delegate:self titles:self.titles titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
            
            [weakSelf.contentView setContentOffSet:CGPointMake(weakSelf.contentView.bounds.size.width * index, 0.0) animated:YES];
            
        }];
        segment.backgroundColor = [UIColor whiteColor];
        _segmentView = segment;
        
    }
    return _segmentView;
}

- (ZJContentView *)contentView {
    if (_contentView == nil) {
        ZJContentView *content = [[ZJContentView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 44- 44) segmentView:self.segmentView parentViewController:self delegate:self];
        _contentView = content;
    }
    return _contentView;
}

- (UIView *)headView {
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, headViewHeight)];
        UILabel *label = [[UILabel alloc] initWithFrame:_headView.bounds];
        label.text =_JiFenStr;
        label.font = [UIFont systemFontOfSize:26];
        label.textAlignment = NSTextAlignmentCenter;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor orangeColor];
        [_headView addSubview:label];
        _headView.backgroundColor = [UIColor whiteColor];
    }
    
    return _headView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        CGRect frame = CGRectMake(0.0f, 0, self.view.bounds.size.width, self.view.bounds.size.height - 44-64);
        UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        // 设置tableView的headView
        tableView.tableHeaderView = self.headView;
        tableView.tableFooterView = [UIView new];
        // 设置cell行高为contentView的高度
        tableView.rowHeight = self.contentView.bounds.size.height;
        tableView.delegate = self;
        tableView.dataSource = self;
        // 设置tableView的sectionHeadHeight为segmentViewHeight
        tableView.sectionHeaderHeight = segmentViewHeight;
        tableView.showsVerticalScrollIndicator = false;
        _tableView = tableView;
    }
    
    return _tableView;
}
- (BOOL)shouldAutomaticallyForwardAppearanceMethods{
    return NO;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];

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
