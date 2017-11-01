//
//  SeetingViewController.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/25.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "SeetingViewController.h"

#import "SeetingTableViewCell.h"

#import "ChangePWViewController.h"

#import "ChangeNickNameViewController.h"
@interface SeetingViewController ()<UITableViewDataSource,UITableViewDelegate,SeetingTableViewCellDelegate,UIAlertViewDelegate>{
    UITableView* _tableView;
}

@end

@implementation SeetingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createTableView];
}
- (void)viewWillAppear:(BOOL)animated{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}
#pragma mark - 初始化tableView
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [MyController isIOS7], self.view.frame.size.width, [MyController getScreenHeight] - [MyController isIOS7]) style:UITableViewStylePlain];
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
    NSString *cellIdentifier = @"SeetingTableViewCell";
    SeetingTableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!celll) {
        celll = [[SeetingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    celll.SeetingTableViewCellDelegate = self;
    [celll configCellWithModel];
    return celll;
}

#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [SeetingTableViewCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        SeetingTableViewCell *cell = (SeetingTableViewCell *)sourceCell;
        [cell configCellWithModel];
    }];
}

- (void)sendBackSelectIndex:(NSInteger)index{
    if (0 == index) {
        NSLog(@"修改资料");
        ChangeNickNameViewController* vc = [[ChangeNickNameViewController alloc] init];
        vc.title = @"修改昵称";
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        NSLog(@"修改密码");
        ChangePWViewController* vc = [[ChangePWViewController alloc] init];
        vc.title = @"密码修改";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)sendBackOut{
    UIAlertView* al = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否真的登出" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去意已决", nil];
    [al show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (1 == buttonIndex) {
        //把个人信息数据存到本地
        NSUserDefaults *accountDefault = [NSUserDefaults standardUserDefaults];
        [accountDefault setObject:@"" forKey:@"userId"];
        [(AppDelegate *)[UIApplication sharedApplication].delegate setLoginRoot];
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
