//
//  ChangePWViewController.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/25.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "ChangePWViewController.h"

#import "ChangePWTableViewCell.h"
@interface ChangePWViewController ()<UITableViewDataSource,UITableViewDelegate,ChangePWTableViewCellDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,copy)NSString* _token;
@property(nonatomic,copy)NSString* _errorCode;

@property(nonatomic,copy)NSString* _uoldPW;
@property(nonatomic,copy)NSString* _unewPW;
@property(nonatomic,copy)NSString* _unewPW1;
@end

@implementation ChangePWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createTableView];
    
    [self makeSendView];
}

- (void)makeSendView{
    UIButton* sendBtn = [MyController createButtonWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame), [MyController getScreenWidth], 50) ImageName:nil Target:self Action:@selector(sendBtnClick) Title:@"保存"];
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendBtn setBackgroundColor:[MyController colorWithHexString:@"4c89f0"]];
    [self.view addSubview:sendBtn];
}

- (void)sendBtnClick{
    NSLog(@"保存");
    NSUserDefaults*userDefaults=[NSUserDefaults standardUserDefaults];
    NSString* lastOldPW = [userDefaults objectForKey:@"password"];
    if (![MyController returnStr:self._uoldPW].length) {
        [HUD warning:@"请输入原始密码"];
        return;
    }else if(![MyController returnStr:self._unewPW].length){
        [HUD warning:@"请输入新密码"];
        return;
    }else if(![MyController returnStr:self._unewPW1].length){
        [HUD warning:@"请输入确认密码"];
        return;
    }else if(![self._unewPW isEqualToString:self._unewPW1]){
        [HUD warning:@"新密码与确认密码不一致"];
        return;
    }else if (![lastOldPW isEqualToString:self._uoldPW]){
        [HUD warning:@"原始密码输入有误"];
        return;
    }
    
    [requestService postCreateTokenWithUserId:[MyController getUserid] cname:[MyController getCName] complate:^(id responseObject) {
        if ([responseObject[@"result"] intValue]) {
            NSDictionary* souDic = [MyController dictionaryWithJsonString:responseObject[@"data"]];
            self._token = souDic[@"token"];
            self._errorCode = souDic[@"errorCode"];

            [requestService postChangePassWithUserId:[MyController getUserid] oldPassword:self._uoldPW newPassword:self._unewPW token:self._token complate:^(id responseObject) {
                if ([responseObject[@"result"] intValue]) {
                    NSUserDefaults *accountDefault5 = [NSUserDefaults standardUserDefaults];
                    [accountDefault5 setObject:self._unewPW forKey:@"password"];
                    [HUD success:responseObject[@"data"]];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            } failure:^(NSError *error) {
                
            }];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

#pragma mark - 初始化tableView
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [MyController isIOS7], self.view.frame.size.width, [MyController getScreenHeight] - [MyController isIOS7] - 50) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    //分割线类型
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
    NSString *cellIdentifier = @"ChangePWTableViewCell";
    ChangePWTableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!celll) {
        celll = [[ChangePWTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    celll.ChangePWTableViewCellDelegate = self;
    [celll configCellWithModel];
    return celll;
}

#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ChangePWTableViewCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        ChangePWTableViewCell *cell = (ChangePWTableViewCell *)sourceCell;
        [cell configCellWithModel];
    }];
}

- (void)sendBackTextIndex:(NSInteger)index AndText:(NSString *)text{
    if (0 == index) {
        self._uoldPW = text;
    }else if(1 == index) {
        self._unewPW = text;
    }else if(2 == index) {
        self._unewPW1 = text;
    }
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
