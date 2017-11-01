//
//  SignInViewController.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/4.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "SignInViewController.h"

#import "SignInTableViewCell.h"

#import "SignInAddModel.h"

#import "SignInAddTableViewCell.h"

#import "AdjustAddViewController.h"

#import "SignSecondViewController.h"
@interface SignInViewController ()<UITableViewDataSource,UITableViewDelegate,SignInAddTableViewCellDelegate,AdjustAddViewControllerDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,strong)NSMutableArray* dataSourceArr;
@property(nonatomic,strong)NSMutableArray* dataSourceArr1;
@property(nonatomic,strong)AMapLocationManager* locationManager;
@property(nonatomic,copy)NSString* lat;
@property(nonatomic,copy)NSString* lng;
@property(nonatomic,assign)BOOL isNoFirst;
@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataSourceArr1 = [[NSMutableArray alloc] init];
    
    SignInAddModel* model = [[SignInAddModel alloc] init];
    [self.dataSourceArr1 addObject:model];
    [self createTableView];
    
    [self loadteDK];
}

- (void)viewWillAppear:(BOOL)animated{
    if (self.isNoFirst) {
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
        [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    self.isNoFirst = YES;
}

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
        
        SignInAddModel* model = [[SignInAddModel alloc] init];
        if (regeocode.POIName.length) {
            model.add = regeocode.POIName;
        }else{
            model.add = regeocode.formattedAddress;
        }
        
        model.add1 = regeocode.formattedAddress;//[NSString stringWithFormat:@"%@%@",regeocode.street,regeocode.number];
        NSLog(@"----%@",regeocode);
        self.dataSourceArr1 = [[NSMutableArray alloc] init];
        [self.dataSourceArr1 addObject:model];
        [_tableView reloadData];
        NSLog(@"location:%@", location);
        self.lat = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
        self.lng = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
        [HUD hide];
        if (regeocode){
            NSLog(@"reGeocode:%@", regeocode);
        }
    }];
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
}

#pragma mark - tableView行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (0 == section) {
        return 1;
    }
    return self.dataSourceArr1.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

#pragma mark - tableVie点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 ==  indexPath.section) {
        NSString *cellIdentifier = @"SignInTableViewCell";
        SignInTableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!celll) {
            celll = [[SignInTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        celll.selectionStyle = UITableViewCellSelectionStyleNone;
        [celll configCellWithModel];
        return celll;
    }
    
    SignInAddTableViewCell *celll = [[SignInAddTableViewCell alloc] init];
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    celll.SignInAddTableViewCellDelegate = self;
    SignInAddModel* model = self.dataSourceArr1[indexPath.row];
    [celll configCellWithModel:model];
    return celll;
}

#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        return [SignInTableViewCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
            SignInTableViewCell *cell = (SignInTableViewCell *)sourceCell;
            [cell configCellWithModel];
        } cache:^NSDictionary *{
            return @{kHYBCacheUniqueKey: @"SignInTableViewCell",
                     kHYBCacheStateKey : @"SignInTableViewCellkey",
                     kHYBRecalculateForStateKey : @(NO)
                     };
        }];
    }
    
    SignInAddModel *model = nil;
    if (indexPath.row < self.dataSourceArr1.count) {
        model = [self.dataSourceArr1 objectAtIndex:indexPath.row];
    }
    
    NSString *stateKey = nil;
    if (model.isExpand) {
        stateKey = @"expanded";
    } else {
        stateKey = @"unexpanded";
    }
    
    return [SignInAddTableViewCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        SignInAddTableViewCell *cell = (SignInAddTableViewCell *)sourceCell;
        [cell configCellWithModel:model];
    } cache:^NSDictionary *{
        return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%d", model.uid],
                 kHYBCacheStateKey : stateKey,
                 kHYBRecalculateForStateKey : @(NO)
                 };
    }];
}

/**
 微调代理
 */
- (void)sendBackWeitiao{
    AdjustAddViewController* vc = [[AdjustAddViewController alloc] init];
    vc.AdjustAddViewControllerDelegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)sendBackSelectTime:(NSString *)addName add1:(NSString *)add1 jingdu:(NSString *)jingdu weidu:(NSString *)weidu{
    SignInAddModel* model = [self.dataSourceArr1 lastObject];
    model.add = addName;
    model.add1 = add1;
    self.lat = weidu;
    self.lng = jingdu;
    [_tableView reloadData];
}

/**
 签到代理
 */
- (void)sendBackQiandao{
    [self locationErrorCorrectionlocation];
}

- (NSString*)getCurrentDay1{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY年MM月dd日 HH:mm:ss"];
    NSString *dateTime = [formatter stringFromDate:date];
    return dateTime;
}

- (NSString*)getCurrentDay2{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *dateTime = [formatter stringFromDate:date];
    return dateTime;
}

- (void)sendBackKehuName:(NSString *)kehuName{
    SignInAddModel* model = [self.dataSourceArr1 lastObject];
    model.kehu = kehuName;
    [_tableView reloadData];
}

#pragma mark - 位置纠错 防止打开后未关闭  去另一个地方继续签到
- (void)locationErrorCorrectionlocation{
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
        
        //增加距离判断
        MAMapPoint point1 = MAMapPointForCoordinate(CLLocationCoordinate2DMake([self.lat floatValue],[self.lng floatValue]));
        MAMapPoint point2 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(location.coordinate.latitude,location.coordinate.longitude));
        CLLocationDistance distance = MAMetersBetweenMapPoints(point1,point2);
        [HUD hide];
        if (distance > 1000) {
            UIAlertView* al = [[UIAlertView alloc] initWithTitle:@"提示" message:@"因当前位置发生变化，系统已重新为您定位。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [al show];
            
            SignInAddModel* model = [[SignInAddModel alloc] init];
            if (regeocode.POIName.length) {
                model.add = regeocode.POIName;
            }else{
                model.add = regeocode.formattedAddress;
            }
            
            model.add1 = regeocode.formattedAddress;//[NSString stringWithFormat:@"%@%@",regeocode.street,regeocode.number];
            NSLog(@"----%@",regeocode);
            self.dataSourceArr1 = [[NSMutableArray alloc] init];
            [self.dataSourceArr1 addObject:model];
            [_tableView reloadData];
            NSLog(@"location:%@", location);
            self.lat = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
            self.lng = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
            [HUD hide];
            if (regeocode){
                NSLog(@"reGeocode:%@", regeocode);
            }
        }else{
            SignInAddModel* model = [self.dataSourceArr1 lastObject];
            if (![MyController returnStr:model.add].length) {
                [HUD warning:@"请完善签到地址"];
                return;
            }
            SignSecondViewController* vc = [[SignSecondViewController alloc] init];
            vc.model = [[SignSecondModel alloc] init];
            vc.model.add = model.add;
            vc.model.add1 = model.add1;
            vc.model.name = [MyController returnStr:model.kehu];
            vc.model.time = [self getCurrentDay1];
            vc.model.time1 = [self getCurrentDay2];
            vc.lat = self.lat;
            vc.lng = self.lng;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }];
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
