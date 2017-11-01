//
//  AuditListViewController.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/23.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "AuditListViewController.h"

#import "RegistrationListModel.h"

#import "RegistrationListTableViewCell.h"

#import "RegistrationDetailViewController.h"
@interface AuditListViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,strong)NSMutableArray* dataSourceArr;
@property(nonatomic,assign)NSInteger pageIndex;

@property(nonatomic,strong)UIView* headView;
@property(nonatomic,strong)UITextField* searchtf;

@property(nonatomic,copy)NSString* _token;
@property(nonatomic,copy)NSString* _errorCode;
@property(nonatomic,copy)NSString* _state;
@property(nonatomic,copy)NSString* _content;

@end

@implementation AuditListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [MyController colorWithHexString:DEFAULTCOLOR];
    self._state = @"1";
    self.dataSourceArr = [[NSMutableArray alloc] init];
    [self createTableView];
    [_tableView.mj_header beginRefreshing];
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectAuditState:) name:@"selectAuditState" object:nil];
}

- (void)selectAuditState:(NSNotification *)text{
    NSLog(@"－－－－－接收到通知------%@",text.userInfo[@"state"]);
    self._state = text.userInfo[@"state"];
    [_tableView.mj_header beginRefreshing];
}

- (void)getSourceData {
    [requestService postCreateTokenWithUserId:[MyController getUserid] cname:[MyController getCName] complate:^(id responseObject) {
        if ([responseObject[@"result"] intValue]) {
            NSDictionary* souDic = [MyController dictionaryWithJsonString:responseObject[@"data"]];
            self._token = souDic[@"token"];
            self._errorCode = souDic[@"errorCode"];
            
            [requestService postAuditListWithUserId:[MyController getUserid] state:self._state content:[MyController returnStr:self._content] num:@"10" pnum:[NSString stringWithFormat:@"%ld",(long)self.pageIndex] token:self._token complate:^(id responseObject) {
                if ([responseObject[@"result"] intValue]) {
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
    return self.dataSourceArr.count;
}

#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
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

#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
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
    vc.isNeedAudit = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    self.headView = [MyController viewWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], 50)];
    self.headView.backgroundColor = [MyController colorWithHexString:DEFAULTCOLOR];
    
    self.searchtf = [MyController createTextFieldWithFrame:self.view.frame placeholder:@"搜索" passWord:NO leftImageView:nil rightImageView:nil Font:14];
    self.searchtf.backgroundColor = [MyController colorWithHexString:@"eff0f2"];
    //将图层的边框设置为圆脚
    self.searchtf.layer.cornerRadius = 16;
    self.searchtf.layer.masksToBounds = YES;
    [self.searchtf setContentMode:UIViewContentModeScaleAspectFill];
    self.searchtf.clipsToBounds = YES;
    self.searchtf.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)];
    self.searchtf.leftViewMode = UITextFieldViewModeAlways;
    [self.headView addSubview:self.searchtf];
    
    [self.searchtf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(9);
        make.height.mas_offset(32);
    }];
    
    return self.headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
