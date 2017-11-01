//
//  DailyNewViewController.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/23.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "DailyNewViewController.h"

#import "DailyNew0Model.h"

#import "DailyNew0TableViewCell.h"

#import "DailyNew1Model.h"

#import "DailyNew1TableViewCell.h"

#import "DailyNew2Model.h"

#import "DailyNew2TableViewCell.h"

#import "ContactViewController.h"
@interface DailyNewViewController ()<UITableViewDataSource,UITableViewDelegate,AdvancedExpandableTableViewDelegate,DailyNew1TableViewCellDelegate,DailyNew2TableViewCellDelegate,ContactViewControllerDelegate,UIAlertViewDelegate>{
    UITableView* _tableView;
    CGFloat textCellHeight;
}
@property(nonatomic,strong)NSMutableArray* dataSourceArr0;
@property(nonatomic,strong)NSMutableArray* dataSourceArr1;
@property(nonatomic,strong)NSMutableArray* dataSourceArr2;

@property(nonatomic,copy)NSString* _token;
@property(nonatomic,copy)NSString* _errorCode;
@property(nonatomic,copy)NSString* _content;
@property(nonatomic,copy)NSString* _loaction;
@property(nonatomic,copy)NSString* _sendMessage;
@property(nonatomic,copy)NSString* _sendPers;
@property(nonatomic,copy)NSString* _time;

@property(nonatomic,strong)AMapLocationManager* locationManager;
@end

@implementation DailyNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self._sendMessage = @"0";
    self._sendPers = @"";
    self._time = [self getCurrentTime];
    
    [self makeData];

    [self createTableView];

    [self makeSendView];
}

/**
 获取当前时间
 
 @return 返回时间
 */
- (NSString *)getCurrentTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (1 == buttonIndex) {
        NSLog(@"删除");
        DailyNew1Model* m1 = [self.dataSourceArr1 lastObject];
        [m1.pArr removeAllObjects];
        self._sendPers = @"";
        [_tableView reloadSections:[[NSIndexSet alloc]initWithIndex:2] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - 新增发给谁代理
- (void)sendBackAddPerson {
    NSLog(@"发给谁");
    DailyNew1Model* m1 = [self.dataSourceArr1 lastObject];
    if (m1.pArr.count) {
        UIAlertView* al = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否要删除发送人" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [al show];
    }else {
        ContactViewController* vc = [[ContactViewController alloc] init];
        vc.isFromAndy = YES;
        vc.ContactViewControllerDelegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

#pragma mark - 代理返回选中的通知者
- (void)sendBackName:(NSString *)_name AndId:(NSString *)_id {
    self.dataSourceArr1 = [[NSMutableArray alloc] init];
    DailyNew1Model* m1 = [[DailyNew1Model alloc] init];
    m1.pArr = [[NSMutableArray alloc] initWithObjects:_name, nil];
    self._sendPers = _id;
    NSLog(@"---%@",self._sendPers);
    [self.dataSourceArr1 addObject:m1];
    
    [_tableView reloadSections:[[NSIndexSet alloc]initWithIndex:2] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - 获取所在位置
- (void)loadteDK{
    [HUD loading];
    self.locationManager = [[AMapLocationManager alloc] init];
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    // 定位超时时间，最低2s，此处设置为2s
    self.locationManager.locationTimeout =2;
    // 逆地理请求超时时间，最低2s，此处设置为2s
    self.locationManager.reGeocodeTimeout = 2;
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error){
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            [HUD warning:@"定位失败,请重新尝试"];
            if (error.code == AMapLocationErrorLocateFailed){
                return;
            }
        }
        
        self._loaction = regeocode.formattedAddress;
        NSLog(@"----%@",self._loaction);
        [_tableView reloadData];
        [HUD hide];
        if (regeocode){
            NSLog(@"reGeocode:%@", regeocode);
        }
    }];
}


#pragma mark - 写日报
- (void)postCreateDaily{
    [requestService postCreateTokenWithUserId:[MyController getUserid] cname:[MyController getCName] complate:^(id responseObject) {
        if ([responseObject[@"result"] intValue]) {
            NSDictionary* souDic = [MyController dictionaryWithJsonString:responseObject[@"data"]];
            self._token = souDic[@"token"];
            self._errorCode = souDic[@"errorCode"];
            
            [requestService postCreateDailyWithUserId:[MyController getUserid] content:self._content loaction:self._loaction sendMessage:self._sendMessage sendPers:self._sendPers token:self._token time:self._time cname:[MyController getCName] complate:^(id responseObject) {
                if ([responseObject[@"result"] intValue]) {
                    [HUD success:responseObject[@"data"]];
                    [self.DailyNewViewControllerDelegate sendBackNewDailySuccess:YES];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            } failure:^(NSError *error) {
                
            }];
            
        }
    } failure:^(NSError *error) {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    }];

}

- (void)makeData{
    self.dataSourceArr1 = [[NSMutableArray alloc] init];
//    DailyNew1Model* m1 = [[DailyNew1Model alloc] init];
//    [self.dataSourceArr1 addObject:m1];
    
    self.dataSourceArr2 = [[NSMutableArray alloc] init];
    DailyNew2Model* m2 = [[DailyNew2Model alloc] init];
    m2.isOn = NO;
    [self.dataSourceArr2 addObject:m2];
}
- (void)makeSendView{
    UIButton* sendBtn = [MyController createButtonWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame), [MyController getScreenWidth], 50) ImageName:nil Target:self Action:@selector(sendBtnClick) Title:@"提交"];
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendBtn setBackgroundColor:[MyController colorWithHexString:@"4c89f0"]];
    [self.view addSubview:sendBtn];
}

- (void)sendBtnClick{
    NSLog(@"提交");
    if (![MyController returnStr:self._content].length) {
        [HUD warning:@"请填写日报内容"];
        return;
    }else if (![MyController returnStr:self._loaction].length) {
        [HUD warning:@"请选取地址"];
        return;
    }else if (1 == [self._sendMessage intValue]) {
        if (![MyController returnStr:self._sendPers].length) {
            [HUD warning:@"请选择发送人"];
            return;
        }
    }
    [self postCreateDaily];
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
    if (0 == section) {
        return 1;
    }else if (1 == section){
        return self.dataSourceArr2.count;
    }
    return self.dataSourceArr1.count;
}

#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        DailyNew0TableViewCell *textCell = [tableView advancedExpandableTextCellWithId2:@"DailyNew0TableViewCell"];
        textCell.placeholder = @"请填写";
        textCell.selectionStyle = UITableViewCellSelectionStyleNone;
        textCell.maxCharacter = 1000;
        if ([MyController returnStr:self._loaction].length) {
            textCell.areaLable.text = self._loaction;
        }else {
            textCell.areaLable.text = @"请选取位置";
        }
        textCell.DailyNew0TableViewCellDelegate = self;
        return textCell;

    }else if (1 == indexPath.section){
        NSString *cellIdentifier = @"DailyNew2TableViewCell";
        DailyNew2TableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!celll) {
            celll = [[DailyNew2TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        celll.selectionStyle = UITableViewCellSelectionStyleNone;
        DailyNew2Model* model = self.dataSourceArr2[indexPath.row];
        celll.DailyNew2TableViewCellDelegate = self;
        [celll configCellWithModel:model];
        return celll;
    }
    
    NSString *cellIdentifier = @"DailyNew1TableViewCell";
    DailyNew1TableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!celll) {
        celll = [[DailyNew1TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    DailyNew1Model* model = self.dataSourceArr1[indexPath.row];
    celll.DailyNew1TableViewCellDelegate = self;
    [celll configCellWithModel:model];
    return celll;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        return MAX(176 + 20, textCellHeight + 20);
    }else if (1 == indexPath.section){
        DailyNew2Model *model = nil;
        if (indexPath.row < self.dataSourceArr2.count) {
            model = [self.dataSourceArr2 objectAtIndex:indexPath.row];
        }
        
        return [DailyNew2TableViewCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
            DailyNew2TableViewCell *cell = (DailyNew2TableViewCell *)sourceCell;
            [cell configCellWithModel:model];
        }];
    }
    
    DailyNew1Model *model = nil;
    if (indexPath.row < self.dataSourceArr1.count) {
        model = [self.dataSourceArr1 objectAtIndex:indexPath.row];
    }
    
    return [DailyNew1TableViewCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        DailyNew1TableViewCell *cell = (DailyNew1TableViewCell *)sourceCell;
        [cell configCellWithModel:model];
    }];
}

#pragma mark - 这是事由cell代理
- (void)tableView:(UITableView *)tableView updatedHeight:(CGFloat)height atIndexPath:(NSIndexPath *)indexPath{
    textCellHeight = height;
    NSLog(@"高度---%.2f",textCellHeight);
}
- (void)tableView:(UITableView *)tableView updatedText:(NSString *)text atIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"debug : updatedText\n%@", text);
    self._content = text;
}


/**
 cell0的回调  选地址
 */
- (void)sendBackSelectArea{
    NSLog(@"选地址");
    [self loadteDK];
}


/**
 cell2代理

 @param isOn 开关状态
 */
- (void)sendBackIsOn:(BOOL)isOn{
    if (!isOn) {
        self._sendMessage = @"1";
        self.dataSourceArr1 = [[NSMutableArray alloc] init];
        DailyNew1Model* m1 = [[DailyNew1Model alloc] init];
        [self.dataSourceArr1 addObject:m1];
    }else{
        self._sendMessage = @"0";
        [self.dataSourceArr1 removeAllObjects];
    }
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
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
