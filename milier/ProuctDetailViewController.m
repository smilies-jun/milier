//
//  ProuctDetailViewController.m
//  milier
//
//  Created by amin on 17/4/17.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "ProuctDetailViewController.h"
#import "SDCycleScrollView.h"
#import "YNTestOneViewController.h"
#import "ProductViewController.h"
#import "DetailViewController.h"
#import "ProductHistoryViewController.h"
#import "YNTestFourViewController.h"
#import "YNJianShuDemoViewController.h"
#import "MJRefresh.h"
#import "SaleViewController.h"

@interface ProuctDetailViewController ()<YNPageScrollViewControllerDataSource,SDCycleScrollViewDelegate,YNPageScrollViewControllerDelegate,YNPageScrollViewMenuDelegate>{
    UILabel *TitleLabel;
    UILabel *NumberLabel;
    
    CAShapeLayer *ShapeLayer;
    UILabel *ProfitLabel;
    UILabel *ProfitPercentLabel;
    
    UILabel *BondLabel;
    UILabel *BondTimeLabel;
    
    UILabel *PercentProfitLabel;
    UILabel *PercentTimeLabel;
    
    UILabel *StyleLabel;
    UILabel *InterestLabel;
    UILabel *AddPercentLabdel;
    
    UILabel *LeftLabel;
    UILabel *LeftMoneyLabel;
    
    UILabel *DetailStyleLabel;
    UILabel *DetailInterestLabel;
    UILabel *DetailAddPercentLabel;
    
    
    
}
@property (nonatomic, strong) UIActivityIndicatorView *loadingView;

@end

@implementation ProuctDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"产品详情";
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(onTap) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self.loadingView startAnimating];
    [self.loadingView stopAnimating];
    YNJianShuDemoViewController *viewController = [self getJianShuDemoViewController];
    [viewController addSelfToParentViewController:self isAfterLoadData:YES];
   
    UIView *saleView = [[UIView alloc]init];
    saleView.backgroundColor = [UIColor whiteColor];
    saleView.frame = CGRectMake(0, SCREEN_HEIGHT - 64-44, SCREEN_WIDTH, 44);
    [self.view addSubview:saleView];
    
    UILabel *SaleLbel =  [[UILabel alloc]init];
    SaleLbel.text = @"购买";
    SaleLbel.userInteractionEnabled = YES;
    SaleLbel.backgroundColor = [UIColor greenColor];
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
   
    UITapGestureRecognizer *SaleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SaleBtnClick
                                                                                                          )];
    [SaleLbel addGestureRecognizer:SaleTap];
}
- (void)SaleBtnClick{
    NSLog(@"tap");
    SaleViewController *SaleVC = [[SaleViewController alloc]init];
    [self.navigationController pushViewController:SaleVC animated:NO];
}
- (void)onTap{
    [self.navigationController popToRootViewControllerAnimated:NO];
}
//简书Demo
- (YNJianShuDemoViewController *)getJianShuDemoViewController{
    //配置信息
    YNPageScrollViewMenuConfigration *configration = [[YNPageScrollViewMenuConfigration alloc]init];
    configration.scrollViewBackgroundColor = [UIColor redColor];
    configration.itemLeftAndRightMargin = 30;
    configration.itemMargin = 60;
    configration.lineColor = [UIColor orangeColor];
    configration.lineHeight = 2;
    configration.itemMaxScale = 1.2;
    configration.pageScrollViewMenuStyle = YNPageScrollViewMenuStyleSuspension;
    configration.scrollViewBackgroundColor = [UIColor whiteColor];
    configration.selectedItemColor = [UIColor redColor];
    //设置平分不滚动   默认会居中
   // configration.aligmentModeCenter = YES;
    configration.scrollMenu = YES;
    configration.showGradientColor = NO;//取消渐变
    configration.showNavigation = YES;
    configration.showTabbar = NO;//设置显示tabbar
    
    //创建控制器
    YNJianShuDemoViewController *vc = [YNJianShuDemoViewController pageScrollViewControllerWithControllers:[self getViewController] titles:@[@"产品介绍",@"产品详细",@"投资记录"] Configration:configration];
    //头部视图
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 470)];
    TitleLabel = [[UILabel alloc]init];
    TitleLabel.text = @"米三－新密计划第一期";
    TitleLabel.font = [UIFont systemFontOfSize:13];
    TitleLabel.textAlignment = NSTextAlignmentCenter;
    [imageView addSubview:TitleLabel];
    [TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_left);
        make.top.mas_equalTo(imageView.mas_top).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(20);
        
    }];
    NumberLabel = [[UILabel alloc]init];
    NumberLabel.text = @"项目编号：251425";
    NumberLabel.font = [UIFont systemFontOfSize:10];
    NumberLabel.textAlignment = NSTextAlignmentCenter;
    [imageView addSubview:NumberLabel];
    [NumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_left);
        make.top.mas_equalTo(TitleLabel.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(10);
        
    }];
    ShapeLayer = [CAShapeLayer layer];
    ShapeLayer.fillColor = [UIColor clearColor].CGColor;//填充颜色为ClearColor
    //设置线条的宽度和颜色
    ShapeLayer.lineWidth = 1.0f;
    ShapeLayer.strokeColor = [UIColor redColor].CGColor;
    //创建出圆形贝塞尔曲线
    UIBezierPath *circlePath =  [UIBezierPath bezierPathWithArcCenter:CGPointMake(imageView.centerX, imageView.centerY-30) radius:120 startAngle:0.75f*M_PI endAngle:0.25f*M_PI clockwise:YES];

        //让贝塞尔曲线与CAShapeLayer产生联系
    ShapeLayer.path = circlePath.CGPath;
    
    //添加并显示
    [imageView.layer addSublayer:ShapeLayer];

    ProfitLabel  = [[UILabel alloc]init];
    ProfitLabel.text = @"年化收益";
    ProfitLabel.font = [UIFont systemFontOfSize:12];
    ProfitLabel.textAlignment = NSTextAlignmentCenter;
    [imageView addSubview:ProfitLabel];
    [ProfitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(NumberLabel.mas_centerX);
        make.top.mas_equalTo(NumberLabel.mas_bottom).offset(60);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
    
    ProfitPercentLabel  = [[UILabel alloc]init];
    ProfitPercentLabel.text = @"12.34%";
    ProfitPercentLabel.textColor = [UIColor blueColor];
    NSMutableAttributedString *newAttrStr = [[NSMutableAttributedString alloc] initWithString:@"12.34%"];
    [newAttrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:50] range:NSMakeRange(0,ProfitPercentLabel.text.length
                                                                                                          )];
    [newAttrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20] range:NSMakeRange(ProfitPercentLabel.text.length - 1
                                                                                                          ,1)];
    ProfitPercentLabel.attributedText = newAttrStr;
    ProfitPercentLabel.textAlignment = NSTextAlignmentCenter;
    [imageView addSubview:ProfitPercentLabel];
    [ProfitPercentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(NumberLabel.mas_centerX);
        make.top.mas_equalTo(ProfitLabel.mas_bottom).offset(30);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(40);
    }];
    
    BondLabel = [[UILabel alloc]init];
    BondLabel.text = @"39999.0债券";
    BondLabel.font = [UIFont systemFontOfSize:12];
    BondLabel.textAlignment = NSTextAlignmentRight;
    [imageView addSubview:BondLabel];
    [BondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_left).offset(80);
        make.top.mas_equalTo(ProfitPercentLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    BondTimeLabel = [[UILabel alloc]init];
    BondTimeLabel.text = @"260天期限";
    BondTimeLabel.font = [UIFont systemFontOfSize:12];
    BondTimeLabel.textAlignment = NSTextAlignmentLeft;
    [imageView addSubview:BondTimeLabel];
    [BondTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BondLabel.mas_right).offset(20);
        make.top.mas_equalTo(ProfitPercentLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    PercentProfitLabel = [[UILabel alloc]init];
    PercentProfitLabel.text = @"万份收益";
    PercentProfitLabel.font = [UIFont systemFontOfSize:12];
    PercentProfitLabel.textAlignment = NSTextAlignmentRight;
    [imageView addSubview:PercentProfitLabel];
    [PercentProfitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_left).offset(80);
        make.top.mas_equalTo(BondLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    PercentTimeLabel = [[UILabel alloc]init];
    PercentTimeLabel.text = @"1.23/天";
    PercentTimeLabel.font = [UIFont systemFontOfSize:12];
    PercentTimeLabel.textAlignment = NSTextAlignmentLeft;
    [imageView addSubview:PercentTimeLabel];
    [PercentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(PercentProfitLabel.mas_right).offset(20);
        make.top.mas_equalTo(BondLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    StyleLabel = [[UILabel alloc]init];
    StyleLabel.text = @"稳健型";
    StyleLabel.backgroundColor = [UIColor orangeColor];
    StyleLabel.font = [UIFont systemFontOfSize:11];
    [imageView addSubview:StyleLabel];
    [StyleLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_left).offset(100);
        make.top.mas_equalTo(PercentTimeLabel.mas_bottom).offset(30);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(15);
    }];
    InterestLabel = [[UILabel alloc]init];
    InterestLabel.text = @"到期还本利息";
    InterestLabel.backgroundColor = [UIColor orangeColor];
    InterestLabel.font = [UIFont systemFontOfSize:11];
    [imageView addSubview:InterestLabel];
    [InterestLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(StyleLabel.mas_right).offset(10);
        make.top.mas_equalTo(PercentTimeLabel.mas_bottom).offset(30);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(15);
    }];
    AddPercentLabdel = [[UILabel alloc]init];
    AddPercentLabdel.text = @"满标+0.5%";
    AddPercentLabdel.backgroundColor = [UIColor orangeColor];
    AddPercentLabdel.font = [UIFont systemFontOfSize:11];
    [imageView addSubview:AddPercentLabdel];
    [AddPercentLabdel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(InterestLabel.mas_right).offset(10);
        make.top.mas_equalTo(PercentTimeLabel.mas_bottom).offset(30);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(15);
    }];

    UIView *LineView = [[UIView alloc]init];
    LineView.backgroundColor = [UIColor greenColor];
    [imageView addSubview:LineView];
    [LineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_left).offset(10);
        make.top.mas_equalTo(AddPercentLabdel.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH- 20);
        make.height.mas_equalTo(2);
    }];
    LeftLabel = [[UILabel alloc]init];
    LeftLabel.text = @"剩余额度";
    LeftLabel.font = [UIFont systemFontOfSize:14];
    [imageView addSubview:LeftLabel];
    [LeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_left).offset(20);
        make.top.mas_equalTo(LineView.mas_bottom).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    LeftMoneyLabel = [[UILabel alloc]init];
    LeftMoneyLabel.text = @"222222222222.0元";
    LeftMoneyLabel.textAlignment = NSTextAlignmentRight;
    LeftMoneyLabel.font = [UIFont systemFontOfSize:14];
    [imageView addSubview:LeftMoneyLabel];
    [LeftMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(imageView.mas_right).offset(-20);
        make.top.mas_equalTo(LineView.mas_bottom).offset(10);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(30);
    }];
    
    UIView *DetailBackView = [[UIView alloc]init];
    DetailBackView.backgroundColor = [UIColor grayColor];
    [imageView addSubview:DetailBackView];
    [DetailBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_left);
        make.top.mas_equalTo(LeftLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(80);
    }];
    
    DetailStyleLabel = [[UILabel alloc]init];
    DetailStyleLabel.text = @"稳健型：中低风险收益可观适合稳健型投资";
    DetailStyleLabel.textColor = [UIColor orangeColor];
    DetailStyleLabel.font = [UIFont systemFontOfSize:13];
    [DetailBackView addSubview:DetailStyleLabel];
    [DetailStyleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(DetailBackView.mas_left).offset(10);
        make.top.mas_equalTo(DetailBackView.mas_top).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH -20);
        make.height.mas_equalTo(20);
    }];
    
    DetailInterestLabel = [[UILabel alloc]init];
    DetailInterestLabel.text = @"稳健型：中低风险收益可观适合稳健型投资";
    DetailInterestLabel.textColor = [UIColor orangeColor];
    DetailInterestLabel.font = [UIFont systemFontOfSize:13];
    [DetailBackView addSubview:DetailInterestLabel];
    [DetailInterestLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(DetailBackView.mas_left).offset(10);
        make.top.mas_equalTo(DetailStyleLabel.mas_bottom).offset(2);
        make.width.mas_equalTo(SCREEN_WIDTH -20);
        make.height.mas_equalTo(20);
    }];

    DetailAddPercentLabel = [[UILabel alloc]init];
    DetailAddPercentLabel.text = @"稳健型：中低风险收益可观适合稳健型投资";
    DetailAddPercentLabel.textColor = [UIColor orangeColor];
    DetailAddPercentLabel.font = [UIFont systemFontOfSize:13];
    [DetailBackView addSubview:DetailAddPercentLabel];
    [DetailAddPercentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(DetailBackView.mas_left).offset(10);
        make.top.mas_equalTo(DetailInterestLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(SCREEN_WIDTH -20);
        make.height.mas_equalTo(20);
    }];

    
    
    
    //footer用来当做内容高度
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    footerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    vc.placeHoderView = footerView;
    vc.dataSource = self;
    vc.headerView = imageView;
    vc.IsTab = NO;
    return vc;

}


- (void)dealloc{
    
    NSLog(@"释放 父类 UIHomeViewController");
}

- (void)imageViewTap{
    
    NSLog(@"----- imageViewTap -----");
    
}

#pragma mark - YNPageScrollViewControllerDataSource
- (UITableView *)pageScrollViewController:(YNPageScrollViewController *)pageScrollViewController scrollViewForIndex:(NSInteger)index{
    
    YNTestBaseViewController *VC= pageScrollViewController.viewControllers[index];
    return [VC tableView];
    
};

- (BOOL)pageScrollViewController:(YNPageScrollViewController *)pageScrollViewController headerViewIsRefreshingForIndex:(NSInteger)index{
    
    YNTestBaseViewController *VC= pageScrollViewController.viewControllers[index];
    return [[[VC tableView] mj_header] isRefreshing];
}

- (void)pageScrollViewController:(YNPageScrollViewController *)pageScrollViewController scrollViewHeaderAndFooterEndRefreshForIndex:(NSInteger)index{
    
    YNTestBaseViewController *VC= pageScrollViewController.viewControllers[index];
    [[[VC tableView] mj_header] endRefreshing];
    [[[VC tableView] mj_footer] endRefreshing];
}


- (NSArray *)getViewController{
    
    ProductViewController *one = [[ProductViewController alloc]init];
    
    DetailViewController *two = [[DetailViewController alloc]init];
    
    ProductHistoryViewController *three = [[ProductHistoryViewController alloc]init];
    
    
    return @[one,two,three];
}


#pragma mark - lazy

- (UIActivityIndicatorView *)loadingView{
    
    if (!_loadingView) {
        
        _loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _loadingView.hidesWhenStopped = YES;
        _loadingView.center = self.view.center;
        [self.view addSubview:_loadingView];
    }
    
    return _loadingView;
}
-(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
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
