
//
//  RegistrationListViewController.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/22.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "RegistrationListViewController.h"

#import "RegistrationListModel.h"

#import "RegistrationListTableViewCell.h"

#import "RegistrationDetailViewController.h"
@interface RegistrationListViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,strong)NSMutableArray* dataSourceArr;
@property(nonatomic,assign)NSInteger pageIndex;

@property(nonatomic,copy)NSString* _token;
@property(nonatomic,copy)NSString* _errorCode;
@end

@implementation RegistrationListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataSourceArr = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [MyController colorWithHexString:DEFAULTCOLOR];
    
    [self createTableView];
    
    [_tableView.mj_header beginRefreshing];
}

- (void)getSourceData {
    [requestService postCreateTokenWithUserId:[MyController getUserid] cname:[MyController getCName] complate:^(id responseObject) {
        if ([responseObject[@"result"] intValue]) {
            NSDictionary* souDic = [MyController dictionaryWithJsonString:responseObject[@"data"]];
            self._token = souDic[@"token"];
            self._errorCode = souDic[@"errorCode"];
            
            [requestService postLeaveListWithUserId:[MyController getUserid] type:self._type token:self._token num:@"10" pnum:[NSString stringWithFormat:@"%ld",self.pageIndex] complate:^(id responseObject) {
                if ([responseObject[@"result"] intValue]) {
                    NSLog(@"%@",responseObject[@"data"]);
                    NSArray* dictArray = [MyController arraryWithJsonString:responseObject[@"data"]];
                    NSArray *customerModelArray = [RegistrationListModel mj_objectArrayWithKeyValuesArray:dictArray];
                    if (1 == self.pageIndex) {
                        [self.dataSourceArr removeAllObjects];
                        [self.dataSourceArr addObjectsFromArray:customerModelArray];
                        //下拉刷新停止
                        [_tableView.mj_header endRefreshing];
                    }else{
                        [self.dataSourceArr addObjectsFromArray:customerModelArray];
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
    
    [self getSourceData];
}
#pragma mark - 上拉加载
- (void)footRefresh{
    self.pageIndex++;
    
    [self getSourceData];
}


#pragma mark - tableView行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (1 == section) {
        return self.dataSourceArr.count;
    }
    return 1;
}

#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        UITableViewCell* cell = [[UITableViewCell alloc] init];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    NSString *cellIdentifier = @"RegistrationListTableViewCell";
    RegistrationListTableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!celll) {
        celll = [[RegistrationListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    RegistrationListModel* model = self.dataSourceArr[indexPath.row];
    [celll configCellWithModel:model];
    return celll;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        return 15;
    }
    RegistrationListModel *model = nil;
    if (indexPath.row < self.dataSourceArr.count) {
        model = [self.dataSourceArr objectAtIndex:indexPath.row];
    }
    
    return [RegistrationListTableViewCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        RegistrationListTableViewCell *cell = (RegistrationListTableViewCell *)sourceCell;
        [cell configCellWithModel:model];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RegistrationListModel* model = self.dataSourceArr[indexPath.row];
    RegistrationDetailViewController* vc = [[RegistrationDetailViewController alloc] init];
    vc.title = model.userName;
    vc._id = model.id;
    vc._type = model.type;
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
