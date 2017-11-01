//
//  FootprintDetailViewController.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/26.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "FootprintDetailViewController.h"

#import "KehuCustomAnnotationView.h"
@interface FootprintDetailViewController ()<MAMapViewDelegate,AMapLocationManagerDelegate,KehuCustomAnnotationViewDelegate>{
    MAMapView *_mapView;
}
@property (strong, nonatomic) MHDatePicker *selectDatePicker;

@property(nonatomic,strong)NSMutableArray* nameArr;
@property(nonatomic,strong)NSMutableArray* numArr;
@property(nonatomic,strong)NSMutableArray* dataSourceArr;
@property(nonatomic,strong)NSMutableArray* useridArr;
@property(nonatomic,strong)UIView* bgView;
@property(nonatomic,strong)UIScrollView * scrollView;

@property(nonatomic,strong)UILabel* subTitleLable;

@property(nonatomic,strong)AMapLocationManager* locationManager;

@property (nonatomic, strong) UIView* timeBgView;
@property (nonatomic, strong) UIImageView* timeImageView;
@property (nonatomic, strong) UILabel* timeLable;
@property (nonatomic, strong) UIImageView* timeRightImageView;
@property (nonatomic, strong) UIButton* timeBtn;
@property(nonatomic,copy)NSString* userId;
@property(nonatomic,assign)BOOL isOne;

@end

@implementation FootprintDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"足迹分布";
    [self makeView];
    [self makeTimeView];
    NSLog(@"---%@----%@",self.timeStr,self.userId);
    [requestService postZUJIFENBUWithSignDate:self.timeStr userId:@"" complate:^(id responseObject) {
        NSLog(@"%@",responseObject[@"data"]);
        if ([responseObject[@"result"] intValue]) {
            self.dataSourceArr = [[NSMutableArray alloc] init];
            self.nameArr = [[NSMutableArray alloc] init];
            self.numArr = [[NSMutableArray alloc] init];
            self.useridArr = [[NSMutableArray alloc] init];
            NSArray* dataArr = [MyController arraryWithJsonString:responseObject[@"data"]];
            if (dataArr.count) {
                for (NSDictionary* dicc in dataArr) {
                    NSLog(@"----%@",dicc);
                    NSArray* aa = dicc[@"singData"];
                    if (aa.count) {
                        NSArray* aaa = [NSArray arrayWithObject:[aa firstObject]];
                        [self.dataSourceArr addObjectsFromArray:aaa];
                        for (NSDictionary* dic in aaa) {
                            [self.nameArr addObject:dic[@"userName"]];
                            [self.useridArr addObject:dic[@"userId"]];
                        }
                    }
                }
                
            }else{
                [HUD warning:@"暂无足迹可查看"];
            }
        }else{
            [HUD warning:@"暂无足迹可查看"];
        }
        [self makeVView];
        [self makeScrollerView];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 创建左上角时间按钮
- (void)makeTimeView {
    self.timeBgView = [MyController viewWithFrame:self.view.frame];
    self.timeBgView.backgroundColor = [UIColor whiteColor];
    //将图层的边框设置为圆脚
    self.timeBgView.layer.cornerRadius = 9;
    self.timeBgView.layer.masksToBounds = YES;
    [self.timeBgView setContentMode:UIViewContentModeScaleAspectFill];
    self.timeBgView.clipsToBounds = YES;
    [self.view addSubview:self.timeBgView];
    
    [self.timeBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10 + [MyController isIOS7]);
        make.height.mas_offset(25);
        make.width.mas_offset(120);
    }];
    
    self.timeImageView = [MyController createImageViewWithFrame:self.timeBgView.frame ImageName:@"签到-日期"];
    [self.timeBgView addSubview:self.timeImageView];
    
    [self.timeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.top.mas_equalTo(5);
        make.height.mas_offset(15);
        make.width.mas_offset(15);
    }];
    
    self.timeLable = [MyController createLabelWithFrame:self.timeBgView.frame Font:12 Text:self.timeStr];
    [self.timeBgView addSubview:self.timeLable];
    
    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timeImageView.mas_right).mas_offset(3);
        make.top.mas_equalTo(0);
        make.height.mas_offset(25);
    }];
    
    self.timeRightImageView = [MyController createImageViewWithFrame:self.timeBgView.frame ImageName:@"二级下拉"];
    [self.timeBgView addSubview:self.timeRightImageView];
    
    [self.timeRightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timeLable.mas_right).mas_offset(3);
        make.top.mas_equalTo(5);
        make.height.mas_equalTo(self.timeImageView);
        make.width.mas_equalTo(self.timeImageView);
    }];
    
    self.timeBtn = [MyController createButtonWithFrame:self.timeBgView.frame ImageName:nil Target:self Action:@selector(timeSelect) Title:nil];
    [self.timeBgView addSubview:self.timeBtn];
    
    [self.timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(self.timeBgView);
    }];
}

#pragma mark - 左上角时间按钮响应
- (void)timeSelect{
    NSLog(@"选时间");
    self.isOne = NO;
    _selectDatePicker = [[MHDatePicker alloc] init];
    _selectDatePicker.isBeforeTime = YES;
    _selectDatePicker.datePickerMode = UIDatePickerModeDate;
    self.title = @"足迹分布";
    __weak typeof(self) weakSelf = self;
    [_selectDatePicker didFinishSelectedDate:^(NSDate *selectedDate) {
        self.timeStr = [weakSelf dateStringWithDate:selectedDate DateFormat:@"yyyy-MM-dd"];
        self.timeLable.text = self.timeStr;
        [self clearMapView];
        [requestService postZUJIFENBUWithSignDate:self.timeStr userId:@"" complate:^(id responseObject) {
            NSLog(@"%@",responseObject[@"data"]);
            if ([responseObject[@"result"] intValue]) {
                self.dataSourceArr = [[NSMutableArray alloc] init];
                self.nameArr = [[NSMutableArray alloc] init];
                self.numArr = [[NSMutableArray alloc] init];
                self.useridArr = [[NSMutableArray alloc] init];
                NSArray* dataArr = [MyController arraryWithJsonString:responseObject[@"data"]];
                if (dataArr.count) {
                    for (NSDictionary* dicc in dataArr) {
                        NSLog(@"----%@",dicc);
                        NSArray* aa = dicc[@"singData"];
                        if (aa.count) {
                            NSArray* aaa = [NSArray arrayWithObject:[aa firstObject]];
                            [self.dataSourceArr addObjectsFromArray:aaa];
                            for (NSDictionary* dic in aaa) {
                                [self.nameArr addObject:dic[@"userName"]];
                                [self.useridArr addObject:dic[@"userId"]];
                            }
                        }
                    }
                }else{
                    [HUD warning:@"暂无足迹可查看"];
                }
            }else{
                [HUD warning:@"暂无足迹可查看"];
            }
            
            [self makeVView];
            if (self.scrollView) {
                [self.scrollView removeFromSuperview];
                [self makeScrollerView];
            }
        } failure:^(NSError *error) {
            
        }];
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

#pragma mark - 设置当前位置
- (void)makeVView {
    CLLocationCoordinate2D commonPolylineCoords[self.dataSourceArr.count];
    for (int i = 0; i < self.dataSourceArr.count; i++) {
        NSDictionary* dic = self.dataSourceArr[i];
        commonPolylineCoords[i].latitude = [dic[@"lat"] floatValue];
        commonPolylineCoords[i].longitude = [dic[@"lon"] floatValue];
        
        if (!self.isOne) {
            [self.numArr addObject:[self.nameArr[i] substringToIndex:1]];
        }else{
            [self.numArr addObject:[NSString stringWithFormat:@"%d",i+1]];
        }
    }
    
    if (self.dataSourceArr.count) {
        //设置当前位置
        [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(commonPolylineCoords[0].latitude, commonPolylineCoords[0].longitude) animated:YES];
    }
    
    for (int i = 0; i < self.dataSourceArr.count; i++) {
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(commonPolylineCoords[i].latitude, commonPolylineCoords[i].longitude);
        pointAnnotation.title = [NSString stringWithFormat:@"%@",self.numArr[i]];
        [_mapView addAnnotation:pointAnnotation];
    }
}

#pragma mark - 获取当前时间  年月日
- (NSString*)getCurrentDay1 {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:date];
    return dateTime;
}

#pragma mark - 创建背景跟地图
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
        make.top.mas_equalTo(15 + [MyController isIOS7]);
        make.height.mas_offset([MyController getScreenHeight] - 30 - [MyController isIOS7]);
    }];
    
    _mapView = [[MAMapView alloc] initWithFrame:self.bgView.frame];
    [self.bgView addSubview:_mapView];
    [AMapServices sharedServices].enableHTTPS = YES;
//    _mapView.showsUserLocation = YES;
    _mapView.delegate = self;
//    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    _mapView.showsCompass = NO;
    _mapView.showsScale = NO;
    [_mapView setZoomLevel:15.10 animated:YES];
    
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(15);
        make.bottom.mas_equalTo(self.bgView.mas_bottom).mas_offset(-105);
    }];
}

#pragma mark - 大头针
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation {
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        KehuCustomAnnotationView *annotationView = (KehuCustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil) {
            annotationView = [[KehuCustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
            
        }
        annotationView.KehuCustomAnnotationViewDelegate = self;
        MAPointAnnotation* temAnn = (MAPointAnnotation*)annotation;
        
        annotationView.subTitleLable.text = temAnn.title;
        annotationView.image = [UIImage imageNamed:@"logotu"];
        
        annotationView.canShowCallout = NO;
        
        annotationView.centerOffset = CGPointMake(0, -18);
        
        self.subTitleLable = [MyController createLabelWithFrame:CGRectMake(0, 0, annotationView.frame.size.width, annotationView.frame.size.height - 7.5) Font:12 Text:annotationView.subTitleLable.text];
        self.subTitleLable.textAlignment = NSTextAlignmentCenter;
        self.subTitleLable.backgroundColor = [UIColor clearColor];
        self.subTitleLable.lineBreakMode = NSLineBreakByTruncatingTail;
        
        [annotationView addSubview:self.subTitleLable];
        return annotationView;
    }
    return nil;
}

- (void)sendBackSelect:(NSString *)str{
    NSLog(@"选中---%@",str);
}

#pragma mark - 创建滚动视图
- (void)makeScrollerView {
    float bgH = [MyController getScreenHeight] - 30 - [MyController isIOS7];
    float bgW = [MyController getScreenWidth] - 30;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(15, bgH - 105, bgW - 30, 105)];
    self.scrollView.contentSize = CGSizeMake(bgW * ceil(((float)self.nameArr.count / 4)), 105);
    self.scrollView.contentOffset = CGPointMake(0, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.scrollView.directionalLockEnabled = YES;
    self.scrollView.bounces = YES;
    self.scrollView.alwaysBounceHorizontal = YES;
    self.scrollView.alwaysBounceVertical = NO;
    self.scrollView.scrollEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    self.scrollView.decelerationRate = 0.5;
    [self.bgView addSubview: self.scrollView];
    
    float imageWidth = ([MyController getScreenWidth] - 15*3 - 60)/4;
    
    for (int i = 0; i < self.nameArr.count; i++) {
        UILabel* temLable = [MyController createLabelWithFrame:CGRectMake(((imageWidth + 15) * i), 15 , imageWidth, imageWidth) Font:18 Text:[self.nameArr[i] substringToIndex:1]];
        temLable.textColor = [UIColor whiteColor];
        temLable.backgroundColor = [MyController colorWithHexString:@"7588e4"];
        temLable.textAlignment = NSTextAlignmentCenter;
        temLable.layer.cornerRadius = imageWidth/2;
        temLable.layer.masksToBounds = YES;
        [temLable setContentMode:UIViewContentModeScaleAspectFill];
        temLable.clipsToBounds = YES;
        temLable.tag = 200 + i;
        [self.scrollView addSubview:temLable];
        
        UILabel* titleLable = [MyController createLabelWithFrame:CGRectMake(temLable.frame.origin.x, CGRectGetMaxY(temLable.frame), temLable.frame.size.width, 20) Font:14 Text:self.nameArr[i]];
        titleLable.textColor = [MyController colorWithHexString:TEXTCOLOR];
        titleLable.textAlignment = NSTextAlignmentCenter;
        [self.scrollView addSubview:titleLable];
        
        UIButton* temBtn = [MyController createButtonWithFrame:CGRectMake(temLable.frame.origin.x, temLable.frame.origin.y, temLable.frame.size.width, 105) ImageName:nil Target:self Action:@selector(temBtnClick:) Title:nil];
        temBtn.tag = 100 + i;
        [self.scrollView addSubview:temBtn];
    }
    
    UIImageView* leftIV = [MyController createImageViewWithFrame:self.bgView.frame ImageName:@"向左"];
//    leftIV.backgroundColor = [UIColor redColor];
    [self.bgView addSubview:leftIV];
    
    [leftIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_offset(bgH - 69);
        make.width.mas_offset(15);
        make.height.mas_offset(15);
    }];
    
    UIImageView* leftIV1 = [MyController createImageViewWithFrame:self.bgView.frame ImageName:@"向右"];
    [self.bgView addSubview:leftIV1];
    
    [leftIV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.top.mas_offset(bgH - 69);
        make.width.mas_offset(15);
        make.height.mas_offset(15);
    }];
}

#pragma mark - 选人按钮响应
- (void)temBtnClick:(UIButton*)btn{
    for (int i = 0; i < self.nameArr.count; i++) {
        UILabel* personLable = (UILabel*)[self.scrollView viewWithTag:i + 200];
        if ((100 + i) == btn.tag) {
            personLable.backgroundColor = [UIColor orangeColor];
        }else{
            personLable.backgroundColor = [MyController colorWithHexString:@"7588e4"];
        }
    }
    
    [self clearMapView];
    self.isOne = YES;
    self.title = [NSString stringWithFormat:@"%@的足迹",self.nameArr[btn.tag - 100]];
    self.userId = self.useridArr[btn.tag - 100];
    [requestService postZUJIFENBUWithSignDate:self.timeStr userId:self.userId complate:^(id responseObject) {
        NSLog(@"%@",responseObject[@"data"]);
        if ([responseObject[@"result"] intValue]) {
            self.dataSourceArr = [[NSMutableArray alloc] init];
            self.numArr = [[NSMutableArray alloc] init];
            NSArray* dataArr = [MyController arraryWithJsonString:responseObject[@"data"]];
            if (dataArr.count) {
                for (NSDictionary* dicc in dataArr) {
                    NSArray* aa = dicc[@"singData"];
                    [self.dataSourceArr addObjectsFromArray:aa];
                }
            }else{
                [HUD warning:@"暂无足迹可查看"];
            }
        }else{
            [HUD warning:@"暂无足迹可查看"];
        }
        [self makeVView];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - clear mapview
- (void)clearMapView {
    
    [_mapView removeAnnotations:_mapView.annotations];
    
    [_mapView removeOverlays:_mapView.overlays];
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
