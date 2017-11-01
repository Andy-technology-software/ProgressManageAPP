//
//  DailyViewController.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/15.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "DailyViewController.h"

#import "DailyModel.h"

#import "DailyTableViewCell.h"

#import "Daily1Model.h"

#import "Daily1TableViewCell.h"

#import "DailyNewViewController.h"
@interface DailyViewController ()<UITableViewDataSource,UITableViewDelegate,WJMenuDelegate,DailyTableViewCellDelegate,DailyNewViewControllerDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,strong)NSMutableArray* headDataSourceArr;
@property(nonatomic,strong)NSMutableArray* headIdDataSourceArr;
@property(nonatomic,strong)NSMutableArray* dataSourceArr;
@property(nonatomic,strong)NSMutableArray* dataSourceArr1;

@property (nonatomic,weak)WJDropdownMenu *menu;

@property(nonatomic,assign)NSInteger pageIndex;
@property(nonatomic,copy)NSString* _token;
@property(nonatomic,copy)NSString* _errorCode;
@property(nonatomic,copy)NSString* _time;
@property(nonatomic,copy)NSString* _id;

@end

@implementation DailyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"日报";
    self._time = [self getCurrentDay];
    self.view.backgroundColor = [MyController colorWithHexString:DEFAULTCOLOR];
    [self makeData];
    [self createTableView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithImage:[UIImage imageNamed:@"添加"]
                                              style:UIBarButtonItemStylePlain
                                              target:self
                                              action:@selector(rihgtBtnAction)];
    [_tableView.mj_header beginRefreshing];
    [self postGetNextPers];
}

#pragma mark - 获取下级人员
- (void)postGetNextPers{
    [requestService postCreateTokenWithUserId:[MyController getUserid] cname:[MyController getCName] complate:^(id responseObject) {
        if ([responseObject[@"result"] intValue]) {
            NSDictionary* souDic = [MyController dictionaryWithJsonString:responseObject[@"data"]];
            self._token = souDic[@"token"];
            self._errorCode = souDic[@"errorCode"];
            
            [requestService postGetNextPersWithUserId:[MyController getUserid] token:self._token cname:[MyController getCName] complate:^(id responseObject) {
                NSLog(@"%@",responseObject[@"data"]);
                self.headDataSourceArr = [[NSMutableArray alloc] init];
                self.headIdDataSourceArr = [[NSMutableArray alloc] init];
                if ([responseObject[@"result"] intValue]) {
                    NSArray* sArr = [MyController arraryWithJsonString:responseObject[@"data"]];
                    for (NSDictionary* dic in sArr) {
                        [self.headDataSourceArr addObject:dic[@"userName"]];
                        [self.headIdDataSourceArr addObject:dic[@"userid"]];
                    }
                    [self makeMenu];
                }
            } failure:^(NSError *error) {
                NSLog(@"失败");
            }];
            
        }
    } failure:^(NSError *error) {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    }];

    
}

#pragma mark - 点击日期返回代理
- (void)sendBackTime:(NSString *)time{
    self._time = time;
    [_tableView.mj_header beginRefreshing];
}

#pragma mark - 获取当前日期
- (NSString*)getCurrentDay{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:date];
    return dateTime;
}

#pragma mark - 获取日报列表
- (void)postdailyList{
    [requestService postCreateTokenWithUserId:[MyController getUserid] cname:[MyController getCName] complate:^(id responseObject) {
        if ([responseObject[@"result"] intValue]) {
            NSDictionary* souDic = [MyController dictionaryWithJsonString:responseObject[@"data"]];
            self._token = souDic[@"token"];
            self._errorCode = souDic[@"errorCode"];
            
            [requestService postdailyListWithUserId:[MyController getUserid] time:self._time id:[MyController returnStr:self._id] token:self._token num:@"10" pnum:[NSString stringWithFormat:@"%ld",self.pageIndex] cname:[MyController getCName] complate:^(id responseObject) {
                NSLog(@"%@",responseObject[@"data"]);
                if ([responseObject[@"result"] intValue]) {
                    NSArray* dictArray = [MyController arraryWithJsonString:responseObject[@"data"]];
                    NSArray *daily1ModelArray = [Daily1Model mj_objectArrayWithKeyValuesArray:dictArray];
                    if (1 == self.pageIndex) {
                        [self.dataSourceArr1 removeAllObjects];
                        [self.dataSourceArr1 addObjectsFromArray:daily1ModelArray];
                        //下拉刷新停止
                        [_tableView.mj_header endRefreshing];
                    }else{
                        [self.dataSourceArr1 addObjectsFromArray:daily1ModelArray];
                        [_tableView.mj_footer endRefreshing];
                    }
                }
                [_tableView reloadData];
            } failure:^(NSError *error) {
                [_tableView.mj_header endRefreshing];
                [_tableView.mj_footer endRefreshing];
            }];
            
        }
    } failure:^(NSError *error) {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    }];
    
}

- (void)rihgtBtnAction{
    NSLog(@"新增");
    DailyNewViewController* vc = [[DailyNewViewController alloc] init];
    vc.title = @"日报";
    vc.DailyNewViewControllerDelegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)sendBackNewDailySuccess:(BOOL)isSend {
    if (isSend) {
        [_tableView.mj_header beginRefreshing];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)makeData{
    self.dataSourceArr = [[NSMutableArray alloc] init];
    DailyModel* model = [[DailyModel alloc] init];
    model.day = @"1";
    [self.dataSourceArr addObject:model];
    
    self.dataSourceArr1 = [[NSMutableArray alloc] init];
}

#pragma mark - 初始化tableView
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [MyController isIOS7] + 42, self.view.frame.size.width, [MyController getScreenHeight] - [MyController isIOS7] - 42) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    //分割线类型
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self headRefresh];
    }];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{//精度
        // 进入刷新状态后会自动调用这个block
        [self footRefresh];
    }];
}
#pragma mark - 下拉刷新
- (void)headRefresh{
    self.pageIndex = 1;
    
    [self postdailyList];
    
}
#pragma mark - 上拉加载
- (void)footRefresh{
    self.pageIndex++;
    
    [self postdailyList];
    
}

#pragma mark - tableView行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (0 == section) {
        return self.dataSourceArr.count;
    }
    return self.dataSourceArr1.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        NSString *cellIdentifier = @"DailyTableViewCell";
        DailyTableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!celll) {
            celll = [[DailyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        celll.selectionStyle = UITableViewCellSelectionStyleNone;
        celll.DailyTableViewCellDelegate = self;
        DailyModel* model = self.dataSourceArr[indexPath.row];
        [celll configCellWithModel:model];
        return celll;
    }
    
    NSString *cellIdentifier = @"Daily1TableViewCell";
    Daily1TableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!celll) {
        celll = [[Daily1TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    Daily1Model* model = self.dataSourceArr1[indexPath.row];
    [celll configCellWithModel:model];
    return celll;
}

#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        DailyModel *model = nil;
        if (indexPath.row < self.dataSourceArr.count) {
            model = [self.dataSourceArr objectAtIndex:indexPath.row];
        }
        
        return [DailyTableViewCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
            DailyTableViewCell *cell = (DailyTableViewCell *)sourceCell;
            [cell configCellWithModel:model];
        }];
    }
    
    Daily1Model *model = nil;
    if (indexPath.row < self.dataSourceArr1.count) {
        model = [self.dataSourceArr1 objectAtIndex:indexPath.row];
    }
    
    return [Daily1TableViewCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        Daily1TableViewCell *cell = (Daily1TableViewCell *)sourceCell;
        [cell configCellWithModel:model];
    }];
}


- (void)makeMenu{
    WJDropdownMenu *menu = [[WJDropdownMenu alloc]initWithFrame:CGRectMake(0, [MyController isIOS7], self.view.frame.size.width, 42)];
    [self.view addSubview:menu];
    menu.delegate = self;
    self.menu = menu;
    menu.menuArrowStyle = menuArrowStyleSolid; 
    menu.tableViewMaxHeight = 200;             
    menu.menuButtonTag = 100;
    menu.CarverViewColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    menu.selectedColor = [MyController colorWithHexString:@"ff7854"];   
    menu.unSelectedColor = [MyController colorWithHexString:@"81889d"];
    [self createAllMenuData];
    
}

- (void)createAllMenuData{
    NSArray *firstArrOne = [NSArray arrayWithArray:self.headDataSourceArr];
    NSArray *firstMenu = [NSArray arrayWithObject:firstArrOne];
    NSArray* firsttit = [NSArray arrayWithObject:@"全部"];
    
    [self.menu createOneMenuTitleArray:firsttit FirstArray:firstMenu];
}

- (void)hideMenu{
    [self.menu drawBackMenu];
}

#pragma mark -- 代理方法3 返回点击时对应的内容和index(合并了方法1和方法2)
- (void)menuCellDidSelected:(NSString *)MenuTitle menuIndex:(NSInteger)menuIndex firstContent:(NSString *)firstContent firstIndex:(NSInteger)firstIndex secondContent:(NSString *)secondContent secondIndex:(NSInteger)secondIndex thirdContent:(NSString *)thirdContent thirdIndex:(NSInteger)thirdIndex{
    NSLog(@"菜单title:%@  titleIndex:%ld,一级菜单:%@    一级菜单Index:%ld,     二级子菜单:%@   二级子菜单Index:%ld   三级子菜单:%@  三级子菜单Index:%ld",MenuTitle,menuIndex,firstContent,firstIndex,secondContent,secondIndex,thirdContent,thirdIndex);
    
    self._id = self.headIdDataSourceArr[menuIndex];
    [_tableView.mj_header beginRefreshing];
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
