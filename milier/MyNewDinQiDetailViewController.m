//
//  MyNewDinQiDetailViewController.m
//  milier
//
//  Created by amin on 2017/7/28.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "MyNewDinQiDetailViewController.h"
#import "MyNewDinQiViewController.h"
#import "DinQiModel.h"
#import "DinQiListTableViewCell.h"
#import "DinQiSaleTableViewCell.h"
#import "DinQiJiXiTableViewCell.h"
#import "DinQiJiXiDetailTableViewCell.h"
#import "BundProfileViewController.h"
#import "ChangeSailDetailViewController.h"


@interface MyNewDinQiDetailViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *DinQiTopArray;
    NSMutableArray *DinQiDetailArray;
    NSMutableArray *DinQiJiXiDetailArray;
}
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation MyNewDinQiDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"定期投资详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow"] forState:UIControlStateNormal];
    
    [leftBtn addTarget:self action:@selector(DinQiDetailClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    DinQiTopArray  =  [[NSMutableArray alloc]init];
    DinQiDetailArray = [[NSMutableArray alloc]init];
    DinQiJiXiDetailArray = [[NSMutableArray alloc]init];
    
    [self getNetworkData:YES];
    [self ConfigUI];
}


-(void)getNetworkData:(BOOL)isRefresh
{
    NSString *Bottomurl;
    NSString *tokenID = NSuserUse(@"Authorization");
        Bottomurl = [NSString stringWithFormat:@"%@/productOrders/%@/details",HOST_URL,_oid];
        [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:Bottomurl withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
                DinQiModel *model = [[DinQiModel alloc]init];
                model.dataDictionary = [result objectForKey:@"items"];
                [DinQiDetailArray addObject:model];
            [_tableView reloadData];
        }];

    
    NSString *url;
    url = [NSString stringWithFormat:@"%@/productOrders/%@/detailsSub",HOST_URL,_oid];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        NSArray *DinQiArray = [result objectForKey:@"items"];
        if (DinQiArray.count) {
            for (NSDictionary *dic in DinQiArray) {
                DinQiModel *model = [[DinQiModel alloc]init];
                model.dataDictionary = dic;
                [DinQiJiXiDetailArray addObject:model];

            }
            [_tableView reloadData];

        }
        
    }];
}
-(void)ConfigUI{
    
    _tableView = [[MyTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
    //_tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadoneNew)];
    //_tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadoneMore)];
    [self.view addSubview:_tableView];
    UIView * BottomView = [[UIView alloc]init];
    BottomView.backgroundColor = [UIColor whiteColor];
    BottomView.alpha = 0.9;
    [self.view addSubview:BottomView];
    [BottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    


    UIButton *PayLabel =[UIButton buttonWithType:UIButtonTypeCustom];
    [PayLabel setTitle:@"取消转让" forState:UIControlStateNormal];
    PayLabel.userInteractionEnabled = YES;
    [PayLabel addTarget:self action:@selector(CancelClick:) forControlEvents:UIControlEventTouchUpInside];
    PayLabel.backgroundColor = [UIColor orangeColor];
    PayLabel.layer.cornerRadius = 20;
    PayLabel.layer.masksToBounds = YES;
    [BottomView addSubview:PayLabel];
    [PayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BottomView.mas_left).offset(10);
        make.centerY.mas_equalTo(BottomView.mas_centerY);
        make.width.mas_equalTo(SCREEN_WIDTH/2-30);
        make.height.mas_equalTo(40);
    }];
        UILabel *CashLabel =[[UILabel alloc]init];
    CashLabel.text = @"查看协议";
    CashLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *CashTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SayClick)];
    [CashLabel addGestureRecognizer:CashTap];
    CashLabel.textColor = [UIColor orangeColor];
    CashLabel.textAlignment = NSTextAlignmentCenter;
    CashLabel.backgroundColor = [UIColor whiteColor];
    CashLabel.layer.cornerRadius = 20;
    CashLabel.layer.masksToBounds = YES;
    CashLabel.layer.borderWidth = 1.0;
    CashLabel.layer.borderColor = [UIColor orangeColor].CGColor;
    [BottomView addSubview:CashLabel];
    [CashLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(BottomView.mas_right).offset(-10);
        make.centerY.mas_equalTo(BottomView.mas_centerY);
        make.width.mas_equalTo(SCREEN_WIDTH/2-30);
        make.height.mas_equalTo(40);
    }];
    if ([_Type integerValue] == 1) {
        PayLabel.hidden = NO;
        if ([_State integerValue]  == 2) {
            [PayLabel setTitle:@"债权转让" forState:UIControlStateNormal];
            
        }else{
            
            
        }
    }else{
        if ([_State integerValue]  == 5) {
            [PayLabel setTitle:@"取消转让" forState:UIControlStateNormal];
            PayLabel.hidden = NO;
            
        }else{
            PayLabel.hidden = YES;
            [CashLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(SCREEN_WIDTH - 20);
            }];
        }
        
        
        
    }

}
- (void)SayClick{
    DinQiModel *model = [DinQiDetailArray objectAtIndex:0];
    BundProfileViewController *vc= [[BundProfileViewController alloc]init];
    vc.TitleStr = @"米粒儿金融借款协议";
    vc.TypeStr = @"1";
    vc.WebStr = [NSString stringWithFormat:@"http://weixin.milibanking.com/weixin/weixin/user/toProtocol?productinfoOrderId=%@&stp=app",model.oid];
    [self.navigationController pushViewController:vc animated:NO];
}
- (void)CancelClick:(UIButton *)btn{
    if ([btn.titleLabel.text isEqualToString:@"债权转让>>"]) {
        ChangeSailDetailViewController *ChangeVC = [[ChangeSailDetailViewController alloc]init];
        DinQiModel *model = [DinQiDetailArray objectAtIndex:0];
        ChangeVC.TitleName = [NSString stringWithFormat:@"%@",model.name];
        ChangeVC.MoneyName = [NSString stringWithFormat:@"%@",model.ci];
        ChangeVC.TimeName = [NSString stringWithFormat:@"%@",model.InterestBearingEndTime];
        ChangeVC.OrderNumber = [NSString stringWithFormat:@"%@",model.orderNo];
        [self.navigationController pushViewController:ChangeVC animated:NO];
    }else{
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"
                                                                                 message:@"是否取消转让"
                                                                          preferredStyle:UIAlertControllerStyleAlert ];
        
        //添加取消到UIAlertController中
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:cancelAction];
        
        //添加确定到UIAlertController中
        UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSString *Statisurl;
            NSString *tokenID = NSuserUse(@"Authorization");
            Statisurl = [NSString stringWithFormat:@"%@/products/action/deleteDebentureTransferProduct",HOST_URL];
            DinQiModel *model = [DinQiDetailArray objectAtIndex:0];
            
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:model.orderNo,@"orderNo", nil];;
            [[DateSource sharedInstance]requestHomeWithParameters:dic withUrl:Statisurl withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
                NSString *state = [result objectForKey:@"statusCode"];
                if ([state integerValue]  == 201) {
                    [self getNetworkData:YES];
                }else{
                    NSString *message = [result objectForKey:@"message"];
                    normal_alert(@"提示", message, @"确定");
                }
            }];
            
        }];
        [alertController addAction:OKAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        
    }

}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"== %lu",(unsigned long)[DinQiJiXiDetailArray count]);
    return [DinQiDetailArray count] + 2 + [DinQiJiXiDetailArray count];
}


//组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 150;
    }else if (indexPath.row == 1){
        return 70;
    }
    return 50;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        static NSString *identifier = @"DinQiListProidentifier";
        
        DinQiListTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[DinQiListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
        if (DinQiDetailArray.count) {
            DinQiModel *model = [DinQiDetailArray objectAtIndex:0];
            cell.DinqiModel = model;
        }
        cell.RowImageView.hidden = YES;
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }else if (indexPath.row == 1){
        static NSString *identifier = @"DinQiSaleProidentifier";
        
        DinQiSaleTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[DinQiSaleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
        
        if (DinQiDetailArray.count) {
           DinQiModel *model = [DinQiDetailArray objectAtIndex:0];
            NSString *timeStr = [self getTimeStr:model.createTime withForMat:@"yyyy-MM-dd"];

            cell.SaleLabel.text = [NSString stringWithFormat:@"购买时间：%@",timeStr];
//            cell.DinqiModel = model;
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }else if (indexPath.row == 2){
        static NSString *identifier = @"DinQiJiXiProidentifier";
        
        DinQiJiXiTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[DinQiJiXiTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
        if (DinQiDetailArray.count) {
            DinQiModel *model = [DinQiDetailArray objectAtIndex:0];
            NSString *timeStr = [self getTimeStr:model.InterestBearingStartTime withForMat:@"yyyy-MM-dd"];

            cell.SaleLabel.text = [NSString stringWithFormat:@"计息时间：%@",timeStr];
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }else{
        static NSString *identifier = @"DinQiJiXiDetailProidentifier";
        
        DinQiJiXiDetailTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[DinQiJiXiDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
        if (DinQiJiXiDetailArray.count) {
            
            DinQiModel *model = [DinQiJiXiDetailArray objectAtIndex:indexPath.row - 3];
            NSString *timeStr = [self getTimeStr:model.repaymentTime withForMat:@"yyyy-MM-dd"];
            cell.SaleLabel.text = [NSString stringWithFormat:@"第%ld次付息：%@",indexPath.row - 2,timeStr];
            cell.MoneyLabel.text = [NSString stringWithFormat:@"%@元",model.amount];
            if ([model.state integerValue]) {
                cell.SaleImageView.hidden = NO;
            }else{
                cell.SaleImageView.hidden = YES;
            }
            
        }
        
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }
    
    
    
    
}

- (NSString *)getTimeStr:(NSString *)MyTimeStr withForMat:(NSString *)formatStr{
    NSTimeInterval interval=[MyTimeStr doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:formatStr];
    NSString * timeStr = [NSString stringWithFormat:@"%@",[objDateformat stringFromDate: date]];
    return timeStr;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)DinQiDetailClick{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[MyNewDinQiViewController class]]) {
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
