//
//  LoginViewController.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/8.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "LoginViewController.h"

#import "ApplyViewController.h"
@interface LoginViewController ()<UITableViewDataSource,UITableViewDelegate,ImagePickerSheetViewControllerDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,strong)UIImageView* logoImageView;
@property(nonatomic,strong)UIImageView* zhImageView;
@property(nonatomic,strong)UIImageView* nameImageView;
@property(nonatomic,strong)UIImageView* pwdImageView;

@property(nonatomic,strong)UITextField* zhTextfield;
@property(nonatomic,strong)UITextField* nameTextfield;
@property(nonatomic,strong)UITextField* pwdTextfield;

@property(nonatomic,strong)UIButton* loginButton;
@property(nonatomic,strong)UIButton* tryButton;

@property(nonatomic,copy)NSString* _token;
@property(nonatomic,copy)NSString* _errorCode;

@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [MyController colorWithHexString:@"f7f7f9"];
    [self createTableView];
}
#pragma mark - 初始化tableView
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], [MyController getScreenHeight]) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
}

#pragma mark - tableView行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* celll = [[UITableViewCell alloc] init];
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    self.logoImageView = [[UIImageView alloc] init];
    self.logoImageView.image = [UIImage imageNamed:@"logo"];
    [celll addSubview:self.logoImageView];
//    self.logoImageView.backgroundColor = [UIColor redColor];
    
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(60);
        make.centerX.mas_equalTo(celll.contentView);
        make.height.mas_offset(50);
        make.width.mas_offset(119);
    }];
    
    self.zhImageView = [[UIImageView alloc] init];
    [celll addSubview:self.zhImageView];
    self.zhImageView.image = [UIImage imageNamed:@"登录框背景"];
//    self.zhImageView.backgroundColor = [UIColor redColor];
    [self.zhImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.logoImageView.mas_bottom).mas_offset(40);
        make.centerX.mas_equalTo(celll);
        make.width.mas_offset(230);
        make.height.mas_offset(55);
    }];
    
    self.zhTextfield = [MyController createTextFieldWithFrame:self.zhImageView.frame placeholder:@"请输入组织名" passWord:NO leftImageView:nil rightImageView:nil Font:16];
    self.zhTextfield.textAlignment = NSTextAlignmentCenter;
    self.zhTextfield.text = @"青岛一凌网集成有限公司";
    [celll addSubview:self.zhTextfield];
    
    [self.zhTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.zhImageView);
        make.left.mas_equalTo(self.zhImageView);
        make.right.mas_equalTo(self.zhImageView);
        make.height.mas_equalTo(self.zhImageView);
    }];
    
    self.nameImageView = [[UIImageView alloc] init];
    [celll addSubview:self.nameImageView];
    self.nameImageView.image = [UIImage imageNamed:@"登录框背景"];
    self.nameImageView.backgroundColor = [UIColor whiteColor];
    [self.nameImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.zhImageView.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self.zhImageView);
        make.right.mas_equalTo(self.zhImageView);
        make.height.mas_equalTo(self.zhImageView);
    }];
    
    self.nameTextfield = [MyController createTextFieldWithFrame:self.nameImageView.frame placeholder:@"请输入用户名" passWord:NO leftImageView:nil rightImageView:nil Font:16];
    self.nameTextfield.textAlignment = NSTextAlignmentCenter;
    self.nameTextfield.text = @"xurq";
    [celll addSubview:self.nameTextfield];
    
    [self.nameTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameImageView);
        make.left.mas_equalTo(self.nameImageView);
        make.right.mas_equalTo(self.nameImageView);
        make.height.mas_equalTo(self.nameImageView);
    }];
    
    self.pwdImageView = [[UIImageView alloc] init];
    [celll addSubview:self.pwdImageView];
    self.pwdImageView.image = [UIImage imageNamed:@"登录框背景"];
    self.pwdImageView.backgroundColor = [UIColor whiteColor];
    [self.pwdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameImageView.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self.nameImageView);
        make.right.mas_equalTo(self.nameImageView);
        make.height.mas_equalTo(self.nameImageView);
    }];

    self.pwdTextfield = [MyController createTextFieldWithFrame:self.pwdImageView.frame placeholder:@"请输入密码" passWord:YES leftImageView:nil rightImageView:nil Font:16];
    self.pwdTextfield.textAlignment = NSTextAlignmentCenter;
    self.pwdTextfield.text = @"123456";
    [celll addSubview:self.pwdTextfield];
    
    [self.pwdTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pwdImageView);
        make.left.mas_equalTo(self.pwdImageView);
        make.right.mas_equalTo(self.pwdImageView);
        make.height.mas_equalTo(self.pwdImageView);
    }];
    
    self.loginButton = [MyController createButtonWithFrame:self.view.frame ImageName:@"登录" Target:self Action:@selector(loginButtonClick) Title:nil];
    [celll addSubview:self.loginButton];
//    [self.loginButton setBackgroundColor:[UIColor redColor]];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pwdImageView.mas_bottom).mas_offset(28);
        make.centerX.mas_equalTo(celll);
        make.width.mas_offset(150);
        make.height.mas_offset(54);
    }];
    
    self.tryButton = [MyController createButtonWithFrame:celll.frame ImageName:@"试用" Target:self Action:@selector(tryButtonClick) Title:nil];
    [celll addSubview:self.tryButton];
//    [self.tryButton setBackgroundColor:[UIColor redColor]];
    
    [self.tryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loginButton.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self.loginButton);
        make.right.mas_equalTo(self.loginButton);
        make.height.mas_equalTo(self.loginButton);
    }];
    
    return celll;
}

/**
 登录按钮响应
 */
- (void)loginButtonClick{
     if (![MyController returnStr:self.zhTextfield.text].length) {
        [HUD warning:@"请填写企业名称"];
        return;
     }else if(![MyController returnStr:self.nameTextfield.text].length){
         [HUD warning:@"请填写姓名"];
         return;
     }else if(![MyController returnStr:self.pwdTextfield.text].length){
         [HUD warning:@"请输入密码"];
         return;
     }
    [self loginButtonClick1];
    [requestService postLoginWithUserName:self.nameTextfield.text cname:self.zhTextfield.text password:self.pwdTextfield.text complate:^(id responseObject) {
        if ([responseObject[@"result"] intValue]) {
            NSDictionary* souDic = [MyController dictionaryWithJsonString:responseObject[@"data"]];
            
            //把个人信息数据存到本地
            NSUserDefaults *accountDefault = [NSUserDefaults standardUserDefaults];
            [accountDefault setObject:souDic[@"userId"] forKey:@"userId"];
            
            NSUserDefaults *accountDefault1 = [NSUserDefaults standardUserDefaults];
            [accountDefault1 setObject:[MyController returnStr:souDic[@"nickName"]] forKey:@"nickName"];
            
            NSUserDefaults *accountDefault2 = [NSUserDefaults standardUserDefaults];
            [accountDefault2 setObject:[MyController returnStr:souDic[@"enterprise"]] forKey:@"enterprise"];
            
            //用户名
            [[NSUserDefaults standardUserDefaults] setObject:[MyController returnStr:souDic[@"enterprise"]] forKey:@"companyName"];
            
            NSUserDefaults *accountDefault3 = [NSUserDefaults standardUserDefaults];
            [accountDefault3 setObject:[MyController returnStr:souDic[@"userName"]] forKey:@"userName"];
            
            NSUserDefaults *accountDefault4 = [NSUserDefaults standardUserDefaults];
            [accountDefault4 setObject:[MyController returnStr:souDic[@"headImg"]] forKey:@"headImg"];
            
            NSUserDefaults *accountDefault5 = [NSUserDefaults standardUserDefaults];
            [accountDefault5 setObject:self.pwdTextfield.text forKey:@"password"];
            
            NSUserDefaults *accountDefault6 = [NSUserDefaults standardUserDefaults];
            [accountDefault6 setObject:[MyController returnStr:souDic[@"phone"]] forKey:@"phone"];
            
            [[NSUserDefaults standardUserDefaults]synchronize];
            //设置别名
            [JPUSHService setAlias:[NSString stringWithFormat:@"%@%@",[MyController getCName],[MyController getUserid]] callbackSelector:@selector(callBack) object:nil];
            [(AppDelegate *)[UIApplication sharedApplication].delegate setRootVC];
        }
    } failure:^(NSError *error) {
        
        
    }];
}


/**
 登录按钮响应
 */
- (void)loginButtonClick1{
    NSLog(@"登录");
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder)
                                               to:nil
                                             from:nil
                                         forEvent:nil];
    
    if (!self.zhTextfield.text.length) {
        [HUD warning:@"请输入公司名"];
        return;
    }
    [HUD loading];
    
    [requestService postAllRequest:self.zhTextfield.text complate:^(id responseObject) {
        NSLog(@"%@",responseObject[@"data"]);
        if ([responseObject[@"result"] intValue]) {
            [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"data"] forKey:@"requestIP"];
        }
    } failure:^(NSError *error) {
        
    }];
    
    
}



- (void)callBack{
    
}
/**
 申请试用按钮响应
 */
- (void)tryButtonClick{
    NSLog(@"申请试用");
    ApplyViewController* vc = [[ApplyViewController alloc] init];
    vc.title = @"申请试用";
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [MyController getScreenHeight];
    
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
