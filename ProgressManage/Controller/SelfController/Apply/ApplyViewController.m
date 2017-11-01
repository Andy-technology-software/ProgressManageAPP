//
//  ApplyViewController.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/27.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "ApplyViewController.h"

#import "ApplyTableViewCell.h"
@interface ApplyViewController ()<UITableViewDataSource,UITableViewDelegate,ApplyTableViewCellDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,copy)NSString* _userName;
@property(nonatomic,copy)NSString* _companyName;
@property(nonatomic,copy)NSString* _contactPhone;
@property(nonatomic,copy)NSString* _email;
@property(nonatomic,copy)NSString* _recommender;
@property(nonatomic,copy)NSString* _token;
@property(nonatomic,copy)NSString* _errorCode;

@end

@implementation ApplyViewController

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createTableView];
    
    [self makeSendView];
}
- (void)makeSendView{
    UIButton* sendBtn = [MyController createButtonWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame), [MyController getScreenWidth], 50) ImageName:nil Target:self Action:@selector(sendBtnClick) Title:@"提交申请"];
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendBtn setBackgroundColor:[MyController colorWithHexString:@"4c89f0"]];
    [self.view addSubview:sendBtn];
}
- (void)sendBtnClick{
    NSLog(@"保存");
    if (![MyController returnStr:self._userName].length){
        [HUD warning:@"请填写姓名"];
        return;
    }else if (![MyController returnStr:self._companyName].length) {
        [HUD warning:@"请填写企业名称"];
        return;
    }else if (![MyController returnStr:self._contactPhone].length) {
        [HUD warning:@"请填写联系电话"];
        return;
    }else if (![RegularExpressions validateMobile:self._contactPhone]) {
        [HUD warning:@"请正确填写联系电话"];
        return;
    }else if (![MyController returnStr:self._email].length) {
        [HUD warning:@"请填写邮箱"];
        return;
    }else if (![RegularExpressions validateEmail:self._email]) {
        [HUD warning:@"请正确填写邮箱"];
        return;
    }
    
    [requestService postCreateTokenWithUserId:[MyController getUserid] cname:[MyController getCName] complate:^(id responseObject) {
        if ([responseObject[@"result"] intValue]) {
            NSDictionary* souDic = [MyController dictionaryWithJsonString:responseObject[@"data"]];
            self._token = souDic[@"token"];
            self._errorCode = souDic[@"errorCode"];
            
            [requestService postApplyWithUserName:self._userName companyName:self._companyName contactPhone:self._contactPhone email:self._email recommender:self._recommender token:self._token complate:^(id responseObject) {
                NSLog(@"%@",responseObject);
                if ([responseObject[@"result"] intValue]) {
                    [HUD success:responseObject[@"data"]];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            } failure:^(NSError *error) {
                
            }];
        }
        
    } failure:^(NSError *error) {
        
    }];
    
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
    NSString *cellIdentifier = @"ApplyTableViewCell";
    ApplyTableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!celll) {
        celll = [[ApplyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    celll.ApplyTableViewCellDelegate = self;
    [celll configCellWithModel];
    return celll;
}

#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ApplyTableViewCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        ApplyTableViewCell *cell = (ApplyTableViewCell *)sourceCell;
        [cell configCellWithModel];
    }];
}

- (void)sendIndex:(NSInteger)selectIndex AndText:(NSString *)text{
    if (0 == selectIndex) {
        self._userName = text;
        
    }else if (1 == selectIndex){
        self._companyName = text;
        
    }else if (2 == selectIndex){
        self._contactPhone = text;
        
    }else if (3 == selectIndex){
        self._email = text;
        
    }else if (4 == selectIndex){
        self._recommender = text;
        
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
