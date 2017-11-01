//
//  ChangeNickNameViewController.m
//  ProgressManage
//
//  Created by lingnet on 2017/10/24.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "ChangeNickNameViewController.h"

#import "ChangeNickNameTableViewCell.h"

#import "changeNickNameModel.h"
@interface ChangeNickNameViewController ()<UITableViewDataSource,UITableViewDelegate,ChangeNickNameTableViewCellDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,copy)NSString* _token;
@property(nonatomic,copy)NSString* _errorCode;

@property(nonatomic,strong)NSMutableArray* dataSourceArr;
@end

@implementation ChangeNickNameViewController

- (void)sendBackNickName:(NSString *)text {
    changeNickNameModel* model = [self.dataSourceArr lastObject];
    model._nickName = text;
    
}

- (void)sendBackPhone:(NSString *)text {
    changeNickNameModel* model = [self.dataSourceArr lastObject];
    model._phone = text;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSUserDefaults*userDefaults=[NSUserDefaults standardUserDefaults];
    NSString* lastOldNickName = [userDefaults objectForKey:@"nickName"];
    NSString* lastOldPhone = [userDefaults objectForKey:@"phone"];
    self.dataSourceArr = [[NSMutableArray alloc] init];
    changeNickNameModel* model = [[changeNickNameModel alloc] init];
    model._nickName = lastOldNickName;
    model._phone = lastOldPhone;
    [self.dataSourceArr addObject:model];
    
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
    changeNickNameModel* model = [self.dataSourceArr lastObject];

    if (![MyController returnStr:model._nickName].length) {
        [HUD warning:@"请填写昵称"];
        return;
    }else if (![MyController returnStr:model._phone].length) {
        [HUD warning:@"请填写手机号"];
        return;
    }else if (![RegularExpressions validateMobile:model._phone]) {
        [HUD warning:@"请正确填写手机号"];
        return;
    }
    [HUD loading];
    [requestService postCreateTokenWithUserId:[MyController getUserid] cname:[MyController getCName] complate:^(id responseObject) {
        if ([responseObject[@"result"] intValue]) {
            NSDictionary* souDic = [MyController dictionaryWithJsonString:responseObject[@"data"]];
            self._token = souDic[@"token"];
            self._errorCode = souDic[@"errorCode"];
            
            changeNickNameModel* model = [self.dataSourceArr lastObject];
            [requestService postInfoUpdateWithUserId:[MyController getUserid] phone:model._phone nickName:model._nickName token:self._token complate:^(id responseObject) {
                if ([responseObject[@"result"] intValue]) {
                    NSDictionary* dic = [MyController dictionaryWithJsonString:responseObject[@"data"]];
                    [HUD success:dic[@"msg"]];
                    NSUserDefaults *accountDefault1 = [NSUserDefaults standardUserDefaults];
                    [accountDefault1 setObject:model._nickName forKey:@"nickName"];
                    
                    NSUserDefaults *accountDefault2 = [NSUserDefaults standardUserDefaults];
                    [accountDefault2 setObject:model._phone forKey:@"phone"];
                    
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
    ChangeNickNameTableViewCell *celll = [[ChangeNickNameTableViewCell alloc] init];
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    celll.ChangeNickNameTableViewCellDelegate = self;
    changeNickNameModel* model = self.dataSourceArr[indexPath.row];
    [celll configCellWithModel:model];
    return celll;
}

#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    changeNickNameModel *model = nil;
    if (indexPath.row < self.dataSourceArr.count) {
        model = [self.dataSourceArr objectAtIndex:indexPath.row];
    }
    
    return [ChangeNickNameTableViewCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        ChangeNickNameTableViewCell *cell = (ChangeNickNameTableViewCell *)sourceCell;
        [cell configCellWithModel:model];
    }];
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
