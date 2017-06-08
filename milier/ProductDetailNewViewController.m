//
//  ProductDetailNewViewController.m
//  milier
//
//  Created by amin on 17/5/2.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "ProductDetailNewViewController.h"
#import "SaleViewController.h"
#import "SecondDetailTopTableViewCell.h"
#import "SecondDetailMainTableViewCell.h"
#import "MJRefresh.h"
#import "SecondTypeTableViewCell.h"
#import "SecondDetailTableViewCell.h"
#import "ProductDetailModel.h"
#import "SaleViewController.h"
#import "ProductDetailNewViewController.m"
#import "JinMiDetdailViewController.h"



@interface ProductDetailNewViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *DataArray;
@end

@implementation ProductDetailNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"产品详情";
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(newDetailTap) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    _DataArray = [[NSMutableArray alloc]init];
    
    [self getNetworkData:YES];
    [self ConfigUI];
}

-(void)getNetworkData:(BOOL)isRefresh
{
    NSString *url;

    url = [NSString stringWithFormat:@"%@/%d",PRODUCTS_URL,_productID];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:url withTokenStr:@"" usingBlock:^(NSDictionary *result, NSError *error) {
        [_DataArray removeAllObjects];
        
            NSDictionary *dic = [result objectForKey:@"data"];
            ProductDetailModel *model = [[ProductDetailModel alloc]init];
            model.dataDictionary = dic;
            [_DataArray addObject:model];

        [_tableView reloadData];
    }];
    
}


-(void)ConfigUI{
    
    page = 1;
    isFirstCome = YES;
    isJuhua = NO;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 40) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    UIView *saleView = [[UIView alloc]init];
    saleView.backgroundColor = [UIColor whiteColor];
    saleView.frame = CGRectMake(0, SCREEN_HEIGHT - 64-44, SCREEN_WIDTH, 44);
    [self.view addSubview:saleView];
    
    UILabel *SaleLbel =  [[UILabel alloc]init];
    SaleLbel.text = @"立即购买";
    SaleLbel.userInteractionEnabled = YES;
    
    switch (_productCateID) {
        case 1:
        SaleLbel.backgroundColor = colorWithRGB(0.62, 0.80, 0.09);
            break;
        case 2:
         SaleLbel.backgroundColor = colorWithRGB(0.99, 0.79, 0.09);
            break;
        case 3:
         SaleLbel.backgroundColor = colorWithRGB(0.99, 0.52, 0.18);
            break;
        case 4:
           SaleLbel.backgroundColor = colorWithRGB(0.27, 0.78, 0.96);
            break;
        case 5:
          SaleLbel.backgroundColor = colorWithRGB(0.31, 0.69, 0.10);
            break;
        case 6:
           SaleLbel.backgroundColor = colorWithRGB(0.19, 0.39, 0.9);
            break;
            
        default:
            break;
    }
    
    SaleLbel.textAlignment = NSTextAlignmentCenter;
    SaleLbel.textColor = [UIColor whiteColor];
    SaleLbel.layer.cornerRadius = 10;
    SaleLbel.layer.masksToBounds = YES;
    [saleView addSubview:SaleLbel];
    [SaleLbel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(saleView.mas_centerX);
        make.centerY.mas_equalTo(saleView.mas_centerY);
        make.width.mas_equalTo(SCREEN_WIDTH - 80);
        make.height.mas_equalTo(40);
    }];
    
    UITapGestureRecognizer *SaleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SaleBtnClick
                                                                                                    )];
    [SaleLbel addGestureRecognizer:SaleTap];

}
- (void)SaleBtnClick{
    SaleViewController *SaleVC = [[SaleViewController alloc]init];
    ProductDetailModel *model = [_DataArray objectAtIndex:0];
    SaleVC.productID = [NSString stringWithFormat:@"%d",_productCateID];
    SaleVC.NameStr = model.name;
    SaleVC.TotalStr = model.aggregateAmount;
    SaleVC.SellStr = model.sellTotal;
    SaleVC.PercentStr = model.interestRate;
    SaleVC.investmentHorizonStr = model.investmentHorizon;
    SaleVC.isFullScaleReward = model.isFullScaleReward;
    SaleVC.fullScaleReward = model.fullScaleReward;
    SaleVC.riskLevelStr = model.riskLevel;
    SaleVC.minBuyStr = model.minimumInvestmentAmount;
    SaleVC.productStr = [NSString stringWithFormat:@"%d",_productID];
    [self.navigationController pushViewController:SaleVC animated:NO];
}
- (void)newDetailTap{
    if (_Type == 1) {
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[JinMiDetdailViewController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
    }else{
        [self.navigationController popToRootViewControllerAnimated:NO];
 
    }
    

}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  5;
}


//组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 320;
    }else if (indexPath.row == 1){
        return 170;
    }
    else{
        return 44;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        static NSString *identifier = @"topidentifier";
        
        SecondDetailTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[SecondDetailTopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            switch (_productCateID) {
                case 1:
                    cell.ProductcatID = 1;
                    break;
                case 2:
                    cell.ProductcatID =2;
                    break;
                    
                case 3:
                    cell.ProductcatID = 3;
                    break;
                    
                case 4:
                    cell.ProductcatID = 4;
                    break;
                    
                case 5:
                    cell.ProductcatID = 5;
                    break;
                    
                case 6:
                    cell.ProductcatID = 6;
                    break;
                    
                    
                default:
                    break;
            }

            [cell configUI:indexPath];
        }
        if (_DataArray.count) {
            ProductDetailModel *model  = [_DataArray objectAtIndex:0];
            cell.detailModel = model;
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if (indexPath.row == 1){
        static NSString *identifier = @"mainidentifier";
        
        SecondTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[SecondTypeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
        if (_DataArray.count) {
            ProductDetailModel *model  = [_DataArray objectAtIndex:0];
            cell.detailModel = model;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }
    
    
    else{
        static NSString *identifier = @"Detailidentifier";
        
        SecondDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[SecondDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
        switch (indexPath.row) {
            case 2:
                cell.TitleLabel.text = @"产品介绍";
                break;
            case 3:
                cell.TitleLabel.text = @"产品详细";
                break;
            case 4:
                cell.TitleLabel.text = @"投资纪录";
                break;
            default:
                break;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    SectionViewController *sVC = [[SectionViewController alloc] init];
    //    sVC.rowLabelText = [NSString stringWithFormat:@"第%ld组的第%ld个cell",(long)indexPath.section,(long)indexPath.row];
    //    [self presentViewController:sVC animated:YES completion:nil];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    isFirstCome = YES;
    
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
