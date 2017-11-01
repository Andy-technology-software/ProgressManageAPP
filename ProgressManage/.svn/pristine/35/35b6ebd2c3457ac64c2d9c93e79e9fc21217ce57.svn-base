//
//  FootprintViewController.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/4.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "FootprintViewController.h"

#import "Footprint0Model.h"

#import "Footprint0TableViewCell.h"

#import "Footprint1TableViewCell.h"

#import "Footprint20Model.h"

#import "Footprint20TableViewCell.h"

#import "Footprint21Model.h"

#import "Footprint21TableViewCell.h"

#import "FootprintDetailViewController.h"

#import "SignInRecordViewController.h"

#import "RemindViewController.h"
@interface FootprintViewController ()<UITableViewDataSource,UITableViewDelegate,Footprint1TableViewCellDelegate,Footprint21TableViewCellDelegate,Footprint0TableViewCellDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,assign)BOOL isYi;
@property (strong, nonatomic) MHDatePicker *selectDatePicker;
@property(nonatomic,assign)NSInteger pageIndex;
@property(nonatomic,copy)NSString* timeStr;
@property(nonatomic,copy)NSString* signsNum;

@property(nonatomic,copy)NSString* jingdu;
@property(nonatomic,copy)NSString* weidu;
/**
 这是headview
 */
@property(nonatomic,strong)NSMutableArray* dataSourceArr0;
@property(nonatomic,strong)NSMutableArray* dataSourceArr1;
@property(nonatomic,strong)NSMutableArray* dataSourceArr20;
@property(nonatomic,strong)NSMutableArray* dataSourceArr21;
@property(nonatomic,strong)UIView* lineView;

@property(nonatomic,strong)UIView* baseView;
@property(nonatomic,strong)UIView* bgView;

@property(nonatomic,strong)UILabel* yiLable;
@property(nonatomic,strong)UILabel* yiLable1;
//@property(nonatomic,strong)UILabel* weiLable;
//@property(nonatomic,strong)UILabel* weiLable1;
@property(nonatomic,strong)UIImageView* bottomIV;
@property(nonatomic,strong)UIImageView* bottomIV1;

@property(nonatomic,strong)UIButton* yiBtn;
@property(nonatomic,strong)UIButton* weiBtn;

@end

@implementation FootprintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isYi = YES;
    self.dataSourceArr0 = [[NSMutableArray alloc] init];
    self.dataSourceArr1 = [[NSMutableArray alloc] init];
    self.dataSourceArr20 = [[NSMutableArray alloc] init];
    self.dataSourceArr21 = [[NSMutableArray alloc] init];
    
    [self makeData];
    
    [self createTableView];
    
    self.timeStr = [self getCurrentDay1];
    [_tableView.mj_header beginRefreshing];
    
    //注册通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(signSuccess) name:@"signSuccess" object:nil];
}

- (void)signSuccess{
    [_tableView.mj_header beginRefreshing];
}

- (void)makeData{
    
    Footprint0Model* model0 = [[Footprint0Model alloc] init];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    model0.name = [userDefaults objectForKey:@"companyName"];

    model0.time = [self getCurrentDay1];
    [self.dataSourceArr0 addObject:model0];
    
    Footprint21Model* m21 = [[Footprint21Model alloc] init];
    m21.nameArr = [[NSMutableArray alloc] initWithObjects:@"皮卡丘",@"雷丘",@"皮卡丘",@"雷丘",@"皮卡丘",@"雷丘", nil];
    [self.dataSourceArr21 addObject:m21];
    
}

- (void)getTuanduizuji:(NSString*)pnum AndNum:(NSString*)num AndTime:(NSString*)time{
    [requestService postTUANDUIZIJIWithSignDate:time pnum:pnum num:num userId:[MyController getuserId] complate:^(id responseObject) {
        NSLog(@"%@",responseObject[@"data"]);
        NSDictionary* aaD = [MyController dictionaryWithJsonString:responseObject[@"data"]];
        NSLog(@"%@",aaD);
        NSArray* sourceArr = aaD[@"signs"];
        self.signsNum = [NSString stringWithFormat:@"%d",[aaD[@"newSigns"] intValue]];
        NSMutableArray *_array = [NSMutableArray arrayWithCapacity:0];
        int i = 0;
        
        for (NSDictionary* dic in sourceArr) {
            if (0 == i) {
                self.jingdu = dic[@"lon"];
                self.weidu = dic[@"lat"];
            }
            i++;
            Footprint20Model* m20 = [[Footprint20Model alloc] init];
            m20.name = dic[@"userName"];
            m20.time = [dic[@"signDate"] substringFromIndex:10];
            m20.time1 = [dic[@"signTimes"] intValue];
            m20.userid = dic[@"userId"];
            m20.address = dic[@"location"];
            [_array addObject:m20];
        }
        //循环完成
        if (self.pageIndex == 1) {
            //删除原有数据 对数据源重新追加数据
            [self.dataSourceArr20 removeAllObjects];
            [self.dataSourceArr20 addObjectsFromArray:_array];
            NSLog(@"数据源----%@",self.dataSourceArr20);
            //刷新表格
            [_tableView reloadData];
            //下拉刷新停止
            [_tableView.mj_header endRefreshing];
        }else {
            //对现有数据源进行追加数据
            [self.dataSourceArr20 addObjectsFromArray:_array];
            //刷新表格
            [_tableView reloadData];
            //上拉加载停止
            [_tableView.mj_footer endRefreshing];
        }
    } failure:^(NSError *error) {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    }];
}

- (NSString*)getCurrentDay1{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:date];
    return dateTime;
}

#pragma mark - 初始化tableView
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, [MyController getScreenHeight] - 50 - [MyController isIOS7]) style:UITableViewStylePlain];
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
    //    [_tableView.header endRefreshing];
    self.pageIndex = 1;
    [self getTuanduizuji:@"1" AndNum:@"10"AndTime:self.timeStr];
}
#pragma mark - 上拉加载
- (void)footRefresh{
    //    [_tableView.footer endRefreshing];
    self.pageIndex++;
    [self getTuanduizuji:[NSString stringWithFormat:@"%ld",self.pageIndex] AndNum:@"10"AndTime:self.timeStr];
}

#pragma mark - tableView行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (2 == section) {
        if (self.isYi) {
            return self.dataSourceArr20.count;
        }
        return self.dataSourceArr21.count;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

#pragma mark - tableVie点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (2 == indexPath.section) {
        if (self.isYi) {
            Footprint20Model* m = self.dataSourceArr20[indexPath.row];
            SignInRecordViewController* vc = [[SignInRecordViewController alloc] init];
            vc.title = @"签到记录";
            vc.name = m.name;
            vc.userid = m.userid;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 ==  indexPath.section) {
        NSString *cellIdentifier = @"Footprint0TableViewCell";
        Footprint0TableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!celll) {
            celll = [[Footprint0TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        celll.selectionStyle = UITableViewCellSelectionStyleNone;
        celll.Footprint0TableViewCellDelegate = self;
        Footprint0Model* model = self.dataSourceArr0[indexPath.row];
        [celll configCellWithModel:model];
        return celll;
    }else if (1 == indexPath.section){
        NSString *cellIdentifier = @"Footprint1TableViewCell";
        Footprint1TableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!celll) {
            celll = [[Footprint1TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        celll.selectionStyle = UITableViewCellSelectionStyleNone;
        celll.Footprint1TableViewCellDelegate = self;
        celll.jingdu = self.jingdu;
        celll.weidu = self.weidu;
        [celll configCellWithModel];
        return celll;
    }
    
    if (self.isYi) {
        NSString *cellIdentifier = @"Footprint20TableViewCell";
        Footprint20TableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!celll) {
            celll = [[Footprint20TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        celll.selectionStyle = UITableViewCellSelectionStyleNone;
        Footprint20Model* model = self.dataSourceArr20[indexPath.row];
        [celll configCellWithModel:model];
        return celll;
    }
    
    NSString *cellIdentifier = @"Footprint21TableViewCell";
//    Footprint21TableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    if (!celll) {
//        celll = [[Footprint21TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//    }
    Footprint21TableViewCell *celll = [[Footprint21TableViewCell alloc] init];
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    celll.Footprint21TableViewCellDelegate = self;
    Footprint21Model* model = self.dataSourceArr21[indexPath.row];
    [celll configCellWithModel:model];
    return celll;
}

#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        Footprint0Model *model = nil;
        if (indexPath.row < self.dataSourceArr0.count) {
            model = [self.dataSourceArr0 objectAtIndex:indexPath.row];
        }
        
        return [Footprint0TableViewCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
            Footprint0TableViewCell *cell = (Footprint0TableViewCell *)sourceCell;
            [cell configCellWithModel:model];
        }];
    }else if (1 == indexPath.section){
        return [Footprint1TableViewCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
            Footprint1TableViewCell *cell = (Footprint1TableViewCell *)sourceCell;
            [cell configCellWithModel];
        }];
    }
    
    if (self.isYi) {
        Footprint20Model *model = nil;
        if (indexPath.row < self.dataSourceArr20.count) {
            model = [self.dataSourceArr20 objectAtIndex:indexPath.row];
        }
        
        return [Footprint20TableViewCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
            Footprint20TableViewCell *cell = (Footprint20TableViewCell *)sourceCell;
            [cell configCellWithModel:model];
        }];
    }
    
    Footprint21Model *model = nil;
    if (indexPath.row < self.dataSourceArr21.count) {
        model = [self.dataSourceArr21 objectAtIndex:indexPath.row];
    }
    
    return [Footprint21TableViewCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        Footprint21TableViewCell *cell = (Footprint21TableViewCell *)sourceCell;
        [cell configCellWithModel:model];
    }];
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    self.baseView = [MyController viewWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], 60)];
    self.baseView.backgroundColor = [MyController colorWithHexString:DEFAULTCOLOR];
    
    self.bgView = [MyController viewWithFrame:self.baseView.frame];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.baseView addSubview:self.bgView];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(0);
        make.height.mas_offset(60);
    }];
    
    self.yiLable = [MyController createLabelWithFrame:self.bgView.frame Font:18 Text:self.signsNum];
    if (!self.isYi) {
        self.yiLable.textColor = [MyController colorWithHexString:TEXTCOLOR];
    }else{
        self.yiLable.textColor = [MyController colorWithHexString:@"4c89f0"];
    }
    self.yiLable.textAlignment = NSTextAlignmentCenter;
    [self.bgView addSubview:self.yiLable];
    
    [self.yiLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(0);
        make.width.mas_offset(60);
    }];
    
    self.yiLable1 = [MyController createLabelWithFrame:self.bgView.frame Font:14 Text:@"已签到"];
    if (!self.isYi) {
        self.yiLable1.textColor = [MyController colorWithHexString:TEXTCOLOR];
    }else{
        self.yiLable1.textColor = [MyController colorWithHexString:@"4c89f0"];
    }
    self.yiLable1.textAlignment = NSTextAlignmentCenter;
    [self.bgView addSubview:self.yiLable1];
    
    [self.yiLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.yiLable);
        make.top.mas_equalTo(self.yiLable.mas_bottom).mas_offset(5);
        make.width.mas_equalTo(self.yiLable);
    }];
    
    self.bottomIV = [MyController createImageViewWithFrame:self.bgView.frame ImageName:@""];
    if (self.isYi) {
        self.bottomIV.image = [UIImage imageNamed:@"圆角矩形-3"];
    }else{
        self.bottomIV.image = [UIImage imageNamed:@""];
    }
    [self.bgView addSubview:self.bottomIV];
    
    [self.bottomIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.yiLable1).mas_offset(20);
        make.top.mas_equalTo(self.bgView.mas_bottom).mas_offset(-10);
        make.width.mas_offset(20);
        make.height.mas_offset(10);
    }];
    
    self.bottomIV1 = [MyController createImageViewWithFrame:self.bgView.frame ImageName:@""];
    if (!self.isYi) {
        self.bottomIV1.image = [UIImage imageNamed:@"圆角矩形-3"];
    }else{
        self.bottomIV1.image = [UIImage imageNamed:@""];
    }
    [self.bgView addSubview:self.bottomIV1];
    
    [self.bottomIV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.yiLable1).mas_offset(20);
        make.top.mas_equalTo(self.bgView.mas_bottom).mas_offset(-10);
        make.width.mas_offset(20);
        make.height.mas_offset(10);
    }];
    
    self.yiBtn = [MyController createButtonWithFrame:self.bgView.frame ImageName:nil Target:self Action:@selector(yiBtnClick) Title:nil];
    [self.bgView addSubview:self.yiBtn];
    
    [self.yiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.yiLable);
        make.top.mas_equalTo(self.yiLable);
        make.width.mas_equalTo(self.yiLable);
        make.bottom.mas_equalTo(self.bgView.mas_bottom);
    }];
    
//    self.weiBtn = [MyController createButtonWithFrame:self.bgView.frame ImageName:nil Target:self Action:@selector(weiBtnClick) Title:nil];
//    [self.bgView addSubview:self.weiBtn];
//    
//    [self.weiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.weiLable);
//        make.top.mas_equalTo(self.weiLable);
//        make.width.mas_equalTo(self.weiLable);
//        make.bottom.mas_equalTo(self.bgView.mas_bottom);
//    }];
    
    self.lineView = [MyController viewWithFrame:self.bgView.frame];
    self.lineView.backgroundColor = [MyController colorWithHexString:LINECOLOR];
    [self.bgView addSubview:self.lineView];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.bgView.mas_bottom).mas_offset(-0.5);
        make.height.mas_offset(0.5);
    }];
    
    return self.baseView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (2 == section) {
        return 60;
    }
    return 0;
}

/**
 cell1轨迹代理
 */
- (void)sendBackGuiji{
    NSLog(@"轨迹");
    FootprintDetailViewController* vc = [[FootprintDetailViewController alloc] init];
    vc.timeStr = self.timeStr;
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 cell21代理
 */
- (void)sendBackTixing{
    NSLog(@"提醒");
    RemindViewController* vc = [[RemindViewController alloc] init];
    vc.title = @"提醒一下";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)weiBtnClick{
    NSLog(@"未签到");
    self.isYi = NO;
    
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)yiBtnClick{
    NSLog(@"已签到");
    self.isYi = YES;
    
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)sendBackSelectTime{
    NSLog(@"选时间");
    _selectDatePicker = [[MHDatePicker alloc] init];
    _selectDatePicker.isBeforeTime = YES;
    /*
     UIDatePickerModeTime,           // Displays hour, minute, and optionally AM/PM designation depending on the locale setting (e.g. 6 | 53 | PM)
     UIDatePickerModeDate,           // Displays month, day, and year depending on the locale setting (e.g. November | 15 | 2007)
     UIDatePickerModeDateAndTime,    // Displays date, hour, minute, and optionally AM/PM designation depending on the locale setting (e.g. Wed Nov 15 | 6 | 53 | PM)
     UIDatePickerModeCountDownTimer,
     */
    _selectDatePicker.datePickerMode = UIDatePickerModeDate;
    
    __weak typeof(self) weakSelf = self;
    [_selectDatePicker didFinishSelectedDate:^(NSDate *selectedDate) {
        Footprint0Model* model = [self.dataSourceArr0 lastObject];
        model.time = [weakSelf dateStringWithDate:selectedDate DateFormat:@"yyyy-MM-dd"];
        
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
        [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        
        self.timeStr = model.time;
        [_tableView.mj_header beginRefreshing];
    }];
}

- (NSString *)dateStringWithDate:(NSDate *)date DateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSString *str = [dateFormatter stringFromDate:date];
    return str ? str : @"";
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
