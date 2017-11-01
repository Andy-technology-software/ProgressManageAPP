//
//  ChartPartViewController.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/24.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "ChartPartViewController.h"

#import "ChartPart0Model.h"

#import "ChartPart0TableViewCell.h"

#import "ChartPart10TableViewCell.h"

#import "SCChartCell.h"

#import "SCBarCell.h"
@interface ChartPartViewController ()<UITableViewDataSource,UITableViewDelegate,ChartPart0TableViewCellDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,strong)NSMutableArray* dataSourceArr0;
@property(nonatomic,strong)NSMutableArray* dataSourceArr1;

@property(nonatomic,assign)BOOL isLineChart;
@end

@implementation ChartPartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isLineChart = YES;
    // Do any additional setup after loading the view.
    self.dataSourceArr0 = [[NSMutableArray alloc] init];
    self.dataSourceArr1 = [[NSMutableArray alloc] init];
    
    ChartPart0Model* model0 = [[ChartPart0Model alloc] init];
    model0.selectIndex = 0;
    model0.timeArr = [[NSMutableArray alloc] initWithObjects:@"2017-05-01",@"2017-05-02", nil];
    [self.dataSourceArr0 addObject:model0];
    
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
    if (0 == section) {
        return self.dataSourceArr0.count;
    }
    return 1;
//    return self.dataSourceArr1.count;
}

#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section){
        NSString *cellIdentifier = @"ChartPart0TableViewCell";
        ChartPart0TableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!celll) {
            celll = [[ChartPart0TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        celll.selectionStyle = UITableViewCellSelectionStyleNone;
        ChartPart0Model* model = self.dataSourceArr0[indexPath.row];
        celll.ChartPart0TableViewCellDelegate = self;
        [celll configCellWithModel:model];
        return celll;
    }
    
    if (!self.isLineChart) {
        SCBarCell *cell = [[SCBarCell alloc] init];
        [cell configUI:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    SCChartCell *cell = [[SCChartCell alloc] init];
    [cell configUI:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section){
        ChartPart0Model *model = nil;
        if (indexPath.row < self.dataSourceArr0.count) {
            model = [self.dataSourceArr0 objectAtIndex:indexPath.row];
        }
        
        return [ChartPart0TableViewCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
            ChartPart0TableViewCell *cell = (ChartPart0TableViewCell *)sourceCell;
            [cell configCellWithModel:model];
        }];
    }
    
    return 250;
}


/**
 cell0代理

 @param selectIndex 点击了第几个按钮
 */
- (void)sendBackIndex:(NSInteger)selectIndex{
    NSLog(@"%ld",selectIndex);
    if (0 == selectIndex) {
        self.isLineChart = YES;
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
        [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }else if (1 == selectIndex){
        self.isLineChart = NO;
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
        [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
}

/**
 cell0代理 结束时间
 
 */
- (void)sendBackEndTime {
    NSLog(@"结束时间");
}

/**
 cell0代理 开始时间
 
 */
- (void)sendBackStartTime{
    NSLog(@"开始时间");
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
