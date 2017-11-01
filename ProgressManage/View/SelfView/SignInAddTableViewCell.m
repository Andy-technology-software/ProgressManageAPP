//
//  SignInAddTableViewCell.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/4.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "SignInAddTableViewCell.h"

#import "SignInAddModel.h"

#import "RipplesView.h"
@interface SignInAddTableViewCell()<UITextFieldDelegate>
//d48a4e19d3e04be694d24798605803dd
@property (nonatomic, strong) UIView* bgView;
@property (nonatomic, strong) UIView* lineView;

@property (nonatomic, strong) UILabel* addLable;
@property (nonatomic, strong) UILabel* kfLable;
//@property (nonatomic, strong) UILabel* xsLable;
@property (nonatomic, strong) UILabel* duiLable;
@property (nonatomic, strong) UILabel* qdLable;
@property (nonatomic, strong) UILabel* qdtLable;
@property (nonatomic, strong) UILabel* weitiaoLable;

@property (nonatomic, strong) UITextField* kfTextfield;
@property (nonatomic, strong) UITextField* xsTextfield;

@property (nonatomic, strong) UIImageView* txlImageview;
@property (nonatomic, strong) UIImageView* weitiaoImageview;
@property (nonatomic, strong) UIImageView* qdImageview;
@property (nonatomic, strong) UIImageView* duiImageview;

@property (nonatomic, strong) UIButton* qdBtn;
@property (nonatomic, strong) UIButton* wtBtn;

//@property (nonatomic, strong) RipplesView* rippleView;
@end
@implementation SignInAddTableViewCell

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
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(0);
//        make.height.mas_offset(190);
    }];
    
    self.addLable = [[UILabel alloc] init];
    [self.bgView addSubview:self.addLable];
    self.addLable.numberOfLines = 0;
    self.addLable.font = [UIFont systemFontOfSize:14];
    
    [self.addLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_offset(40);
        make.top.mas_equalTo(0);
    }];

    [AMapServices sharedServices].enableHTTPS = YES;
    MAMapView *_mapView = [[MAMapView alloc] initWithFrame:self.contentView.frame];
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    _mapView.showsCompass = NO;
    _mapView.showsScale = NO;
    [_mapView setZoomLevel:15.6 animated:YES];
    [self.bgView addSubview:_mapView];
    
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.addLable);
        make.right.mas_equalTo(self.addLable);
        make.height.mas_offset(95);
        make.top.mas_equalTo(self.addLable.mas_bottom);
    }];
    
    self.weitiaoLable = [MyController createLabelWithFrame:self.contentView.frame Font:12 Text:@"位置微调"];
    self.weitiaoLable.textColor = [MyController colorWithHexString:ThemeColor];
    [self.contentView addSubview:self.weitiaoLable];
    
    [self.weitiaoLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_mapView.mas_right).mas_offset(-20);
        make.bottom.mas_equalTo(_mapView.mas_bottom).mas_offset(-5);
    }];
    
    self.weitiaoImageview = [MyController createImageViewWithFrame:self.contentView.frame ImageName:@"签到记录-足迹分布更多"];
    [self.contentView addSubview:self.weitiaoImageview];
    
    [self.weitiaoImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.weitiaoLable.mas_right).mas_offset(3);
        make.bottom.mas_equalTo(self.weitiaoLable);
        make.width.mas_offset(15);
        make.height.mas_offset(15);
    }];
    
    self.wtBtn = [MyController createButtonWithFrame:self.contentView.frame ImageName:nil Target:self Action:@selector(wtBtnClick) Title:nil];
    [self.contentView addSubview:self.wtBtn];
    
    [self.wtBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.addLable);
        make.right.mas_equalTo(self.addLable);
        make.top.mas_equalTo(self.addLable);
        make.bottom.mas_equalTo(_mapView.mas_bottom);
    }];
    
    
    self.kfLable = [[UILabel alloc] init];
    [self.bgView addSubview:self.kfLable];
    self.kfLable.numberOfLines = 1;
    self.kfLable.textColor = [MyController colorWithHexString:@"a5aab9"];
    self.kfLable.font = [UIFont systemFontOfSize:14];
    
    [self.kfLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.addLable);
        make.top.mas_equalTo(_mapView.mas_bottom).mas_offset(3);
        make.height.mas_offset(42);
        make.width.mas_offset(70);
    }];

    self.txlImageview = [MyController createImageViewWithFrame:self.contentView.frame ImageName:@""];
    [self.bgView addSubview:self.txlImageview];
    
    [self.txlImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.addLable);
        make.top.mas_equalTo(_mapView.mas_bottom).mas_offset(10);
        make.height.mas_offset(20);
        make.width.mas_offset(20);
    }];
    
    
    self.kfTextfield = [MyController createTextFieldWithFrame:self.contentView.frame placeholder:@"请输入" passWord:NO leftImageView:nil rightImageView:nil Font:14];
    self.kfTextfield.textColor = [MyController colorWithHexString:@"a5aab9"];
    self.kfTextfield.delegate = self;
    [self.bgView addSubview:self.kfTextfield];
    
    [self.kfTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.kfLable.mas_right);
        make.right.mas_equalTo(self.txlImageview.mas_left);
        make.height.mas_equalTo(self.kfLable);
        make.top.mas_equalTo(self.kfLable);
    }];
    
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(self.kfTextfield.mas_bottom).mas_offset(6);
    }];
    
//    self.rippleView = [[RipplesView alloc] initMinRadius:5 maxRadius:70];
//
//    self.rippleView.rippleCount = 4;
//    self.rippleView.rippleDuration = 4;
//    self.rippleView.backgroundColor = [UIColor clearColor];
//    self.rippleView.rippleColor = [UIColor clearColor];
//    self.rippleView.borderWidth = 3;
//    self.rippleView.borderColor = [MyController colorWithHexString:@"29a3ea"];
//    [self.rippleView startAnimation];
//    [self.contentView addSubview:self.rippleView];
//    [self.rippleView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_offset(70);
//        make.width.mas_offset(70);
//        make.top.mas_equalTo(self.bgView.mas_bottom).mas_offset(15 + 70);
//        make.centerX.mas_equalTo(self.contentView).mas_offset(35);
//    }];
    
    self.qdImageview = [MyController createImageViewWithFrame:self.contentView.frame ImageName:@"组-1"];
    self.qdImageview.backgroundColor = [MyController colorWithHexString:DEFAULTCOLOR];
    [self.contentView addSubview:self.qdImageview];
    //将图层的边框设置为圆脚
    self.qdImageview.layer.cornerRadius = 40;
    self.qdImageview.layer.masksToBounds = YES;
    [self.qdImageview setContentMode:UIViewContentModeScaleAspectFill];
    self.qdImageview.clipsToBounds = YES;

    
    [self.qdImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(120);
        make.width.mas_offset(120);
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.bgView.mas_bottom).mas_offset(20);
    }];
    
    
    self.qdLable = [MyController createLabelWithFrame:self.contentView.frame Font:16 Text:@"签到"];
    self.qdLable.textColor = [MyController colorWithHexString:@"27a5ea"];
    self.qdLable.textAlignment = NSTextAlignmentCenter;
//    self.qdLable.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.qdLable];
    
    [self.qdLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.qdImageview);
//        make.right.mas_equalTo(self.qdImageview);
//        make.top.mas_equalTo(self.qdImageview).mas_offset(20);
        make.centerY.mas_equalTo(self.qdImageview.mas_centerY).mas_offset(-20);
        make.centerX.mas_equalTo(self.qdImageview.mas_centerX).mas_offset(-3);
    }];
    
    self.qdtLable = [MyController createLabelWithFrame:self.contentView.frame Font:16 Text:[self getCurrentDay1]];
    self.qdtLable.textColor = [MyController colorWithHexString:@"27a5ea"];
    self.qdtLable.textAlignment = NSTextAlignmentCenter;
//    self.qdtLable.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.qdtLable];
    
    [self.qdtLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.qdLable);
//        make.right.mas_equalTo(self.qdLable);
        make.top.mas_equalTo(self.qdLable.mas_bottom).mas_offset(6);
        make.centerX.mas_equalTo(self.qdLable.mas_centerX);
    }];
    
    self.qdBtn = [MyController createButtonWithFrame:self.contentView.frame ImageName:nil Target:self Action:@selector(qdBtnClick) Title:nil];
    [self.contentView addSubview:self.qdBtn];
    
    [self.qdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.qdImageview);
        make.width.mas_equalTo(self.qdImageview);
        make.top.mas_equalTo(self.qdImageview);
        make.centerX.mas_equalTo(self.contentView);
    }];
    
    self.hyb_lastViewInCell = self.qdBtn;
    self.hyb_bottomOffsetToCell = 20;
    
}

-(void)configCellWithModel:(SignInAddModel *)model{
    self.addLable.text = model.add;
    self.kfLable.text = @"拜访客户";
    self.kfTextfield.text = model.kehu;
//    self.xsLable.text = @"销售";
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self.SignInAddTableViewCellDelegate sendBackKehuName:textField.text];
}

/**
 获取当前时间

 @return 返回时间
 */
- (NSString*)getCurrentDay1{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY年MM月dd日 HH:mm:ss"];
    NSString *dateTime = [formatter stringFromDate:date];
    return [[dateTime substringFromIndex:12] substringToIndex:5];
}

/**
 签到响应
 */
- (void)qdBtnClick{
    NSLog(@"签到");
    [self.SignInAddTableViewCellDelegate sendBackQiandao];
}

/**
 微调响应
 */
- (void)wtBtnClick{
    NSLog(@"微调");
    [self.SignInAddTableViewCellDelegate sendBackWeitiao];
}
@end
