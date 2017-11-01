//
//  Daily1TableViewCell.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/23.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "Daily1TableViewCell.h"

#import "Daily1Model.h"
@interface Daily1TableViewCell()
@property (nonatomic, strong) UIView* bgView;
@property (nonatomic, strong) UIView* lineView;

@property (nonatomic, strong) UIImageView* lImageView;
@property (nonatomic, strong) UIImageView* areaImageView;

@property (nonatomic, strong) UILabel* titleLable;
@property (nonatomic, strong) UILabel* contentLable;
@property (nonatomic, strong) UILabel* areaLable;
@end
@implementation Daily1TableViewCell

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
        make.top.mas_equalTo(10);
    }];
    
    self.lImageView = [MyController createImageViewWithFrame:self.bgView.frame ImageName:@"工作日报"];
    [self.bgView addSubview:self.lImageView];

    [self.lImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(20);
        make.height.mas_offset(18);
        make.width.mas_offset(18);
    }];
    
    self.titleLable = [MyController createLabelWithFrame:self.bgView.frame Font:14 Text:@"工作日报："];
    self.titleLable.textColor = [MyController colorWithHexString:@"81889d"];
    [self.bgView addSubview:self.titleLable];
    
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lImageView.mas_right).mas_offset(10);
        make.top.mas_equalTo(self.lImageView);
        make.right.mas_equalTo(-15);
    }];
    
    self.contentLable = [MyController createLabelWithFrame:self.bgView.frame Font:14 Text:nil];
    self.contentLable.numberOfLines = 0;
    self.contentLable.textColor = [MyController colorWithHexString:@"81889d"];
    [self.bgView addSubview:self.contentLable];
    
    [self.contentLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLable);
        make.top.mas_equalTo(self.titleLable.mas_bottom).mas_offset(20);
        make.right.mas_equalTo(self.titleLable);
    }];
    
    self.lineView = [MyController viewWithFrame:self.bgView.frame];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"eeeff2"];
    [self.bgView addSubview:self.lineView];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(self.contentLable.mas_bottom).mas_offset(20);
        make.height.mas_offset(0.5);
    }];
    
    self.areaImageView = [MyController createImageViewWithFrame:self.bgView.frame ImageName:@"获取位置"];
    [self.bgView addSubview:self.areaImageView];
    
    [self.areaImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lImageView);
        make.top.mas_equalTo(self.lineView.mas_bottom).mas_offset(20);
        make.height.mas_equalTo(self.lImageView);
        make.width.mas_equalTo(self.lImageView);
    }];
    
    self.areaLable = [MyController createLabelWithFrame:self.bgView.frame Font:14 Text:@"工作日报："];
    self.areaLable.textColor = [MyController colorWithHexString:@"4c89f0"];
    self.areaLable.numberOfLines = 0;
    [self.bgView addSubview:self.areaLable];
    
    [self.areaLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.areaImageView.mas_right).mas_offset(10);
        make.top.mas_equalTo(self.areaImageView);
        make.right.mas_equalTo(-15);
    }];
    
    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(self.areaLable.mas_bottom).mas_offset(20);
    }];
    
    self.hyb_lastViewInCell = self.bgView;
    self.hyb_bottomOffsetToCell = 20;
}

- (void)configCellWithModel:(Daily1Model *)model{
    self.contentLable.text = model.content;
    self.areaLable.text = model.location;
}

@end
