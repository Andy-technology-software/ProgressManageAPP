//
//  SignInRecordViewController.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/27.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "SignInRecordViewController.h"

#import "SignInRecordModel.h"

#import "SignInRecordTableViewCell.h"

#import "Footprint1TableViewCell.h"

#import "SignInRecord1Model.h"

#import "SignInRecord1TableViewCell.h"

#import "FootprintDetailOneViewController.h"

#import "FullTimeView.h"
@interface SignInRecordViewController ()<UITableViewDataSource,UITableViewDelegate,Footprint1TableViewCellDelegate,SignInRecord1TableViewCellDelegate,UIAlertViewDelegate,MWPhotoBrowserDelegate,SignInRecordTableViewCellDelegate,FinishPickView>{
    UITableView* _tableView;
    UIButton *btn;
    NSString *currentDate;
    UIView *topView;
}
@property (strong, nonatomic) MHDatePicker *selectDatePicker;

@property(nonatomic,strong)NSMutableArray* dataSourceArr0;
@property(nonatomic,strong)NSMutableArray* dataSourceArr2;

@property(nonatomic,assign)NSInteger deleIndex;
@property(nonatomic,copy)NSString* timeStr;

@property (nonatomic, strong) UIView* bgView;
@property (nonatomic, strong) UIView* lineView;
@property (nonatomic, strong) UILabel* timeLable;

@property (strong, nonatomic) UINavigationController *photoNavigationController;
@property (strong, nonatomic) MWPhotoBrowser *photoBrowser;
@property (strong, nonatomic) UIWindow *keyWindow;
@property(nonatomic,retain)NSMutableArray* photos;

@property(nonatomic,assign)NSInteger pageIndex;

@property(nonatomic,copy)NSString* jingdu;
@property(nonatomic,copy)NSString* weidu;
@end

@implementation SignInRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataSourceArr0 = [[NSMutableArray alloc] init];
    self.dataSourceArr2 = [[NSMutableArray alloc] init];
    
    self.timeStr = [self getCurrentDay1];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    SignInRecordModel* m0 = [[SignInRecordModel alloc] init];
    m0.name = self.name;
    m0.time = [self getCurrentDay1];
    m0.signTimes = @"";
    m0.cname = [userDefaults objectForKey:@"companyName"];
    [self.dataSourceArr0 addObject:m0];
    
    
    [self createTableView];
    
    [_tableView.mj_header beginRefreshing];
}

- (void)getzuji:(NSString*)pnum AndNum:(NSString*)num AndTime:(NSString*)time{
    [requestService postGERENZUJIWithSignDate:time pnum:pnum num:num userId:self.userid complate:^(id responseObject) {
        NSDictionary* aaD = [MyController dictionaryWithJsonString:responseObject[@"data"]];
        NSLog(@"%@",aaD);
        NSArray* sourceArr = aaD[@"signs"];
        int i = 0;
        NSMutableArray *_array = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary* dic in sourceArr) {
            
            if (0 == i) {
                self.jingdu = dic[@"lon"];
                self.weidu = dic[@"lat"];
            }
            i++;
            
            SignInRecord1Model* m2 = [[SignInRecord1Model alloc] init];
            m2.time = [MyController returnStr:dic[@"signDate"]];
            m2.addDetail = [MyController returnStr:dic[@"location"]];
            m2.add = [MyController returnStr:dic[@"address"]];
            m2.remark = [MyController returnStr:dic[@"remark"]];
            m2.image = [MyController returnStr:dic[@"img"]];
            m2.cName = [MyController returnStr:dic[@"customer"]];
            [_array addObject:m2];
        }
        
        SignInRecordModel* m0 = [self.dataSourceArr0 lastObject];
        m0.signTimes = [NSString stringWithFormat:@"%d",[aaD[@"signTimes"] intValue]];
        
        //循环完成
        if (self.pageIndex == 1) {
            //删除原有数据 对数据源重新追加数据
            [self.dataSourceArr2 removeAllObjects];
//            [self.dataSourceArr2 addObjectsFromArray:_array];
            
            if (_array.count) {
                if (_array.count > 1) {
                    NSMutableArray* temA = [[NSMutableArray alloc] init];
                    SignInRecord1Model* model0 = _array[0];
                    [temA addObject:model0];
                    for (int i = 1; i < _array.count; i++) {
                        SignInRecord1Model* model1 = _array[i];
                        SignInRecord1Model* model = _array[i - 1];
                        NSLog(@"111111---%@-----%@",[model.time substringToIndex:10],[model1.time substringToIndex:10]);
                        if ([[model1.time substringToIndex:10] isEqualToString:[model.time substringToIndex:10]]) {
                            NSLog(@"666----%@",model.time);
                            //表示同一天
                            [temA addObject:model1];
                            if (i == _array.count - 1) {
                                [self.dataSourceArr2 addObject:temA];
                            }
                        }else{
                            //不是同一天
                            NSLog(@"777----%d",temA.count);
                            [self.dataSourceArr2 addObject:temA];
                            temA = [[NSMutableArray alloc] init];
                            [temA addObject:model1];
                            if (i == _array.count - 1) {
                                [self.dataSourceArr2 addObject:temA];
                            }
                        }
                    }
                }else{
                    [self.dataSourceArr2 addObject:_array];
                }
                
            }
            NSArray* arr0 = [self.dataSourceArr2 firstObject];
            NSArray* arr1 = [self.dataSourceArr2 lastObject];
            NSLog(@"----%d----%d",arr0.count,arr1.count);
            NSLog(@"数据源----%@",self.dataSourceArr2);
            //刷新表格
            [_tableView reloadData];
            //下拉刷新停止
            [_tableView.mj_header endRefreshing];
        }else {
            //对现有数据源进行追加数据
//            [self.dataSourceArr2 addObjectsFromArray:_array];
            NSMutableArray* temA = [[NSMutableArray alloc] init];
            if (_array.count) {
                if (_array.count > 1) {
                    int k = 0;
                    
                    SignInRecord1Model* modelLast = [[self.dataSourceArr2 lastObject] lastObject];
                    NSMutableArray* lastArr = [self.dataSourceArr2 lastObject];
                    for (int i = 0; i < _array.count; i++) {
                        k = i;
                        SignInRecord1Model* model = _array[i];
                        if ([[model.time substringToIndex:10] isEqualToString:[modelLast.time substringToIndex:10]]) {
                            //说明这个数据跟上一组是一个时间的
                            [lastArr addObject:model];
                        }else{
                            break;
                        }
                    }
                    
                    for (int i = k; i < _array.count - 1; i++) {
                        SignInRecord1Model* model = _array[i];
                        SignInRecord1Model* model1 = _array[i + 1];
                        NSLog(@"111111---%@-----%@",[model.time substringToIndex:10],[model1.time substringToIndex:10]);
                        if ([[model1.time substringToIndex:10] isEqualToString:[model.time substringToIndex:10]]) {
                            NSLog(@"666----%@",model.time);
                            //表示同一天
                            [temA addObject:model1];
                            if (i == _array.count - 1) {
                                
                                [self.dataSourceArr2 addObject:temA];
                                temA = [[NSMutableArray alloc] init];
                            }
                        }else{
                            //不是同一天
                            NSLog(@"777----%d",temA.count);
                            [self.dataSourceArr2 addObject:temA];
                            temA = [[NSMutableArray alloc] init];
                            [temA addObject:model1];
                            if (i == _array.count - 1) {
                                [self.dataSourceArr2 addObject:temA];
                            }
                        }
                    }
                    
                }else{
                    SignInRecord1Model* model = [_array lastObject];
                    SignInRecord1Model* modelLast = [[self.dataSourceArr2 lastObject] lastObject];
                    NSMutableArray* lastArr = [self.dataSourceArr2 lastObject];
                    if ([[model.time substringToIndex:10] isEqualToString:[modelLast.time substringToIndex:10]]) {
                        //说明这个数据跟上一组是一个时间的
                        [lastArr addObject:model];
                    }else{
                        [self.dataSourceArr2 addObject:_array];
                    }

                }
                
            }
            
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
    [formatter setDateFormat:@"YYYY-MM"];
    NSString *dateTime = [formatter stringFromDate:date];
    return dateTime;
}

- (NSString*)getCurrentDay2{
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
    //    [_tableView.header endRefreshing];
    self.pageIndex = 1;
    [self getzuji:@"1" AndNum:@"10" AndTime:self.timeStr];
}
#pragma mark - 上拉加载
- (void)footRefresh{
    //    [_tableView.footer endRefreshing];
    self.pageIndex++;
    [self getzuji:[NSString stringWithFormat:@"%ld",self.pageIndex] AndNum:@"10" AndTime:self.timeStr];
}

#pragma mark - tableView行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (1 < section) {
        NSArray* arr = self.dataSourceArr2[section - 2];
        if (2 == section) {
            
        }else if (3 == section){
            
        }
        return arr.count;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"----%d",self.dataSourceArr2.count);
    return 2 + self.dataSourceArr2.count;
}

#pragma mark - tableVie点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 ==  indexPath.section) {
        NSString *cellIdentifier = @"SignInRecordTableViewCell";
        SignInRecordTableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!celll) {
            celll = [[SignInRecordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        celll.selectionStyle = UITableViewCellSelectionStyleNone;
        celll.SignInRecordTableViewCellDelegate = self;
        SignInRecordModel* model = self.dataSourceArr0[indexPath.row];
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
    
    NSString *cellIdentifier = [NSString stringWithFormat:@"%d",indexPath.section*10 + indexPath.row];
    SignInRecord1TableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!celll) {
        celll = [[SignInRecord1TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    SignInRecord1Model* model = self.dataSourceArr2[indexPath.section - 2][indexPath.row];
    NSLog(@"2222---------%@",model.time);
    celll.SignInRecord1TableViewCellDelegate = self;
    celll.index = indexPath.row;
    celll.cellSection = indexPath.section;
    [celll configCellWithModel:model];
    return celll;
}

#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        SignInRecordModel *model = nil;
        if (indexPath.row < self.dataSourceArr0.count) {
            model = [self.dataSourceArr0 objectAtIndex:indexPath.row];
        }
        
        return [SignInRecordTableViewCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
            SignInRecordTableViewCell *cell = (SignInRecordTableViewCell *)sourceCell;
            [cell configCellWithModel:model];
        }];
    }else if (1 == indexPath.section){
        return [Footprint1TableViewCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
            Footprint1TableViewCell *cell = (Footprint1TableViewCell *)sourceCell;
            [cell configCellWithModel];
        }];
    }
    
    SignInRecord1Model *model = nil;
    NSArray* arr = self.dataSourceArr2[indexPath.section - 2];
    if (indexPath.row < arr.count) {
        model = [arr objectAtIndex:indexPath.row];
        NSLog(@"-------%d--------%@",indexPath.section,model.time);
    }
    
    return [SignInRecord1TableViewCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        SignInRecord1TableViewCell *cell = (SignInRecord1TableViewCell *)sourceCell;
        [cell configCellWithModel:model];
    }];
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (2 > section) {
        return nil;
    }
    self.bgView = [MyController viewWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], 50)];
    self.bgView.backgroundColor = [MyController colorWithHexString:DEFAULTCOLOR];
    
    self.lineView = [MyController viewWithFrame:self.view.frame];
    self.lineView.backgroundColor = [MyController colorWithHexString:LINECOLOR];
    [self.bgView addSubview:self.lineView];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_offset(4);
    }];
    
    self.timeLable = [MyController createLabelWithFrame:self.view.frame Font:14 Text:nil];
    self.timeLable.textColor = [MyController colorWithHexString:@"a6abb9"];
    self.timeLable.backgroundColor = [UIColor whiteColor];
    self.timeLable.textAlignment = NSTextAlignmentCenter;
    //将图层的边框设置为圆脚
    self.timeLable.layer.cornerRadius = 12;
    self.timeLable.layer.masksToBounds = YES;
    [self.timeLable setContentMode:UIViewContentModeScaleAspectFill];
    self.timeLable.clipsToBounds = YES;
    [self.bgView addSubview:self.timeLable];
    
    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(15);
        make.width.mas_offset(95);
        make.height.mas_offset(26);
    }];
    
    SignInRecord1Model* model = [self.dataSourceArr2[section - 2] firstObject];
    self.timeLable.text = [model.time substringToIndex:10];
    
    return self.bgView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (1 < section) {
        return 50;
    }
    return 0;
}


/**
 地图cell代理
 */
- (void)sendBackGuiji{
    FootprintDetailOneViewController* vc = [[FootprintDetailOneViewController alloc] init];
    vc.userId = self.userid;
    vc.title = [NSString stringWithFormat:@"%@的足迹",self.name];
    [self.navigationController pushViewController:vc animated:YES];
}


/**
 cell

 @param cellIndex 删除第几个
 */
- (void)deleIndex:(NSInteger)cellIndex{
    self.deleIndex = cellIndex;
    UIAlertView* al = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否要删除当前签到记录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [al show];
}

- (void)sendBackCheckImage:(NSInteger)cellIndex andSection:(NSInteger)cellSection{
    SignInRecord1Model* model = self.dataSourceArr2[cellSection - 2][cellIndex];
    self.photos = [[NSMutableArray alloc] init];
    [self.photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:model.image]]];
    
    UIViewController *rootController = [self.keyWindow rootViewController];
    [rootController presentViewController:self.photoNavigationController animated:YES completion:nil];
    [_photoBrowser setCurrentPhotoIndex:0];
}

#pragma mark - getter 创建一个显示图片的window
- (UIWindow *)keyWindow{
    if(_keyWindow == nil){
        _keyWindow = [[UIApplication sharedApplication] keyWindow];
    }
    return _keyWindow;
}
#pragma mark - 初始化MWPhotoBrowser
- (MWPhotoBrowser *)photoBrowser{
    if (_photoBrowser == nil) {
        _photoBrowser = [[MWPhotoBrowser alloc] initWithDelegate:self];
        _photoBrowser.displayActionButton = YES;
        _photoBrowser.displayNavArrows = YES;
        _photoBrowser.displaySelectionButtons = NO;
        _photoBrowser.alwaysShowControls = NO;
        _photoBrowser.wantsFullScreenLayout = YES;
        _photoBrowser.zoomPhotosToFill = YES;
        _photoBrowser.enableGrid = NO;
        _photoBrowser.startOnGrid = NO;
    }
    return _photoBrowser;
}

- (UINavigationController *)photoNavigationController{
    if (_photoNavigationController == nil) {
        _photoNavigationController = [[UINavigationController alloc] initWithRootViewController:self.photoBrowser];
        _photoNavigationController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    [self.photoBrowser reloadData];
    return _photoNavigationController;
}

#pragma mark - MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser{
    return [self.photos count];
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index{
    if (index < self.photos.count){
        return [self.photos objectAtIndex:index];
    }
    return nil;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (1 == buttonIndex) {
        [self.dataSourceArr2 removeObjectAtIndex:self.deleIndex];
        
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
        [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


- (void)sendBackSelectTime{
    [self btnClick];
}

- (NSString *)dateStringWithDate:(NSDate *)date DateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSString *str = [dateFormatter stringFromDate:date];
    return str ? str : @"";
}




-(void)cancleBtnClick{
    [topView removeFromSuperview];
}
-(void)okBtnClick{
    [topView removeFromSuperview];
    SignInRecordModel* m0 = [self.dataSourceArr0 lastObject];
    m0.time = currentDate;
    
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    
    self.timeStr = m0.time;
    NSLog(@"---%@",self.timeStr);
    [_tableView.mj_header beginRefreshing];
    
}
#pragma mark - FinishPickView
- (void)didFinishPickView:(NSDate *)date
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM";
    NSString *dateString = [fmt stringFromDate:date];
    // NSLog(@"%@", dateString);
    currentDate = dateString;
}
-(void)btnClick{
    if (topView){
        [topView removeFromSuperview];
    }
    
    topView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-246, self.view.frame.size.width, 246)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,50)];
    selectView.backgroundColor = [MyController colorWithHexString:@"f6f6f6"];
    [topView addSubview:selectView];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(10, 0, 50, 50);
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[MyController colorWithHexString:@"007aff"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [selectView addSubview:leftBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(self.view.frame.size.width-60, 0, 50, 50);
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[MyController colorWithHexString:@"007aff"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(okBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [selectView addSubview:rightBtn];
    
    UIView* lineView = [MyController viewWithFrame:CGRectMake(0, 49.5, [MyController getScreenWidth], 0.5)];
    lineView.backgroundColor = [MyController colorWithHexString:@"dedede"];
    [selectView addSubview:lineView];
    
    
    FullTimeView *fullTimePicker = [[FullTimeView alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 246 - 50)];
    fullTimePicker.curDate = [NSDate date];
    fullTimePicker.delegate = self;
    [topView addSubview:fullTimePicker];
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