//
//  MoreHelpViewController.m
//  milier
//
//  Created by amin on 2017/5/19.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "MoreHelpViewController.h"
#import "MoreMoreHelpViewController.h"
#import "NewPersonViewController.h"


@interface MoreHelpViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *HelpArray;
    UITableView *HelpTableView;
    MBProgressHUD *hud;
}

@end

@implementation MoreHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = _TitleStr;
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
      [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    self.view.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(BackTap) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    HelpArray =[[NSArray alloc]init];
    [self GetData];
}
- (void)GetData{
    NSString *url =nil;
    if (_type == 1) {
        url = [NSString stringWithFormat:@"%@/menus/companyIntroduction",HOST_URL];
    }else if (_type == 2){
        url = [NSString stringWithFormat:@"%@/menus/security",HOST_URL];

    }else if (_type == 3){
        url = [NSString stringWithFormat:@"%@/menus/noviceGuide",HOST_URL];

    }else {
        url = [NSString stringWithFormat:@"%@/menus/guides",HOST_URL];

    }
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:url withTokenStr:@"" usingBlock:^(NSDictionary *result, NSError *error) {
        HelpArray = [result objectForKey:@"items"];
        [self ConfigUI];
    }];

}
- (void)HideProgress{
     [hud hideAnimated:YES afterDelay:1.f];
}
- (void)showProgress{
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    
    // Set the label text.
    
    hud.label.text = NSLocalizedString(@"正在请求中", @"HUD loading title");
}

- (void)ConfigUI{
    HelpTableView = [[UITableView alloc]init];
    HelpTableView.dataSource = self;
    HelpTableView.delegate = self;
    HelpTableView.tableFooterView = [UIView new];
    HelpTableView.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
    HelpTableView.frame = CGRectMake(0,64+10, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:HelpTableView];
    
    
}

#pragma mark - UITableViewDelegate  UITableViewDataSource

//header-height
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 0;
    
}
//header-secion
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [UIView new];
}

//footer-hegiht
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

//footer-section
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}


//sections-tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
//rows-section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return HelpArray.count;
}
//cell-height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

//cell-tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"productidentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    
    cell.textLabel.text =[[HelpArray objectAtIndex:indexPath.row]objectForKey:@"title"];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *GrowImageView = [[UIImageView alloc]init];
    GrowImageView.frame = CGRectMake(SCREEN_WIDTH - 40, 20,15, 15);
    GrowImageView.image = [UIImage imageNamed:@"goarrow"];
    [cell.contentView addSubview:GrowImageView];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_type == 4) {
        NewPersonViewController *vc= [[NewPersonViewController alloc]init];
        vc.TitleStr =[NSString stringWithFormat:@"%@",[[HelpArray objectAtIndex:indexPath.row]objectForKey:@"title"]];
        vc.OidStr   = [NSString stringWithFormat:@"%@",[[HelpArray objectAtIndex:indexPath.row]objectForKey:@"oid"]];
        [self.navigationController pushViewController:vc animated:NO];
    }else{
        MoreMoreHelpViewController *vc= [[MoreMoreHelpViewController alloc]init];
        vc.TitleStr =[NSString stringWithFormat:@"%@",[[HelpArray objectAtIndex:indexPath.row]objectForKey:@"title"]];
        vc.WebStr = [NSString stringWithFormat:@"%@/%@",HOST_URL,[[HelpArray objectAtIndex:indexPath.row] objectForKey:@"url"]];
        [self.navigationController pushViewController:vc animated:NO];
    }
    
}
-(void)BackTap{
    [self.navigationController popToRootViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    　[self  ConfigUI];
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
