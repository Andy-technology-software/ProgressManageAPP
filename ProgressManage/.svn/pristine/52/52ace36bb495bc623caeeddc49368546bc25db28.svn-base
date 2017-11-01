//
//  Footprint1TableViewCell.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/26.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "Footprint1TableViewCell.h"

#import "KehuCustomAnnotationView.h"
@interface Footprint1TableViewCell()<MAMapViewDelegate>{
    MAMapView *_mapView;
}
@property (nonatomic, strong) UIImageView* rImageview;
@property (nonatomic, strong) UILabel* titLable;

@property (nonatomic, strong) UIButton* seleBtn;

@property (nonatomic, strong) UIView* bgView;
@end
@implementation Footprint1TableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.backgroundColor = [MyController colorWithHexString:DEFAULTCOLOR];
    
    self.bgView = [MyController viewWithFrame:self.contentView.frame];
    self.bgView.backgroundColor = [UIColor whiteColor];
    //将图层的边框设置为圆脚
    self.bgView.layer.cornerRadius = 6;
    self.bgView.layer.masksToBounds = YES;
    [self.bgView setContentMode:UIViewContentModeScaleAspectFill];
    self.bgView.clipsToBounds = YES;
    [self.contentView addSubview:self.bgView];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(0);
        make.height.mas_offset(150);
    }];
    
    [AMapServices sharedServices].enableHTTPS = YES;
    _mapView = [[MAMapView alloc] initWithFrame:self.contentView.frame];
//    _mapView.showsUserLocation = NO;
//    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    _mapView.showsCompass = NO;
    _mapView.showsScale = NO;
    _mapView.delegate = self;
    [_mapView setZoomLevel:15.6 animated:YES];
    [self.bgView addSubview:_mapView];
    
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(15);
        make.bottom.mas_equalTo(-15);
    }];
    
    self.titLable = [MyController createLabelWithFrame:self.bgView.frame Font:14 Text:@"足迹分布"];
    [self.bgView addSubview:self.titLable];
    self.titLable.textAlignment = NSTextAlignmentRight;
    self.titLable.textColor = [MyController colorWithHexString:@"4c89f0"];
    
    [self.titLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_mapView.mas_right).mas_offset(-25);
        make.top.mas_equalTo(_mapView.mas_bottom).mas_offset(-30);
        make.height.mas_offset(30);
    }];
    
    self.rImageview = [MyController createImageViewWithFrame:self.contentView.frame ImageName:@"签到记录-足迹分布更多@2x.png"];
    [self.bgView addSubview:self.rImageview];
    
    [self.rImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titLable.mas_right).mas_offset(3);
        make.top.mas_equalTo(self.titLable).mas_offset(5);
        make.height.mas_offset(20);
        make.width.mas_offset(20);
    }];
    
    self.seleBtn = [MyController createButtonWithFrame:self.contentView.frame ImageName:nil Target:self Action:@selector(qdBtnClick) Title:nil];
    [self.bgView addSubview:self.seleBtn];
    
    [self.seleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView);
        make.right.mas_equalTo(self.bgView);
        make.top.mas_equalTo(self.bgView);
        make.height.mas_equalTo(self.bgView);
    }];
    
    self.hyb_lastViewInCell = self.bgView;
    self.hyb_bottomOffsetToCell = 0;
    
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        KehuCustomAnnotationView *annotationView = (KehuCustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[KehuCustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
            
        }
//        annotationView.KehuCustomAnnotationViewDelegate = self;
    
        annotationView.image = [UIImage imageNamed:@"logotu"];
        
        annotationView.canShowCallout = NO;
        
        annotationView.centerOffset = CGPointMake(0, -18);
    
        return annotationView;
    }
    return nil;
}

- (void)configCellWithModel{
    
    if ([MyController returnStr:self.weidu].length) {
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake([self.weidu floatValue], [self.jingdu floatValue]);
        pointAnnotation.title = @"";
        [_mapView addAnnotation:pointAnnotation];
        
        [_mapView setCenterCoordinate:CLLocationCoordinate2DMake([self.weidu floatValue], [self.jingdu floatValue]) animated:YES];
    }
    
}

- (void)qdBtnClick{
    [self.Footprint1TableViewCellDelegate sendBackGuiji];
}

@end
