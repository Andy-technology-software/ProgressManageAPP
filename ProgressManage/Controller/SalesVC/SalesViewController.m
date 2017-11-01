//
//  SalesViewController.m
//  ProgressManage
//
//  Created by Gem on 2017/5/4.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "SalesViewController.h"
#import "WJDropdownMenu.h"
#import "SalesModel.h"
#import "SalesTableViewCell.h"
#import "PYSearch.h"
#import "IncreaseViewController.h"
#import "SaleDetailViewController.h"
#import "FilterModel.h"
@interface SalesViewController ()<UITableViewDataSource,UITableViewDelegate,WJMenuDelegate,PYSearchViewControllerDelegate,SalesTableViewCellDelegate>{
    UITableView* _tableView;
    NSInteger selectIndex;
    NSInteger firstindex;
    NSInteger secondindex;
    NSMutableArray *popTitleArr;
    UIButton *selesetBtn;
    NSMutableArray *customerSource;
    NSMutableArray *stateSource;
}
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic, assign) CGRect         screenRect;
@property (nonatomic, strong) UIWindow       *window;
@property (nonatomic, strong) UIView         *dimBackground;
@property (nonatomic,strong)WJDropdownMenu *dropMenu;

@end

@implementation SalesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [MyController colorWithHexString:@"f9fafb"];
    customerSource = [NSMutableArray array];
    stateSource = [NSMutableArray array];
    popTitleArr = [NSMutableArray array];
    selectIndex = 0;
    firstindex = 0;
    secondindex = 0;
    self.pageIndex = 1;
    self.dataSource = [NSMutableArray array];
    //    for (int i = 0; i < 10; i ++) {
    //        SalesModel *model = [[SalesModel alloc] init];
    //        model.title = @"进销存项目";
    //        model.time = @"2017-5-8";
    //        model.percent = 0.5;
    //        model.state = @"交付管理";
    //        model.customer = @"东方机械";
    //        model.money = @"¥888888.88";
    //        model.flag = @"1";
    //        [self.dataSource addObject:model];
    //    }
    
    [self createTableView];
    
    [self createRightBtn];
    [self getCondationRequest];
}
- (void)createHeadView{
    if (popTitleArr.count) {
        
        FilterModel *model = popTitleArr[0];
        selesetBtn = [MyController createButtonWithFrame:CGRectMake(80, 0, SCREEN_WIDTH - 160, 44) ImageName:nil Target:self Action:@selector(popAction:) Title:model.name];
        [selesetBtn setImage:[UIImage imageNamed:@"上拉1"] forState:UIControlStateNormal];
        CGFloat imageViewWidth = CGRectGetWidth(selesetBtn.imageView.frame);
        CGFloat labelWidth = CGRectGetWidth(selesetBtn.titleLabel.frame);
        [selesetBtn setImageEdgeInsets:UIEdgeInsetsMake(0,0 + labelWidth,0,0 - labelWidth)];
        [selesetBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,0 - imageViewWidth,0, 0 + imageViewWidth)];
        [selesetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.navigationItem.titleView = selesetBtn;
        
    }
}
- (void)createRightBtn{
    UIButton *addSalesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addSalesBtn addTarget:self action:@selector(addSalesAction:) forControlEvents:UIControlEventTouchUpInside];
    [addSalesBtn setImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
    [addSalesBtn setImage:[UIImage imageNamed:@"添加-触发"] forState:UIControlStateHighlighted];
    [addSalesBtn sizeToFit];
    UIBarButtonItem *addSalesItem = [[UIBarButtonItem alloc] initWithCustomView:addSalesBtn];
    
    
    UIBarButtonItem *fixedSpaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpaceBarButtonItem.width = 15;
    
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn setImage:[UIImage imageNamed:@"搜索"] forState:UIControlStateNormal];
    [searchBtn setImage:[UIImage imageNamed:@"搜索-触发"] forState:UIControlStateHighlighted];
    [searchBtn sizeToFit];
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    self.navigationItem.rightBarButtonItems  = @[searchItem,fixedSpaceBarButtonItem,addSalesItem];
}
#pragma mark - 添加
- (void)addSalesAction:(UIButton *)btn{
    IncreaseViewController *vc = [[IncreaseViewController alloc] init];
    vc.customerSource = [NSMutableArray arrayWithArray:popTitleArr];
    vc.title = @"新增";
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 搜索
- (void)searchAction:(UIButton *)btn{
    
    // 1. 创建热门搜索
    NSArray *hotSeaches = @[];
    // 2. 创建控制器
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:NSLocalizedString(@"搜索", @"搜索") didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // 开始搜索执行以下代码
        // 如：跳转到指定控制器
        //        [searchViewController.navigationController pushViewController:[[SearchViewController alloc] init] animated:YES];
    }];
    
    searchViewController.searchHistoryStyle = PYHotSearchStyleDefault; // 搜索历史风格为default
    searchViewController.hotSearchStyle = PYHotSearchStyleDefault; // 热门搜索风格为默认
    
    // 4. 设置代理
    searchViewController.delegate = self;
    // 5. 跳转到搜索控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav animated:NO completion:nil];
    
    
}
#pragma mark - PYSearchViewControllerDelegate
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    if (searchText.length) { // 与搜索条件再搜索
        
        // 显示建议搜索结果
        NSMutableArray *searchSuggestionsM = [NSMutableArray array];
        NSPredicate *namePredicate = [NSPredicate predicateWithFormat:@"title CONTAINS[c] %@ ",searchText];
//        NSPredicate *phonePredicate = [NSPredicate predicateWithFormat:@"phone CONTAINS[c] %@ ",searchText];
        
        for (SalesModel *model in self.dataSource) {
            if ([namePredicate evaluateWithObject:model]) {
                model.flag = @"";
                [searchSuggestionsM addObject:model];
            }
        }
        searchViewController.searchSuggestions = searchSuggestionsM;
        
    }
}

- (void)popAction:(UIButton *)btn{
    [selesetBtn setImage:[UIImage imageNamed:@"下拉1"] forState:UIControlStateNormal];
    [self createPopView];
}
#pragma mark -导航视图
#pragma mark - 创建弹出视图
- (void)createPopView{
    
    self.dimBackground = [[UIView alloc] initWithFrame:CGRectMake(0 , 0, [MyController getScreenWidth], [MyController getScreenHeight])];
    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [_dimBackground addGestureRecognizer:gr];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, [MyController isIOS7], [MyController getScreenWidth], 44 * popTitleArr.count)];
    view.backgroundColor = [MyController colorWithHexString:@"f9fafb"];
    [self.dimBackground addSubview:view];
    for (int i = 0; i < popTitleArr.count; i ++) {
        FilterModel *model = popTitleArr[i];
        UIButton *btn = [MyController createButtonWithFrame:CGRectMake(0, 44 * i, [MyController getScreenWidth], 44) ImageName:nil Target:self Action:@selector(selectedAction:) Title:model.name];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.tag = i + 10;
        [view addSubview:btn];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
        line.frame =  CGRectMake(15, (i + 1)* 44 - 0.5, [MyController getScreenWidth] - 30, 0.5);
        line.backgroundColor = [MyController colorWithHexString:@"eeeeee"];
        [view addSubview:line];
    }
    if (self.window == nil) {
        [self show];
    }
}
#pragma mark - 显示遮盖视图
- (void)show {
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], [MyController getScreenHeight])];
    self.window.windowLevel = UIWindowLevelAlert;
    self.window.backgroundColor = [UIColor clearColor];
    self.window.rootViewController = [UIViewController new];
    self.window.rootViewController.view.backgroundColor = [UIColor clearColor];
    [self.window.rootViewController.view addSubview:self.dimBackground];
    self.window.hidden = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.dimBackground.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    } completion:^(BOOL finished) {
    }];
}
#pragma mark - 移除遮盖视图
- (void)dismiss {
    [selesetBtn setImage:[UIImage imageNamed:@"上拉1"] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        self.dimBackground.backgroundColor = [UIColor clearColor];
        [self.dimBackground.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    } completion:^(BOOL finished) {
        self.window = nil;
    }];
}
- (void)selectedAction:(UIButton *)btn{
    NSLog(@"selected: %ld",btn.tag - 10);
    NSInteger index = btn.tag - 10;
    [self dismiss];
    FilterModel *model = popTitleArr[index];
    [selesetBtn setTitle:model.name forState:UIControlStateNormal];
    selectIndex = index;
    [_tableView.mj_header beginRefreshing];
}

#pragma marl - 菜单视图
- (void)createDropMenue{
    // 创建menu
    self.dropMenu = [[WJDropdownMenu alloc]initWithFrame:CGRectMake(0, [MyController isIOS7], SCREEN_WIDTH, 40)];
    self.dropMenu.backgroundColor = [UIColor clearColor];
    self.dropMenu.delegate = self;         //  设置代理
    [self.view addSubview:self.dropMenu];
    
    // 设置属性(可不设置)
    self.dropMenu.caverAnimationTime = 0.2;//  增加了遮盖层动画时间设置   不设置默认是  0.15
    self.dropMenu.unSelectedColor = [MyController colorWithHexString:@"81889d"];
    self.dropMenu.menuTitleFont = 12;      //  设置menuTitle字体大小    不设置默认是  11
    self.dropMenu.tableTitleFont = 12;     //  设置tableTitle字体大小   不设置默认是  10
    self.dropMenu.cellHeight = 40;         //  设置tableViewcell高度   不设置默认是  40
    self.dropMenu.menuArrowStyle = menuArrowStyleSolid; // 旋转箭头的样式(空心箭头 or 实心箭头)
    self.dropMenu.tableViewMaxHeight = 200; // tableView的最大高度(超过此高度就可以滑动显示)
    self.dropMenu.CarverViewColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];//设置遮罩层颜色
    
    // 第一种方法一次性导入所有菜单数据
    [self createAllMenuData];
    
}

- (void)createAllMenuData{
    NSMutableArray *startMenuTitle = [NSMutableArray array];
    
    //  创建第一个菜单的first数据second数据
    NSMutableArray *firstMenu = [NSMutableArray array];
    for (int i = 0; i < customerSource.count; i ++) {
        FilterModel *model = customerSource[i];
        if (i == 0) {
            [startMenuTitle addObject:model.name];
        }
        [firstMenu addObject:model.name];
    }
    NSArray *first = [NSArray arrayWithObjects:firstMenu,nil];
    //  创建第二个菜单的first数据second数据
    NSMutableArray *secondMenu = [NSMutableArray array];
    for (int i = 0; i < stateSource.count; i ++) {
        FilterModel *model = stateSource[i];
        if (i == 0) {
            [startMenuTitle addObject:model.name];
        }
        [secondMenu addObject:model.name];
    }
    NSArray *second = [NSArray arrayWithObjects:secondMenu,nil];
    NSLog(@"%@---%@---%@",startMenuTitle,first,second);
    [self.dropMenu createTwoMenuTitleArray:startMenuTitle FirstArr:first SecondArr:second];
}

- (void)hideMenu{
    //  点击收缩menu
    [self.dropMenu drawBackMenu];
}

#pragma mark -- 代理方法返回点击时对应的index

- (void)menuCellDidSelected:(NSInteger)MenuTitleIndex firstIndex:(NSInteger)firstIndex andSecondIndex:(NSInteger)secondIndex{
    if (0 == MenuTitleIndex) {
        firstindex = firstIndex;
        [_tableView.mj_header beginRefreshing];
    }else if (1 == MenuTitleIndex){
        secondindex = firstIndex;
        [_tableView.mj_header beginRefreshing];
    }
    
}



#pragma mark - 初始化tableView
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, [MyController isIOS7] + 40, SCREEN_WIDTH - 20, [MyController getScreenHeight] - 40  - [MyController isIOS7]) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [MyController colorWithHexString:@"f9fafb"];
    //分割线类型
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self headerRefresh];
    }];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self footerRefresh];
    }];
    [self.view addSubview:_tableView];
    
    
}
#pragma mark - 刷新
- (void)headerRefresh{
    NSLog(@"下拉");
    self.pageIndex = 1;
    [self getSaleListRequest];
}
- (void)footerRefresh{
    NSLog(@"上拉");
    self.pageIndex ++;
    [self getSaleListRequest];
}
#pragma mark - tableView行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
#pragma mark - tableVie点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SalesModel* model = self.dataSource[indexPath.row];
    SaleDetailViewController *vc = [[SaleDetailViewController alloc] init];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    SalesTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    //    if (!cell) {
    //        cell = [[SalesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    //    }
    SalesTableViewCell *cell = [[SalesTableViewCell alloc] init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.cellIndex = indexPath.row;
    cell.SalesTableViewCellDelegate = self;
    SalesModel* model = self.dataSource[indexPath.row];
    __weak typeof (cell) weakCell = cell;
    cell.mySwipeBlock = ^{
        for(SalesTableViewCell *tmpCell in tableView.visibleCells){
            // 将其他正在打开的cell关闭
            if (![weakCell isEqual:tmpCell]) {
                [tmpCell closeMenu];
            }
            // 所有cell取消选中状态
            tmpCell.selected = NO;
        }
    };
    [cell setModel:model];
    return cell;
    
}
#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 130;
}

- (void)editNum:(NSInteger)cellIndex{
    for(SalesTableViewCell *tmpCell in _tableView.visibleCells){
        [tmpCell closeMenu];
    }
    SalesModel* model = self.dataSource[cellIndex];
    IncreaseViewController *vc = [[IncreaseViewController alloc] init];
    vc.customerSource = [NSMutableArray arrayWithArray:popTitleArr];
    vc.title = @"编辑";
    vc.dataSource = [NSMutableArray arrayWithObjects:model.title,model.customer,model.money,model.optnty_type,model.state,model.remark, nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)deleteNum:(NSInteger)cellIndex{
    for(SalesTableViewCell *tmpCell in _tableView.visibleCells){
        [tmpCell closeMenu];
    }
    [self salesDeleteRequestWith:cellIndex];
}
//-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
//    return YES;
//}
//
//- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//        //添加一个删除按钮
//        UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDestructive) title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//            NSLog(@"点击了删除");
//
//            SalesModel *model = [self.dataSource objectAtIndex:indexPath.row];
//            [self.dataSource removeObjectAtIndex:indexPath.row];
//            [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//
//
//        }];
//
//        UITableViewRowAction *editorAction =[UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleNormal) title:@"编辑" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//            NSLog(@"点击了编辑");
//
//        }];
//
//
//
//        //--------更多
//
//        //将设置好的按钮方到数组中返回
//        return @[deleteAction,editorAction];
//
//}
#pragma mark - 筛选条件请求
- (void)getCondationRequest{
    [HUD loading];
    [requestService postCreateTokenWithUserId:[MyController getUserid] cname:[MyController getCName] complate:^(id responseObject) {
        NSDictionary* souDic = [MyController dictionaryWithJsonString:responseObject[@"data"]];
        
        NSString* requestAddress = Condation;
        AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
        [manager POST:requestAddress parameters:@{
                                                  @"token":[MyController returnStr:souDic[@"token"]],
                                                  @"cname":[MyController getCName]
                                                  }
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  NSLog(@"筛选条件请求----%@",responseObject);
                  NSLog(@"筛选条件data----%@",[responseObject objectForKey:@"data"]);
                  if ([[responseObject objectForKey:@"result"] intValue]) {
                      [HUD hide];
                      NSDictionary *dic = [MyController dictionaryWithJsonString:[responseObject objectForKey:@"data"]];
                      NSArray *state = dic[@"state"];
                      NSArray *customer = dic[@"customer"];
                      NSArray *salemen = dic[@"salemen"];
                      FilterModel *model = [[FilterModel alloc] init];
                      model.filterId = @"";
                      model.name = @"全部客户";
                      [customerSource addObject:model];
                      for (NSDictionary *dic in customer) {
                          FilterModel *model = [[FilterModel alloc] init];
                          model.filterId = dic[@"type"];
                          model.name = dic[@"name"];
                          [customerSource addObject:model];
                      }
                      FilterModel *model1 = [[FilterModel alloc] init];
                      model1.filterId = @"";
                      model1.name = @"销售";
                      [popTitleArr addObject:model1];
                      for (NSDictionary *dic in salemen) {
                          FilterModel *model = [[FilterModel alloc] init];
                          model.filterId = dic[@"type"];
                          model.name = dic[@"name"];
                          [popTitleArr addObject:model];
                      }
                      FilterModel *model2 = [[FilterModel alloc] init];
                      model2.filterId = @"";
                      model2.name = @"全部状态";
                      [stateSource addObject:model2];
                      for (NSDictionary *dic in state) {
                          FilterModel *model = [[FilterModel alloc] init];
                          model.filterId = dic[@"type"];
                          model.name = dic[@"name"];
                          [stateSource addObject:model];
                      }
                      [self createDropMenue];
                      [self createHeadView];
                      NSLog(@"%@",state);
                      [_tableView.mj_header beginRefreshing];
                      
                  }else{
                      NSString *errStr = [responseObject objectForKey:@"error"];
                      NSDictionary *dic = [MyController dictionaryWithJsonString:errStr];
                      [HUD error:[dic objectForKey:@"errorInfo"]];
                  }
              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  NSLog(@"失败");
                  NSLog(@"失败===%@", error);
                  [HUD error:@"请检查网络"];
              }];
    } failure:^(NSError *error) {
        
    }];
    
}

#pragma mark - 销售列表请求
- (void)getSaleListRequest{
    [requestService postCreateTokenWithUserId:[MyController getUserid] cname:[MyController getCName] complate:^(id responseObject) {
        NSDictionary* souDic = [MyController dictionaryWithJsonString:responseObject[@"data"]];
        if (customerSource.count && popTitleArr.count && stateSource.count) {
            FilterModel *customer = customerSource[firstindex];
            FilterModel *sale = popTitleArr[selectIndex];
            FilterModel *state = stateSource[secondindex];
            NSString* requestAddress = SaleList;
            AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
            [manager POST:requestAddress parameters:@{
                                                      @"token":[MyController returnStr:souDic[@"token"]],
                                                      @"cname":[MyController getCName],
                                                      @"saleId":sale.filterId,
                                                      @"customerId":customer.filterId,
                                                      @"statusId":state.filterId,
                                                      @"pnum":[NSString stringWithFormat:@"%ld",self.pageIndex],
                                                      @"num":@"10",
                                                      }
                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                      NSLog(@"销售列表请求----%@",responseObject);
                      NSLog(@"销售列表data----%@",[responseObject objectForKey:@"data"]);
                      if ([[responseObject objectForKey:@"result"] intValue]) {
                          NSArray* sourceArr = [MyController arraryWithJsonString:[responseObject objectForKey:@"data"]];
                          NSMutableArray *_array = [NSMutableArray array];
                          for (int i = 0; i < sourceArr.count; i ++){
                              NSDictionary *dic = sourceArr[i];
                              SalesModel *model = [[SalesModel alloc] init];
                              model.title = [MyController returnStr:dic[@"optnty_name"]];
                              model.time = [MyController returnStr:dic[@"createdate"]];
                              model.percent = [MyController returnStr:dic[@"probability"]];
                              model.state = [MyController returnStr:dic[@"optnty_stage"]];
                              model.customer = [MyController returnStr:dic[@"account_name"]];
                              model.account_id = [MyController returnStr:dic[@"account_id"]];
                              model.money = [MyController returnStr:dic[@"amount"]];
                              model.optnty_stage_id = [MyController returnStr:dic[@"optnty_stage_id"]];
                              model.idStr = [MyController returnStr:dic[@"id"]];
                              model.remark = [MyController returnStr:dic[@"description"]];
                              model.optnty_type = [MyController returnStr:dic[@"optnty_type"]];
                              model.flag = @"1";
                              [_array addObject:model];
                          }
                          //循环完成
                          if (self.pageIndex == 1) {
                              //删除原有数据 对数据源重新追加数据
                              [self.dataSource removeAllObjects];
                              [self.dataSource addObjectsFromArray:_array];
                              
                              //下拉刷新停止
                              [_tableView.mj_header endRefreshing];
                          }else {
                              //对现有数据源进行追加数据
                              [self.dataSource addObjectsFromArray:_array];
                              
                              //上拉加载停止
                              [_tableView.mj_footer endRefreshing];
                          }
                          [_tableView reloadData];
                          
                      }else{
                          NSString *errStr = [responseObject objectForKey:@"error"];
                          NSDictionary *dic = [MyController dictionaryWithJsonString:errStr];
                          [HUD error:[dic objectForKey:@"errorInfo"]];
                          [_tableView.mj_header endRefreshing];
                          [_tableView.mj_footer endRefreshing];
                      }
                  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                      NSLog(@"失败");
                      NSLog(@"失败===%@", error);
                      [HUD error:@"请检查网络"];
                      [_tableView.mj_header endRefreshing];
                      [_tableView.mj_footer endRefreshing];
                  }];
        }
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark - 销售删除请求
- (void)salesDeleteRequestWith:(NSInteger)index{
    SalesModel *model = self.dataSource[index];
    [HUD loading];
    [requestService postCreateTokenWithUserId:[MyController getUserid] cname:[MyController getCName] complate:^(id responseObject) {
        NSDictionary* souDic = [MyController dictionaryWithJsonString:responseObject[@"data"]];
        NSLog(@"souDic----%@",souDic);
        NSString* requestAddress = SalesDelete;
        AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
        [manager POST:requestAddress parameters:@{
                                                  @"token":[MyController returnStr:souDic[@"token"]],
                                                  @"userId":[MyController getUserid],
                                                  @"id":[MyController returnStr:model.idStr],
                                                  }
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  NSLog(@"销售其他详情删除请求----%@",responseObject);
                  NSLog(@"销售其他详情删除请求data----%@",[responseObject objectForKey:@"data"]);
                  if ([[responseObject objectForKey:@"result"] intValue]) {
                      [HUD success:[responseObject objectForKey:@"data"]];
                      [self.dataSource removeObjectAtIndex:index];
                      //刷新tableview
                      [_tableView reloadData];
                      
                  }else{
                      NSString *errStr = [responseObject objectForKey:@"error"];
                      NSDictionary *dic = [MyController dictionaryWithJsonString:errStr];
                      [HUD error:[dic objectForKey:@"errorInfo"]];
                  }
              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  NSLog(@"失败");
                  NSLog(@"失败===%@", error);
                  [HUD error:@"请检查网络"];
              }];
    } failure:^(NSError *error) {
        
    }];
}
@end

