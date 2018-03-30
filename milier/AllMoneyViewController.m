//
//  AllMoneyViewController.m
//  milier
//
//  Created by amin on 2017/5/18.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "AllMoneyViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "SGQRCode.h"


@interface AllMoneyViewController (){
    NSDictionary *ShareDic;
    NSDictionary *UserDic;
}

@end

@implementation AllMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
      [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(AllTap) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    NSString *url;
    NSString *userID = NSuserUse(@"userId");
    NSString *tokenID = NSuserUse(@"Authorization");
    url = [NSString stringWithFormat:@"%@/%@",USER_URL,userID];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:url withTokenStr:tokenID  usingBlock:^(NSDictionary *result, NSError *error) {
        UserDic = [result objectForKey:@"data"];
    }];
    
    if ([_type isEqualToString:@"1"]) {
         self.navigationItem.title = @"米粒儿公告";
    }else{
         self.navigationItem.title = @"全民理财师";
        UIView *saleView = [[UIView alloc]init];
        saleView.backgroundColor = [UIColor whiteColor];
        saleView.frame = CGRectMake(0, SCREEN_HEIGHT - 64-60, SCREEN_WIDTH, 60);
        [self.view addSubview:saleView];
        UILabel *SaleLbel =  [[UILabel alloc]init];
        SaleLbel.text = @"分享赚钱";
        SaleLbel.userInteractionEnabled = YES;
        SaleLbel.backgroundColor = colorWithRGB(0.95, 0.60, 0.11);
        SaleLbel.textAlignment = NSTextAlignmentCenter;
        SaleLbel.textColor = [UIColor whiteColor];
        SaleLbel.layer.cornerRadius = 20;
        SaleLbel.layer.masksToBounds = YES;
        [saleView addSubview:SaleLbel];
        [SaleLbel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(saleView.mas_left).offset(40);
            make.centerY.mas_equalTo(saleView.mas_centerY);
            make.width.mas_equalTo(SCREEN_WIDTH - 100);
            make.height.mas_equalTo(40);
        }];
        UIImageView *PersonImage = [[UIImageView alloc]init];
        PersonImage.image = [UIImage imageNamed:@"code_lcs"];
        PersonImage.userInteractionEnabled = YES;
        [saleView addSubview:PersonImage];
        [PersonImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SaleLbel.mas_right).offset(10);
            make.centerY.mas_equalTo(saleView.mas_centerY);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(30);
        }];
        UITapGestureRecognizer *personTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(PersonClick
                                                                                                                )];
        [PersonImage addGestureRecognizer:personTap];
        
        UITapGestureRecognizer *SaleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ShareClick
                                                                                                              )];
        [SaleLbel addGestureRecognizer:SaleTap];
    }
    
   
}
- (void)PersonClick{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UILabel *myLabel = [[UILabel alloc]init];
    myLabel.text = @"我的邀请码";
    myLabel.textAlignment = NSTextAlignmentCenter;
    myLabel.frame = CGRectMake(0, 10, SCREEN_WIDTH-40, 20);
    [alertController.view addSubview:myLabel];
    UILabel *myLabelNumber = [[UILabel alloc]init];
    myLabelNumber.text = [NSString stringWithFormat:@"%@",[UserDic objectForKey:@"oid"]];
    myLabelNumber.textColor = colorWithRGB(0.96, 0.6, 0.12);
    myLabelNumber.textAlignment = NSTextAlignmentCenter;
    myLabelNumber.frame = CGRectMake(0, 35, SCREEN_WIDTH-40, 20);
    [alertController.view addSubview:myLabelNumber];
    
    
    
    UIImageView *customView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 70, SCREEN_WIDTH- 200, 150.0F)];
    NSString *userID = NSuserUse(@"userId");
    CGFloat scale = 0.2;
    // 2、将最终合得的图片显示在UIImageView上
    customView.image = [SGQRCodeTool SG_generateWithLogoQRCodeData:[NSString stringWithFormat:@"http://weixin.milibanking.com/weixin/weixin/activity/share?userId=%@",userID] logoImageName:[UserDic objectForKey:@"avatar"] logoScaleToSuperView:scale];
    
    
    [alertController.view addSubview:customView];
    
    
    
  
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {}];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:^{}];
    
}
- (void)ShareClick{
    NSString *Shareurl;
    Shareurl = [NSString stringWithFormat:@"%@/tools/shareMessage",HOST_URL];
    
    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:Shareurl withTokenStr:nil usingBlock:^(NSDictionary *result, NSError *error) {
        NSString *State = [result objectForKey:@"statusCode"];
        if ([State integerValue] == 200) {
            ShareDic = [result objectForKey:@"data"];
            [self shareMyUi];
        }
    }];
}
- (void)shareMyUi{
    //先构造分享参数：
    NSString *userID = NSuserUse(@"userId");
    NSString *Url;
    if ([userID integerValue] >0) {
        Url = [NSString stringWithFormat:@"%@?userId=%@",[ShareDic objectForKey:@"url"],userID];
    }else{
        Url = [NSString stringWithFormat:@"%@",[ShareDic objectForKey:@"url"]];
    }
    
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:[ShareDic objectForKey:@"content"]
                                     images:[NSString stringWithFormat:@"%@",[ShareDic objectForKey:@"image"]]
                                        url:[NSURL URLWithString:Url]
                                      title:[ShareDic objectForKey:@"title"]
                                       type:SSDKContentTypeAuto];
    //有的平台要客户端
    [shareParams SSDKEnableUseClientShare];
    //调用分享的方法
    SSUIShareActionSheetController *sheet = [ShareSDK showShareActionSheet:self.view
                                                                     items:nil
                                                               shareParams:shareParams
                                                       onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                                                           switch (state) {
                                                               case SSDKResponseStateSuccess:
                                                                   NSLog(@"分享成功!");
                                                                   break;
                                                               case SSDKResponseStateFail:
                                                                   NSLog(@"分享失败%@",error);
                                                                   break;
                                                               case SSDKResponseStateCancel:
                                                                   NSLog(@"分享已取消");
                                                                   break;
                                                               default:
                                                                   break;
                                                           }
                                                       }];
    
    //删除和添加平台示例
    //[sheet.directSharePlatforms removeObject:@(SSDKPlatformTypeWechat)];//(默认微信，QQ，QQ空间都是直接跳客户端分享，加了这个方法之后，可以跳分享编辑界面分享)
    // [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeSinaWeibo)];//（加了这个方法之后可以不跳分享编辑界面，直接点击分享菜单里的选项，直接分享）
    
}
- (void)AllTap{
    [self.navigationController    popToRootViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
