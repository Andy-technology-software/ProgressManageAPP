//
//  ChartPartIndexViewController.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/25.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "ChartPartIndexViewController.h"

#import "ChartPartIndexTableViewCell.h"

#import "ChartPartViewController.h"
@interface ChartPartIndexViewController ()<UITableViewDataSource,UITableViewDelegate,ChartPartIndexTableViewCellDelegate>{
    UITableView* _tableView;
}

@end

@implementation ChartPartIndexViewController

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
    NSString *cellIdentifier = @"ChartPartIndexTableViewCell";
    ChartPartIndexTableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!celll) {
        celll = [[ChartPartIndexTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    celll.ChartPartIndexTableViewCellDelegate = self;
    [celll configCellWithModel];
    return celll;
}

#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ChartPartIndexTableViewCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        ChartPartIndexTableViewCell *cell = (ChartPartIndexTableViewCell *)sourceCell;
        [cell configCellWithModel];
    }];
}

- (void)sendBackSelectIndex:(NSInteger)index AndTitle:(NSString *)title{
    if (0 == index) {
        
    }
    ChartPartViewController* vc = [[ChartPartViewController alloc] init];
    vc.title = title;
    [self.navigationController pushViewController:vc animated:YES];
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
