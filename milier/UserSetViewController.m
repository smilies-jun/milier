//
//  UserSetViewController.m
//  milier
//
//  Created by amin on 17/4/21.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "UserSetViewController.h"
#import "UserViewController.h"
#import "UserSetView.h"
#import "ModifyLoginViewController.h"
#import "ModifySailViewController.h"
#import <AwAlertViewlib/AwAlertViewlib.h>
#import "SecondViewController.h"
#import "BundCardViewController.h"
#import "SYNetWorkingUpLoad.h"
#import "SalePassWordViewController.h"
#import "SalePassWordViewController.h"
#import "ChangeBankCardViewController.h"

@interface UserSetViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,SYNetworkUploadDelegat>{
    UserSetView *ImageSetView;
    UserSetView *PassSetView;
    UserSetView *SailSetView;
    UserSetView *BundSetView;
    UIImageView *YinHangImageView;
    UILabel *YinHangLabel;
    UILabel *SaleLabel;
    UILabel *SureLabel;
    AwAlertView *awlertView;
    NSDictionary  *MyDic;
    NSDictionary *BankDic;
}
@property (nonatomic, strong) SYNetWorkingUpLoad* networkUpload;

@end

@implementation UserSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"账号设置";
    self.view.backgroundColor = colorWithRGB(0.94, 0.94, 0.94);
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 0, 44, 44);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow"] forState:UIControlStateNormal];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,8 *SCREEN_WIDTH/375.0)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];

    [leftBtn addTarget:self action:@selector(UserSetClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    MyDic = [[NSDictionary alloc]init];
    BankDic = [[NSDictionary alloc]init];
    [self reloadData];
    [self ConfigUI];
}
- (void)reloadData{
    NSString *url;
    NSString *userID = NSuserUse(@"userId");
    NSString *tokenID = NSuserUse(@"Authorization");
    
    url = [NSString stringWithFormat:@"%@/%@",USER_URL,userID];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:url withTokenStr:tokenID  usingBlock:^(NSDictionary *result, NSError *error) {
        MyDic = [result objectForKey:@"data"];
      //  NSLog(@"re == %@",result);
//         NSString *BankUrl;
//        NSString *bankID = [MyDic objectForKey:@"bankCardId"];
//        BankUrl = [NSString stringWithFormat:@"%@/banks/%@",HOST_URL,bankID];
//        [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:BankUrl withTokenStr:nil  usingBlock:^(NSDictionary *result, NSError *error) {
//            BankDic = [result objectForKey:@"items"];
//              BundSetView.DetailLabel.text = [NSString stringWithFormat:@"%@更换银行卡",[result objectForKey:@"message"]];
//            NSLog(@"message == %@",[result objectForKey:@"message"]);
//           // [self ConfigUI];
//        }];
        [self ConfigUI];
    }];
    

}
- (void)ConfigUI{
    ImageSetView = [[UserSetView alloc]init];
    ImageSetView.StaticImageView.image = [UIImage imageNamed:@"changehead"];
    ImageSetView.NameLabel.text  = @"更换头像";
    NSString *PhoneID = NSuserUse(@"phoneNumber");
    ImageSetView.DetailLabel.text = [NSString stringWithFormat:@"%@",PhoneID];
    
    ImageSetView.DetailLabel.textColor = colorWithRGB(0.95, 0.6, 0.11);
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"账号 %@",PhoneID]];
    NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:@"帐号"].location, [[noteStr string] rangeOfString:@"帐号"].length);
    //需要设置的位置
    [noteStr addAttribute:NSForegroundColorAttributeName value:colorWithRGB(0.56, 0.56, 0.56) range:redRange];
    //设置颜色
    [ImageSetView.DetailLabel setAttributedText:noteStr];
    
    ImageSetView.userInteractionEnabled = YES;
    UITapGestureRecognizer *ImageTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ImageSetClick)];
    [ImageSetView addGestureRecognizer:ImageTap];
    [self.view addSubview:ImageSetView];
    [ImageSetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.view.mas_top).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(65);
    }];
    
    
    PassSetView = [[UserSetView alloc]init];
    PassSetView.StaticImageView.image = [UIImage imageNamed:@"loginpassword"];
    PassSetView.NameLabel.text  = @"修改登录密码";
    PassSetView.DetailLabel.text = @"登录米粒儿账户时需要密码";
    PassSetView.DetailLabel.textColor = colorWithRGB(0.56, 0.56, 0.56);
    UITapGestureRecognizer *LoginTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(LoginSetClick)];
    [PassSetView addGestureRecognizer:LoginTap];
    PassSetView.userInteractionEnabled = YES;
    [self.view addSubview:PassSetView];
    [PassSetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(ImageSetView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(65);
    }];
    SailSetView = [[UserSetView alloc]init];
    SailSetView.StaticImageView.image = [UIImage imageNamed:@"cardpassword"];
    NSString *dealPassWordID = NSuserUse(@"dealPasswordExist");
    if ([dealPassWordID integerValue] == 1) {
        SailSetView.NameLabel.text  = @"修改交易密码";
  
    }else{
        SailSetView.NameLabel.text  = @"设置交易密码";
  
    }
    
    SailSetView.DetailLabel.text = @"保证您在米粒儿平台的交易安全，请妥善保管";
    SailSetView.DetailLabel.textColor = colorWithRGB(0.56, 0.56, 0.56);
    if (SCREEN_WIDTH == 320) {
        SailSetView.DetailLabel.font = [UIFont systemFontOfSize:13];
        SailSetView.DetailLabel.numberOfLines = 0;
        [SailSetView.DetailLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(SailSetView.NameLabel.mas_bottom);
            make.width.mas_equalTo(230);
            make.height.mas_equalTo(40);
        }];
    }
    SailSetView.userInteractionEnabled = YES;
    UITapGestureRecognizer *SailTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SailSetClick)];
    [SailSetView addGestureRecognizer:SailTap];
    [self.view addSubview:SailSetView];
    [SailSetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(PassSetView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(65);
    }];
    BundSetView = [[UserSetView alloc]init];
    BundSetView.StaticImageView.image = [UIImage imageNamed:@"creditcard"];
  
    BundSetView.DetailLabel.textColor = colorWithRGB(0.95, 0.6, 0.11);
    NSString *bankCardID = NSuserUse(@"bankCardExist");
    if ([bankCardID integerValue] ==1) {
        BundSetView.NameLabel.text  = @"更换银行卡";
        BundSetView.DetailLabel.text = [NSString stringWithFormat:@"(%@)%@",[MyDic objectForKey:@"bankName"],[MyDic objectForKey:@"bankCardNumberSuffix"]];
    }else{
          BundSetView.NameLabel.text  = @"绑定银行卡";
        BundSetView.DetailLabel.text = @"未绑定银行卡";
        
        //

    }
    
    
    BundSetView.userInteractionEnabled = YES;
    UITapGestureRecognizer *BundTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(BundClick)];

    [BundSetView addGestureRecognizer:BundTap];
    [self.view addSubview:BundSetView];
    [BundSetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(SailSetView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(65);
    }];
    SaleLabel = [[UILabel alloc]init];
    SaleLabel.text = @"退出账号";
    SaleLabel.userInteractionEnabled = YES;
    SaleLabel.font = [UIFont systemFontOfSize:15];
    SaleLabel.backgroundColor = colorWithRGB(0.95, 0.6, 0.11);
    SaleLabel.textAlignment = NSTextAlignmentCenter;
    SaleLabel.textColor = [UIColor whiteColor];
    SaleLabel.layer.cornerRadius = 22;
    SaleLabel.layer.masksToBounds = YES;
    [self.view addSubview:SaleLabel];
    [SaleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(BundSetView.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(44);
    }];
    
    UITapGestureRecognizer *SaleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SetBackBtn
                                                                                                          )];
    [SaleLabel addGestureRecognizer:SaleTap];
}
-(void)BundClick{
    NSString *bankCardID = NSuserUse(@"bankCardExist");

    if ([bankCardID integerValue] ==1) {
       // BundSetView.DetailLabel.text = @"已认证绑定  dsfsdf";
        
        ChangeBankCardViewController*loginVC = [[ChangeBankCardViewController alloc]init];
        loginVC.BankName = [MyDic objectForKey:@"bankName"];
        loginVC.BankCard = [MyDic objectForKey:@"bankCardNumberSuffix"];
        [self.navigationController   pushViewController:loginVC animated:NO];
        
    }else{
        BundSetView.DetailLabel.text = @"未绑定银行卡";
        BundCardViewController *bundVC = [[BundCardViewController alloc]init];
        bundVC.MoneyType = @"3";
        
        [self.navigationController pushViewController:bundVC animated:NO];
        //
        
    }
    
    }

- (void)ShowBank{
    //绑定银行卡
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 320)];
    view.backgroundColor=[UIColor whiteColor];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 5.0f;
    view.alpha = 0.9;
    UILabel *WarningLabel = [[UILabel alloc]init];
    WarningLabel.text = @"提示";
    WarningLabel.textColor = [UIColor blackColor];
    WarningLabel.font = [UIFont systemFontOfSize:13];
    WarningLabel.frame = CGRectMake(10, 10, 40, 20);
    WarningLabel.textAlignment = NSTextAlignmentLeft;
    [view addSubview:WarningLabel];
    UIImageView *CanCelView = [[UIImageView alloc]init];
    UITapGestureRecognizer *tapClick = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SureBackBtn)];
    CanCelView.userInteractionEnabled = YES;
    [CanCelView addGestureRecognizer:tapClick];
    CanCelView.image = [UIImage imageNamed:@"close"];
    CanCelView.frame = CGRectMake(SCREEN_WIDTH - 30, 10, 20, 20);
    [view addSubview:CanCelView];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
    lineView.frame = CGRectMake(0, 40, SCREEN_WIDTH, 0.5);
    [view addSubview:lineView];
    
    
    UIImageView *TiShiImageView = [[UIImageView alloc]init];
    TiShiImageView.image = [UIImage imageNamed:@"tip"];
    [view addSubview:TiShiImageView];
    [TiShiImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(lineView.mas_bottom).offset(40);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    
    UILabel *MessageLabel = [[UILabel alloc]init];
    MessageLabel.text = @"若需修改默认银行卡";
    MessageLabel.textAlignment = NSTextAlignmentCenter;
    MessageLabel.textColor = colorWithRGB(0.95, 0.6, 0.11);
    MessageLabel.font = [UIFont systemFontOfSize:14];
    [view addSubview:MessageLabel];
    [MessageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(TiShiImageView.mas_centerX);
        make.top.mas_equalTo(TiShiImageView.mas_bottom).offset(10);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *KeFuLabel = [[UILabel alloc]init];
    KeFuLabel.text = @"请联系客服400-6261-677";
    KeFuLabel.textAlignment = NSTextAlignmentCenter;
    KeFuLabel.textColor = [UIColor blackColor];
    KeFuLabel.font = [UIFont systemFontOfSize:14];
    [view addSubview:KeFuLabel];
    [KeFuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(TiShiImageView.mas_centerX);
        make.top.mas_equalTo(MessageLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(30);
    }];
    YinHangImageView = [[UIImageView alloc]init];
    [YinHangImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[BankDic objectForKey:@"icon"]]] placeholderImage:[UIImage imageNamed:@"headpicUser"]options:SDWebImageAllowInvalidSSLCertificates];
    [view addSubview:YinHangImageView];
    [YinHangImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(KeFuLabel.mas_left);
        make.top.mas_equalTo(KeFuLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    YinHangLabel = [[UILabel alloc]init];
    YinHangLabel.text = [NSString stringWithFormat:@"%@(%@)",[MyDic objectForKey:@"bankName"],[MyDic objectForKey:@"bankCardNumberSuffix"]];
    YinHangLabel.textColor = [UIColor blackColor];
    YinHangLabel.textAlignment = NSTextAlignmentLeft;
    YinHangLabel.font = [UIFont systemFontOfSize:14];
    [view addSubview:YinHangLabel];
    [YinHangLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(YinHangImageView.mas_right).offset(10);
        make.top.mas_equalTo(KeFuLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(130);
        make.height.mas_equalTo(30);
    }];
    SureLabel = [[UILabel alloc]init];
    SureLabel.text = @"确定";
    SureLabel.userInteractionEnabled = YES;
    SureLabel.backgroundColor = colorWithRGB(0.95, 0.6, 0.11);
    SureLabel.textAlignment = NSTextAlignmentCenter;
    SureLabel.textColor = [UIColor whiteColor];
    SureLabel.layer.cornerRadius = 20;
    SureLabel.layer.masksToBounds = YES;
    [view addSubview:SureLabel];
    [SureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(TiShiImageView.mas_centerX);
        make.top.mas_equalTo(YinHangLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH - 80);
        make.height.mas_equalTo(40);
    }];
    
    UITapGestureRecognizer *SureTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SureBackBtn
                                                                                                          )];
    [SureLabel addGestureRecognizer:SureTap];
    awlertView=[[AwAlertView alloc]initWithContentView:view];
    awlertView.hidden = NO;
    awlertView.isUseHidden=YES;
    [awlertView showAnimated:YES];

}
- (void)SureBackBtn{
    [awlertView dismissAnimated:NO];
}
- (void)LoginSetClick{
   ModifyLoginViewController *loginVC = [[ModifyLoginViewController alloc]init];
   [self.navigationController   pushViewController:loginVC animated:NO];
}
- (void)SailSetClick{
    NSString *dealPassWord = NSuserUse(@"dealPasswordExist");
    if ([dealPassWord integerValue] == 1) {
        ModifySailViewController *SailVC = [[ModifySailViewController alloc]init];
        [self.navigationController   pushViewController:SailVC animated:NO];
    }else{
        SalePassWordViewController *SailVC = [[SalePassWordViewController alloc]init];
        [self.navigationController   pushViewController:SailVC animated:NO];
    }
    
   
}
- (void)ImageSetClick{
    /**
     *  弹出提示框
     */
    //初始化提示框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //按钮：从相册选择，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //初始化UIImagePickerController
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        //获取方式1：通过相册（呈现全部相册），UIImagePickerControllerSourceTypePhotoLibrary
        //获取方式2，通过相机，UIImagePickerControllerSourceTypeCamera
        //获取方法3，通过相册（呈现全部图片），UIImagePickerControllerSourceTypeSavedPhotosAlbum
        PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //允许编辑，即放大裁剪
        PickerImage.allowsEditing = YES;
        //自代理
        PickerImage.delegate = self;
        //页面跳转
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
    //按钮：拍照，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        /**
         其实和从相册选择一样，只是获取方式不同，前面是通过相册，而现在，我们要通过相机的方式
         */
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        //获取方式:通过相机
        PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
        PickerImage.allowsEditing = YES;
        PickerImage.delegate = self;
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
    //按钮：取消，类型：UIAlertActionStyleCancel
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
//PickerImage完成后的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //定义一个newPhoto，用来存放我们选择的图片。
    UIImage *newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    NSString *userID = NSuserUse(@"userId");
    NSString *tokenID = NSuserUse(@"Authorization");
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSData *imageData = UIImageJPEGRepresentation(newPhoto, 0.5);
        
        __block NSMutableDictionary* parameter = [[NSMutableDictionary alloc] init];
        parameter = [[NSMutableDictionary alloc]initWithObjectsAndKeys:tokenID,@"tokenID", nil];
        
        //1。创建管理者对象
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        manager.securityPolicy.allowInvalidCertificates = YES;
        [manager.securityPolicy setValidatesDomainName:NO];
        
        //2.上传文件
        
        NSString *urlString = [NSString stringWithFormat:@"%@/users/%@/avatar",HOST_URL,userID];
        NSDictionary *dict = @{@"Authorization":tokenID};
        
        [manager POST:urlString parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            //这个就是参数
            [formData appendPartWithFileData:imageData name:@"avatarFile" fileName:[NSString stringWithFormat:@"%@.png",userID] mimeType:@"image/png"];
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
            //打印下上传进度
            NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSuserSave([responseObject objectForKey:@"avatar"], @"avatar");
            //请求成功
            NSLog(@"请求成功：%@",responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            //请求失败
            NSLog(@"请求失败：%@",error);
        }];
        [self dismissViewControllerAnimated:YES completion:nil];
    });
    
   
}




- (void)SetBackBtn{
    NSuserRemove(@"userId");
    NSuserRemove(@"Authorization");
    NSuserRemove(@"bankCardExist");
    NSuserRemove(@"bankCardId");
    NSuserRemove(@"bankCardNumberSuffix");
    NSuserRemove(@"noneReceivedPropsCount");
    NSuserRemove(@"qiye");
    NSuserRemove(@"type");
    NSuserRemove(@"activityOid");
    NSuserRemove(@"Risk");
    NSuserSave(@"2", @"qiye");
    NSuserSave(@"1", @"heafresh");
    [self.navigationController popToRootViewControllerAnimated:NO];

}
- (void)UserSetClick{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[UserViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }

}
#pragma mark - 隐藏当前页面所有键盘-
- (void)HideKeyBoardClick{
    for (UIView *KeyView in self.view.subviews) {
        [self dismissAllKeyBoard:KeyView];
        
    }
    
}

- (BOOL)dismissAllKeyBoard:(UIView *)view{
    
    if([view isFirstResponder])
    {
        [view resignFirstResponder];
        return YES;
    }
    for(UIView *subView in view.subviews)
    {
        if([self dismissAllKeyBoard:subView])
        {
            return YES;
        }
    }
    return NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadData];
    [self ConfigUI];
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
