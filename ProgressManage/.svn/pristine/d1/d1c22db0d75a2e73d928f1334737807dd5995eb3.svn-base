//
//  WeizhiViewController.m
//  WhereAreYou
//
//  Created by lingnet on 2017/6/10.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import "WeizhiViewController.h"

#import "CustomAnnotationView.h"
@interface WeizhiViewController ()<MAMapViewDelegate,AMapLocationManagerDelegate,WJMenuDelegate>{
    MAMapView *_mapView;
    int movingTimerInt;
    NSTimer* movingTimer;
    UIButton* huifangB;
    UIView* temView;
}
@property(nonatomic,strong)UIView* bgView;
@property(nonatomic,strong)UIScrollView * scrollView;
@property (nonatomic,weak)WJDropdownMenu *menu;
@property (nonatomic,strong)NSMutableArray *data;

@property(nonatomic,strong)NSMutableArray* positionArr;
@property(nonatomic,strong)NSMutableArray* jingduArr;
@property(nonatomic,strong)NSMutableArray* weiduArr;
@property(nonatomic,copy)NSString* perId;

@property(nonatomic,assign)BOOL isMoving;
@property(nonatomic,strong)NSMutableArray* temJingArr;
@property(nonatomic,strong)NSMutableArray* temWeiArr;

@property(nonatomic,assign)BOOL isFirstCome;
@end

@implementation WeizhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    
    self.title = @"轨迹";
    
    self.view.backgroundColor = [MyController colorWithHexString:@"ffffff"];
    
    self.isFirstCome = YES;
    
    if (self.isFromPerson) {
        self.perId = self.pId;
        self.nameArr = [[NSMutableArray alloc] init];
        self.idArr = [[NSMutableArray alloc] init];
        [self.nameArr addObject:self.pName];
        [self.idArr addObject:self.pId];
        [self makeScrollView];
        self.title = [NSString stringWithFormat:@"%@的轨迹",[self.nameArr firstObject]];
        self.perId = [self.idArr firstObject];
        [self getTrailWithUserid:self.perId andDate:[self getCurrentDay]];
    }else{
        [self getSubordinateWithUserId:[MyController getuserId]];
    }
    
    [self makeView];
    
    [self makeMenu];
}

- (void)makeMenu{
    WJDropdownMenu *menu = [[WJDropdownMenu alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    menu.delegate = self;         //  设置代理
    self.menu = menu;
    menu.menuArrowStyle = menuArrowStyleSolid; //  旋转箭头的样式(空心箭头 or 实心箭头)
    menu.tableViewMaxHeight = 200;             //  tableView的最大高度(超过此高度就可以滑动显示)
    menu.menuButtonTag = 100;                  //  menu定义了一个tag值如果与本页面的其他button的值有冲突重合可以自定义设置
    menu.CarverViewColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];//设置遮罩层颜色
    menu.selectedColor = [MyController colorWithHexString:@"ff7854"];   //  选中的字体颜色
    menu.unSelectedColor = [MyController colorWithHexString:@"81889d"];//  未选中的字体颜色
    [self.view addSubview:menu];
    [self createAllMenuData];
}

- (void)createAllMenuData{
    NSArray *threeMenuTitleArray =  @[@"今天"];
    //  创建第一个菜单的first数据second数据
    NSArray *firstArrOne = [NSArray arrayWithObjects:@"今天",@"昨天",@"前天", nil];
    NSArray *firstMenu = [NSArray arrayWithObject:firstArrOne];
    
    [self.menu createOneMenuTitleArray:threeMenuTitleArray FirstArray:firstMenu];
}

- (void)hideMenu{
    [self.menu drawBackMenu];
}



#pragma mark -- 代理方法1 返回点击时对应的index
- (void)menuCellDidSelected:(NSInteger)MenuTitleIndex firstIndex:(NSInteger)firstIndex secondIndex:(NSInteger)secondIndex thirdIndex:(NSInteger)thirdIndex{
    NSLog(@"菜单数:%ld      一级菜单数:%ld      二级子菜单数:%ld  三级子菜单:%ld",MenuTitleIndex,firstIndex,secondIndex,thirdIndex);
    if (!self.idArr.count) {
        [MyController HelpfulHints:@"暂无轨迹可查看" addView:self.view];
        return;
    }
    if (0 == firstIndex) {
        [self getTrailWithUserid:self.perId andDate:[self getCurrentDay]];
    }else if (1 == firstIndex){
        NSDate * date = [NSDate date];
        NSDate *lastDay = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:date];//前1天
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        NSString *dateTime = [formatter stringFromDate:lastDay];
        
        [self getTrailWithUserid:self.perId andDate:dateTime];
    }else if (2 == firstIndex){
        NSDate * date = [NSDate date];
        NSDate *lastDay = [NSDate dateWithTimeInterval:-24*60*60*2 sinceDate:date];//前2天
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        NSString *dateTime = [formatter stringFromDate:lastDay];
        
        [self getTrailWithUserid:self.perId andDate:dateTime];
    }
    
};

#pragma mark -- 代理方法2 返回点击时对应的内容
- (void)menuCellDidSelected:(NSString *)MenuTitle firstContent:(NSString *)firstContent secondContent:(NSString *)secondContent thirdContent:(NSString *)thirdContent{
    
    NSLog(@"菜单title:%@       一级菜单:%@         二级子菜单:%@    三级子菜单:%@",MenuTitle,firstContent,secondContent,thirdContent);
    
    
    self.data = [NSMutableArray array];
    [self.data addObject:[NSString stringWithFormat:@"%@ 的 detail data 1",secondContent]];
    [self.data addObject:[NSString stringWithFormat:@"%@ 的 detail data 2",secondContent]];
    [self.data addObject:[NSString stringWithFormat:@"%@ 的 detail data 3",secondContent]];
    
};

#pragma mark -- 代理方法3 返回点击时对应的内容和index(合并了方法1和方法2)
- (void)menuCellDidSelected:(NSString *)MenuTitle menuIndex:(NSInteger)menuIndex firstContent:(NSString *)firstContent firstIndex:(NSInteger)firstIndex secondContent:(NSString *)secondContent secondIndex:(NSInteger)secondIndex thirdContent:(NSString *)thirdContent thirdIndex:(NSInteger)thirdIndex{
    NSLog(@"菜单title:%@  titleIndex:%ld,一级菜单:%@    一级菜单Index:%ld,     二级子菜单:%@   二级子菜单Index:%ld   三级子菜单:%@  三级子菜单Index:%ld",MenuTitle,menuIndex,firstContent,firstIndex,secondContent,secondIndex,thirdContent,thirdIndex);
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
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(40);
        make.bottom.mas_equalTo(-100);
    }];
    
    [AMapServices sharedServices].enableHTTPS = YES;
    _mapView = [[MAMapView alloc] initWithFrame:self.view.frame];
    //    _mapView.showsUserLocation = YES;
    _mapView.delegate = self;
    //    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    _mapView.showsCompass = NO;
    _mapView.showsScale = NO;
    [_mapView setZoomLevel:15.10 animated:YES];
    [self.bgView addSubview:_mapView];
    
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    huifangB = [MyController createButtonWithFrame:self.bgView.frame ImageName:nil Target:self Action:@selector(huifangB:) Title:@"回放"];
    [huifangB setBackgroundColor:[MyController colorWithHexString:@"FFA500"]];
    [huifangB setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    huifangB.titleLabel.font = [UIFont systemFontOfSize:14];
    huifangB.layer.cornerRadius = 30;
    huifangB.layer.masksToBounds = YES;
    [huifangB setContentMode:UIViewContentModeScaleAspectFill];
    huifangB.clipsToBounds = YES;
    [self.bgView addSubview:huifangB];
    
    [huifangB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(10);
        make.height.mas_offset(60);
        make.width.mas_offset(60);
    }];
}

- (void)huifangB:(UIButton*)btn{
    self.temJingArr = [[NSMutableArray alloc] init];
    self.temWeiArr = [[NSMutableArray alloc] init];
    
    if (self.jingduArr.count) {
        btn.selected = !btn.selected;
        if (btn.selected) {
            NSLog(@"1");
            [huifangB setTitle:@"取消" forState:UIControlStateNormal];
            [_mapView setZoomLevel:12.20 animated:YES];
            [self.temJingArr removeAllObjects];
            [self.temWeiArr removeAllObjects];
            [self clearMapView];
            [self makeRoad];
            [_mapView setCenterCoordinate:CLLocationCoordinate2DMake([[self.weiduArr firstObject] floatValue], [[self.jingduArr firstObject] floatValue]) animated:YES];
            self.isMoving = YES;
            [movingTimer invalidate];
            movingTimer = nil;
            movingTimerInt = 0;
            [self makeMovingRoad];
        }else{
            NSLog(@"2");
            [huifangB setTitle:@"回放" forState:UIControlStateNormal];
            [_mapView setZoomLevel:15.10 animated:YES];
            [self.temJingArr removeAllObjects];
            [self.temWeiArr removeAllObjects];
            [self clearMapView];
            self.isMoving = NO;
            [movingTimer invalidate];
            movingTimer = nil;
            movingTimerInt = 0;
            [self makeRoad];
        }
        
    }else{
        [HUD warning:@"暂无轨迹"];
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

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation{
    if ([annotation isKindOfClass:[MAPointAnnotation class]]){
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        CustomAnnotationView *annotationView = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
            
        }
        //        annotationView.CustomAnnotationViewDelegate = self;
        MAPointAnnotation* temAnn = (MAPointAnnotation*)annotation;
        
        if ([temAnn.title isEqualToString:@"起"]) {
            annotationView.image = [UIImage imageNamed:@"起"];
        }else if ([temAnn.title isEqualToString:@"终"]){
            annotationView.image = [UIImage imageNamed:@"终"];
        }else{
            annotationView.image = [UIImage imageNamed:@""];
        }
        
        annotationView.canShowCallout = NO;
        
        annotationView.centerOffset = CGPointMake(0, -18);
        return annotationView;
    }
    return nil;
}


- (void)makeScrollView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [MyController getScreenHeight] - 90 - [MyController isIOS7], [MyController getScreenWidth], 90)];
    //给scrollview设置一个真正的大小，其实就是contentView的大小
    self.scrollView.contentSize = CGSizeMake([MyController getScreenWidth] * ceil(((float)self.nameArr.count / 4)), 90);
    //设置偏移量
    self.scrollView.contentOffset = CGPointMake(0, 0);
    //分页
    self.scrollView.pagingEnabled = YES;
    //设置额外空间 上 左 下 右`
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //锁定滑动方向
    self.scrollView.directionalLockEnabled = YES;
    //反弹效果
    self.scrollView.bounces = YES;
    //总是水平方向保持反弹效果
    self.scrollView.alwaysBounceHorizontal = YES;
    //总是垂直方向保持反弹效果
    self.scrollView.alwaysBounceVertical = NO;
    //开启滑动
    self.scrollView.scrollEnabled = YES;
    //显示水平状态条
    self.scrollView.showsHorizontalScrollIndicator = NO;
    //显示垂直状态条
    self.scrollView.showsVerticalScrollIndicator = NO;
    //状态条类型
    self.scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    //减速速率
    self.scrollView.decelerationRate = 0.5;
    [self.view addSubview: self.scrollView];
    
    
    float imageWidth = ([MyController getScreenWidth] - 240)/5;
    
    for (int i = 0; i < self.nameArr.count; i++) {
        temView = [MyController viewWithFrame:CGRectMake([MyController getScreenWidth] / 4 * i, 0 , [MyController getScreenWidth] / 4, 90)];
        [self.scrollView addSubview:temView];
        
        UILabel* temLable = [MyController createLabelWithFrame:CGRectMake(([MyController getScreenWidth] / 4 - 60) / 2, 0, 60, 60) Font:18 Text:[self.nameArr[i] substringToIndex:1]];
        if (self.isFirstCome) {
            temLable.backgroundColor = [UIColor orangeColor];
        }else{
            temLable.backgroundColor = [MyController colorWithHexString:@"7588e4"];
        }
        self.isFirstCome = NO;
        temLable.layer.cornerRadius = 30;
        temLable.layer.masksToBounds = YES;
        [temLable setContentMode:UIViewContentModeScaleAspectFill];
        temLable.clipsToBounds = YES;
        temLable.textColor = [UIColor whiteColor];
        temLable.textAlignment = NSTextAlignmentCenter;
        temLable.tag = 200 + i;
        [temView addSubview:temLable];
        
        UILabel* titleLable = [MyController createLabelWithFrame:CGRectMake(temLable.frame.origin.x, CGRectGetMaxY(temLable.frame), temLable.frame.size.width, 20) Font:14 Text:self.nameArr[i]];
        titleLable.textColor = [MyController colorWithHexString:TEXTCOLOR];
        titleLable.textAlignment = NSTextAlignmentCenter;
        [temView addSubview:titleLable];
        
        UIButton* temBtn = [MyController createButtonWithFrame:temView.frame ImageName:nil Target:self Action:@selector(temBtnClick:) Title:nil];
        temBtn.tag = 100 + i;
        [self.scrollView addSubview:temBtn];
    }
}

- (NSString*)getCurrentDay{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:date];
    return dateTime;
}

- (void)temBtnClick:(UIButton*)btn{
    NSLog(@"---%ld",btn.tag - 100);
    
    for (int i = 0; i < self.nameArr.count; i++) {
        UILabel* personLable = (UILabel*)[self.scrollView viewWithTag:i + 200];
        if ((100 + i) == btn.tag) {
            personLable.backgroundColor = [UIColor orangeColor];
        }else{
            personLable.backgroundColor = [MyController colorWithHexString:@"7588e4"];
        }
    }
    
    self.perId = self.idArr[btn.tag - 100];
    self.title = [NSString stringWithFormat:@"%@的轨迹",self.nameArr[btn.tag - 100]];
    [self getTrailWithUserid:self.perId andDate:[self getCurrentDay]];
    [self.menu removeFromSuperview];
    [self makeMenu];
}

//获取轨迹
- (void)getTrailWithUserid:(NSString*)userid andDate:(NSString*)date{
    [_mapView setZoomLevel:15.10 animated:YES];
    self.isMoving = NO;
    [movingTimer invalidate];
    movingTimer = nil;
    movingTimerInt = 0;
    huifangB.selected = NO;
    [huifangB setTitle:@"回放" forState:UIControlStateNormal];
    
    [HUD loading];
    [requestService postGetTrailWithUserid:userid date:date complate:^(id responseObject) {
        NSArray* posArr = [MyController arraryWithJsonString:responseObject[@"data"]];
        NSLog(@"经纬度数组:%@",posArr);
        [self clearMapView];
        self.positionArr = [NSMutableArray arrayWithArray:posArr];
        self.jingduArr = [[NSMutableArray alloc] init];
        self.weiduArr = [[NSMutableArray alloc] init];
        if (self.positionArr.count) {
            for (int i = 0; i < self.positionArr.count; i++) {
                NSDictionary* dic = self.positionArr[i];
                [self.jingduArr addObject:dic[@"lng"]];
                [self.weiduArr addObject:dic[@"lat"]];
            }
            [self makeRoad];
        }else{
            [MyController HelpfulHints:@"暂无轨迹" addView:self.view];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)makeRoad{
    //构造折线数据对象
    CLLocationCoordinate2D commonPolylineCoords[self.positionArr.count];
    
    for (int i = 0; i < self.positionArr.count; i++) {
        NSDictionary* dic = self.positionArr[i];
        commonPolylineCoords[i].latitude = [dic[@"lat"] floatValue];
        commonPolylineCoords[i].longitude = [dic[@"lng"] floatValue];
    }
    
    //构造折线对象
    MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:self.positionArr.count];
    
    //在地图上添加折线对象
    [_mapView addOverlay: commonPolyline];
    
    //设置当前位置
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(commonPolylineCoords[self.positionArr.count - 1].latitude, commonPolylineCoords[self.positionArr.count - 1].longitude) animated:YES];
    
    for (int i = 0; i < self.positionArr.count; i++) {
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(commonPolylineCoords[i].latitude, commonPolylineCoords[i].longitude);
        if (0 == i) {
            pointAnnotation.title = @"起";
        }
        
        if ((self.positionArr.count - 1) == i) {
            pointAnnotation.title = @"终";
        }
        
        [_mapView addAnnotation:pointAnnotation];
    }
}

- (void)movingTimer:(NSTimer*)t{
    [self.temJingArr addObject:self.jingduArr[movingTimerInt]];
    [self.temWeiArr addObject:self.weiduArr[movingTimerInt]];
    
    //构造折线数据对象
    CLLocationCoordinate2D commonPolylineCoords[self.temJingArr.count];
    
    for (int i = 0; i < self.temJingArr.count; i++) {
        commonPolylineCoords[i].latitude = [self.temWeiArr[i] floatValue];
        commonPolylineCoords[i].longitude = [self.temJingArr[i] floatValue];
    }
    
    //构造折线对象
    MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:self.temJingArr.count];
    
    //在地图上添加折线对象
    [_mapView addOverlay: commonPolyline];
    
    //设置当前位置
//    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(commonPolylineCoords[self.temJingArr.count - 1].latitude, commonPolylineCoords[self.temJingArr.count - 1].longitude) animated:YES];
    
    movingTimerInt++;
    if (self.jingduArr.count == movingTimerInt) {
        NSLog(@"这个地方动态路线加载完毕");
        [movingTimer invalidate];
        self.isMoving = NO;
    }
    
}

- (void)makeMovingRoad{
    self.isMoving = YES;
    movingTimer =  [NSTimer scheduledTimerWithTimeInterval:0.50 target:self selector:@selector(movingTimer:) userInfo:nil repeats:YES];
    [movingTimer setFireDate:[NSDate distantPast]];
    
}

#pragma mark - clear mapview
- (void)clearMapView {
    
    [_mapView removeAnnotations:_mapView.annotations];
    
    [_mapView removeOverlays:_mapView.overlays];
}

- (void)getSubordinateWithUserId:(NSString*)userid{
    [HUD loading];
    [requestService postGetSubordinateWithUserId:userid complate:^(id responseObject) {
        NSLog(@"员工列表：%@",[MyController arraryWithJsonString:responseObject[@"data"]]);
        NSArray* dataArr = [MyController arraryWithJsonString:responseObject[@"data"]];
        self.nameArr = [[NSMutableArray alloc] init];
        self.idArr = [[NSMutableArray alloc] init];
        self.temJingArr = [[NSMutableArray alloc] init];
        self.temWeiArr = [[NSMutableArray alloc] init];
        if (dataArr.count) {
            for (NSDictionary* dic in dataArr) {
                [self.nameArr addObject:dic[@"name"]];
                [self.idArr addObject:dic[@"id"]];
            }
            [self makeScrollView];
            self.title = [NSString stringWithFormat:@"%@的轨迹",[self.nameArr firstObject]];
            self.perId = [self.idArr firstObject];
            [self getTrailWithUserid:self.perId andDate:[self getCurrentDay]];
        }else{
//            [self.WeizhiViewControllerDelegate sendBackNoGuiji:YES];
//            [self.navigationController popViewControllerAnimated:YES];
            [MyController HelpfulHints:@"暂无轨迹可查看" addView:self.view];

        }
    } failure:^(NSError *error) {
        
    }];
}


- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay{
    if ([overlay isKindOfClass:[MAPolyline class]]){
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineRenderer.lineWidth    = 8.f;
        if (self.isMoving) {
            polylineRenderer.strokeColor  = [UIColor lightGrayColor];
        }else{
            polylineRenderer.strokeColor  = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.6];;
        }
        //        polylineRenderer.lineJoinType = kCALineJoinRound;
        //        polylineRenderer.lineCapType  = kMALineCapRound;
        
        return polylineRenderer;
    }
    return nil;
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
