//
//  RealtimePositioningViewController.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/27.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "RealtimePositioningViewController.h"

@interface RealtimePositioningViewController ()<WJMenuDelegate,MAMapViewDelegate,AMapLocationManagerDelegate>{
    UILabel* temLable;
    UIView* temView;
}
@property(nonatomic,strong)UIView* bgView;
@property (nonatomic,weak)WJDropdownMenu *menu;
@property (nonatomic,strong)NSMutableArray *data;

@property(nonatomic,assign)BOOL isStart;

@property (nonatomic, strong) NSMutableArray *pointArr;//定位信息数组
@property (nonatomic, strong) MAUserLocation *currentUL;//当前位置
//地图
@property (nonatomic, strong) MAMapView *mapView;
//画线
@property (nonatomic, strong) MAPolyline *routeLine;
@property(nonatomic,strong)AMapLocationManager* locationManager;
@property(nonatomic,assign)CGFloat latitu;
@property(nonatomic,assign)CGFloat longit;
@end

@implementation RealtimePositioningViewController

- (void)viewWillAppear:(BOOL)animated{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    //屏幕消失的时候,释放地图资源
    [self clearMapView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //初始化位置数据源
    self.pointArr = [[NSMutableArray alloc] init];
    
    [self makeView];
    
    [self makeLocat];
    
    [self makeMenu];
}

- (void)makeView{
    self.bgView = [MyController viewWithFrame:self.view.frame];
    self.bgView.backgroundColor = [UIColor whiteColor];
    //将图层的边框设置为圆脚
    self.bgView.layer.cornerRadius = 6;
    self.bgView.layer.masksToBounds = YES;
    [self.bgView setContentMode:UIViewContentModeScaleAspectFill];
    self.bgView.clipsToBounds = YES;
    [self.view addSubview:self.bgView];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(40 + [MyController isIOS7]);
        make.bottom.mas_equalTo(-15);
    }];
    
    [AMapServices sharedServices].enableHTTPS = YES;
    _mapView = [[MAMapView alloc] initWithFrame:self.view.frame];
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    _mapView.showsCompass = NO;
    _mapView.showsScale = NO;
    [_mapView setZoomLevel:15.6 animated:YES];
    _mapView.desiredAccuracy = kCLLocationAccuracyBest;
    _mapView.distanceFilter = 1.0f;
    _mapView.pausesLocationUpdatesAutomatically = NO;
    _mapView.allowsBackgroundLocationUpdates = YES;
    _mapView.mapType = MAMapTypeStandard;
    [self.bgView addSubview:_mapView];
    
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(15);
        make.bottom.mas_equalTo(self.bgView.mas_bottom).mas_offset(-85);
    }];
    
    temView = [MyController viewWithFrame:self.bgView.frame];
    temView.backgroundColor = [MyController colorWithHexString:@"4c89f0"];
    temView.layer.cornerRadius = 30;
    temView.layer.masksToBounds = YES;
    [temView setContentMode:UIViewContentModeScaleAspectFill];
    temView.clipsToBounds = YES;
    [self.bgView addSubview:temView];
    
    [temView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.bgView);
        make.bottom.mas_equalTo(self.bgView.mas_bottom).mas_offset(-15);
        make.width.mas_offset(60);
        make.height.mas_offset(60);
    }];
    
    temLable = [MyController createLabelWithFrame:self.bgView.frame Font:18 Text:@"开始"];
    temLable.textColor = [UIColor whiteColor];
    temLable.textAlignment = NSTextAlignmentCenter;
    [self.bgView addSubview:temLable];
    
    [temLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(temView);
        make.bottom.mas_equalTo(temView);
        make.width.mas_equalTo(temView);
        make.height.mas_equalTo(temView);
    }];
    
    UIButton* temBtn = [MyController createButtonWithFrame:self.bgView.frame ImageName:nil Target:self Action:@selector(temBtnClick) Title:nil];
    [self.bgView addSubview:temBtn];
    
    [temBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(temView);
        make.bottom.mas_equalTo(temView);
        make.width.mas_equalTo(temView);
        make.height.mas_equalTo(temView);
    }];
}

/**
 定位一次
 */
- (void)makeLocat{
    self.locationManager = [[AMapLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    [self.locationManager startUpdatingLocation];
}
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location{
    //定位结果
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    self.latitu = location.coordinate.latitude;
    self.longit = location.coordinate.longitude;
    [self.locationManager stopUpdatingLocation];
    
//    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(self.latitu, self.longit) animated:YES];
}

//添加一个大头针和物理围栏
- (void)addPointAndCircleView {
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(self.latitu, self.longit);
    pointAnnotation.title = @"皮卡丘";
    pointAnnotation.subtitle = @"位置:滨海大道与江山南路交界";
    
    [_mapView addAnnotation:pointAnnotation];
}

- (void)temBtnClick{
    if (self.isStart) {
        [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(self.latitu, self.longit) animated:YES];
        self.mapView.showsUserLocation = NO;
        [self.mapView removeAnnotations:self.mapView.annotations];
        [self.mapView removeOverlays:self.mapView.overlays];
        self.mapView.delegate = nil;
        temLable.text = @"开始";
        temView.backgroundColor = [MyController colorWithHexString:@"4c89f0"];
    }else{
        self.mapView.showsUserLocation = YES;
        self.mapView.delegate = self;
        [self addPointAndCircleView];
        temLable.text = @"结束";
        temView.backgroundColor = [UIColor redColor];
    }
    
    self.isStart = !self.isStart;
}

#pragma mark - MAMapViewDelegate
//当位置改变时候调用
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    //updatingLocation 标示是否是location数据更新, YES:location数据更新 NO:heading数据更新
    if (updatingLocation == YES) {
        //增加距离判断
        if (self.currentUL) {
            MAMapPoint point1 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(self.latitu,self.longit));
            MAMapPoint point2 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(userLocation.coordinate.latitude,userLocation.coordinate.longitude));
            CLLocationDistance distance = MAMetersBetweenMapPoints(point1,point2);
            
            //判断当前点与之前点距离相差小于100米就不计入计算.
            if (distance < 100) {
                return;
            } else {
                self.latitu = userLocation.coordinate.latitude;
                self.longit = userLocation.coordinate.longitude;
                self.currentUL = userLocation;//设置当前位置
            }
        } else {
            self.currentUL = userLocation;//设置当前位置
        }
        //手机位置信息
        [self setPointArrWithCurrentUserLocation];
    }
}
//定位失败
- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error {
    NSString *errorString = @"";
    switch([error code]) {
        case kCLErrorDenied:
            //Access denied by user
            errorString = @"Access to Location Services denied by user";
            break;
        case kCLErrorLocationUnknown:
            //Probably temporary...
            errorString = @"Location data unavailable";
            //Do something else...
            break;
        default:
            errorString = @"An unknown error has occurred";
            break;
    }
}

//画线方法
- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id <MAOverlay>)overlay {
    //画线
    if ([overlay isKindOfClass:[MAPolyline class]]) {
        MAPolylineView *polylineView = [[MAPolylineView alloc] initWithPolyline:overlay];
        polylineView.lineWidth = 8.f;
        polylineView.strokeColor = [MyController colorWithHexString:ROADCOLOR];
        return polylineView;
    }
    //原型覆盖物--地理围栏
    if ([overlay isKindOfClass:[MACircle class]]) {
        MACircleView *circleView = [[MACircleView alloc] initWithCircle:overlay];
        circleView.lineWidth = 2.f;
        circleView.strokeColor = [UIColor clearColor];
        circleView.fillColor = [UIColor colorWithRed:139 / 255.0 green:186 / 255.0 blue:1 alpha:0.3];
        return circleView;
    }
    return nil;
}


////添加大头针
//- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation {
//    /*
//     *  当然画轨迹的同时,也可以添加个大头针,设置一个地理围栏.
//     */
//    //大头针标注
//    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
//        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
//        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
//        if (annotationView == nil) {
//            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
//        }
//        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
//        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
//        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
//        annotationView.pinColor = MAPinAnnotationColorPurple;
//        return annotationView;
//    }
//    return nil;
//}
////点击大头针或者当前坐标调用
//- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
//    //显示到屏幕最中间
//    CLLocationCoordinate2D locationView = CLLocationCoordinate2DMake(view.annotation.coordinate.latitude, view.annotation.coordinate.longitude);
//    [_mapView setCenterCoordinate:locationView animated:YES];
//}
////点击view的泡泡时调用
//- (void)mapView:(MAMapView *)mapView didAnnotationViewCalloutTapped:(MAAnnotationView *)view {
//    NSLog(@"您选中是我~");
//}




#pragma mark - set point and draw lines
//设置数组元素并且去执行画线操作
- (void)setPointArrWithCurrentUserLocation {
    //检查零点
    if (!self.currentUL){
        return;
    }
    
    CLLocationCoordinate2D clLocationCoordinate2D;
    clLocationCoordinate2D.latitude = self.latitu;
    clLocationCoordinate2D.longitude = self.longit;
    
    MAPointAnnotation *point = [[MAPointAnnotation alloc] init];
    point.coordinate = clLocationCoordinate2D;
    
    [self.pointArr addObject:point];
    
    [self addPointAndCircleView];
    //画线
    [self drawTrackingLine];
}

//绘制旅行路线
- (void)drawTrackingLine {
    MAMapPoint *pointArray = new MAMapPoint[self.pointArr.count];//创建一个结构体数组
    for(int index = 0; index < self.pointArr.count; index++) {
        MAPointAnnotation *locationUser = [[MAPointAnnotation alloc] init];
        locationUser = [self.pointArr objectAtIndex:index];
        MAMapPoint point = MAMapPointForCoordinate(locationUser.coordinate);
        pointArray[index] = point;
    }
    if (self.routeLine) {
        [self.mapView removeOverlay:self.routeLine];
    }
    self.routeLine = [MAPolyline polylineWithPoints:pointArray count:self.pointArr.count];
    if (nil != self.routeLine) {
        //将折线绘制在地图底图标注和兴趣点图标之下
        [self.mapView addOverlay:self.routeLine];
    }
    delete []pointArray;
}

#pragma mark - clear mapview
- (void)clearMapView {
    self.mapView.showsUserLocation = NO;
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    [self.mapView removeOverlays:self.mapView.overlays];
    
    self.mapView.delegate = nil;
}


#pragma mark - 判断当前坐标有没有在某个圆内
#pragma mark - 可将此功能与地理围栏相结合,地理围栏负责展示这片区域,此方法负责进行判断
/*
 @brief 判断一个位置是否在某一个位置某个范围内.
 @param currentCoor 当前位置或者是需要判定的位置
 @param attractionsCoor 判断的中心点位置
 @param radius 中心点位置半径,范围
 */
- (BOOL)distanceBetweenOfCurrentLocation:(CLLocationCoordinate2D)currentCoor attractionsLocation:(CLLocationCoordinate2D)attractionsCoor andRadius:(NSInteger)radius {
    BOOL ptInCircle = MACircleContainsCoordinate(currentCoor, attractionsCoor, radius);
    return ptInCircle;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)makeMenu{
    WJDropdownMenu *menu = [[WJDropdownMenu alloc]initWithFrame:CGRectMake(0, [MyController isIOS7], self.view.frame.size.width, 40)];
    [self.view addSubview:menu];
    menu.delegate = self;         //  设置代理
    self.menu = menu;
    menu.menuArrowStyle = menuArrowStyleSolid; //  旋转箭头的样式(空心箭头 or 实心箭头)
    menu.tableViewMaxHeight = 200;             //  tableView的最大高度(超过此高度就可以滑动显示)
    menu.menuButtonTag = 100;                  //  menu定义了一个tag值如果与本页面的其他button的值有冲突重合可以自定义设置
    menu.CarverViewColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];//设置遮罩层颜色
    menu.selectedColor = [MyController colorWithHexString:@"ff7854"];   //  选中的字体颜色
    menu.unSelectedColor = [MyController colorWithHexString:@"81889d"];//  未选中的字体颜色
    [self createAllMenuData];

}

- (void)createAllMenuData{
    NSArray *twoMenuTitleArray =  @[@"2017-05-16",@"皮卡丘"];
    //  创建第一个菜单的first数据second数据
    NSArray *firstArrOne = [NSArray arrayWithObjects:@"A一级菜单1",@"A一级菜单2",@"A一级菜单3", nil];
    NSArray *firstMenu = [NSArray arrayWithObject:firstArrOne];
    
    //  创建第二个菜单的first数据second数据
    NSArray *firstArrTwo = [NSArray arrayWithObjects:@"B一级菜单1",@"B一级菜单2", nil];
    NSArray *secondMenu = [NSArray arrayWithObjects:firstArrTwo, nil];
    
    [self.menu createTwoMenuTitleArray:twoMenuTitleArray FirstArr:firstMenu SecondArr:secondMenu];
}

- (void)hideMenu{
    [self.menu drawBackMenu];
}

#pragma mark -- 代理方法1 返回点击时对应的index
- (void)menuCellDidSelected:(NSInteger)MenuTitleIndex firstIndex:(NSInteger)firstIndex secondIndex:(NSInteger)secondIndex thirdIndex:(NSInteger)thirdIndex{
    NSLog(@"菜单数:%ld      一级菜单数:%ld      二级子菜单数:%ld  三级子菜单:%ld",MenuTitleIndex,firstIndex,secondIndex,thirdIndex);
    
};

#pragma mark -- 代理方法2 返回点击时对应的内容
- (void)menuCellDidSelected:(NSString *)MenuTitle firstContent:(NSString *)firstContent secondContent:(NSString *)secondContent thirdContent:(NSString *)thirdContent{
    
    NSLog(@"菜单title:%@       一级菜单:%@         二级子菜单:%@    三级子菜单:%@",MenuTitle,firstContent,secondContent,thirdContent);
    
    
    self.data = [NSMutableArray array];
    [self.data addObject:[NSString stringWithFormat:@"%@ 的 detail data 1",secondContent]];
    [self.data addObject:[NSString stringWithFormat:@"%@ 的 detail data 2",secondContent]];
    [self.data addObject:[NSString stringWithFormat:@"%@ 的 detail data 3",secondContent]];
    //    [self.tableView reloadData];
    
};

#pragma mark -- 代理方法3 返回点击时对应的内容和index(合并了方法1和方法2)
- (void)menuCellDidSelected:(NSString *)MenuTitle menuIndex:(NSInteger)menuIndex firstContent:(NSString *)firstContent firstIndex:(NSInteger)firstIndex secondContent:(NSString *)secondContent secondIndex:(NSInteger)secondIndex thirdContent:(NSString *)thirdContent thirdIndex:(NSInteger)thirdIndex{
    NSLog(@"菜单title:%@  titleIndex:%ld,一级菜单:%@    一级菜单Index:%ld,     二级子菜单:%@   二级子菜单Index:%ld   三级子菜单:%@  三级子菜单Index:%ld",MenuTitle,menuIndex,firstContent,firstIndex,secondContent,secondIndex,thirdContent,thirdIndex);
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

