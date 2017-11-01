//
//  Footprint0TableViewCell.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/26.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "Footprint0TableViewCell.h"

#import "Footprint0Model.h"
@interface Footprint0TableViewCell()
@property (nonatomic, strong) UIView* nameBgView;
@property (nonatomic, strong) UIImageView* nameImageView;
@property (nonatomic, strong) UILabel* nameLable;
@property (nonatomic, strong) UIImageView* nameRightImageView;

@property (nonatomic, strong) UIView* timeBgView;
@property (nonatomic, strong) UIImageView* timeImageView;
@property (nonatomic, strong) UILabel* timeLable;
@property (nonatomic, strong) UIImageView* timeRightImageView;

@property (nonatomic, strong) UIButton* timeBtn;
@end
@implementation Footprint0TableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.contentView.backgroundColor = [MyController colorWithHexString:DEFAULTCOLOR];
    
    self.nameBgView = [MyController viewWithFrame:self.contentView.frame];
    self.nameBgView.backgroundColor = [UIColor whiteColor];
    //将图层的边框设置为圆脚
    self.nameBgView.layer.cornerRadius = 9;
    self.nameBgView.layer.masksToBounds = YES;
    [self.nameBgView setContentMode:UIViewContentModeScaleAspectFill];
    self.nameBgView.clipsToBounds = YES;
    [self.contentView addSubview:self.nameBgView];
    
    [self.nameBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
//        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(15);
        make.height.mas_offset(25);
    }];
    
    self.nameImageView = [MyController createImageViewWithFrame:self.nameBgView.frame ImageName:@"签到-当前企业"];
    [self.nameBgView addSubview:self.nameImageView];
    
    [self.nameImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(5);
        make.height.mas_offset(15);
        make.width.mas_offset(15);
    }];
    
    self.nameLable = [MyController createLabelWithFrame:self.nameBgView.frame Font:12 Text:nil];
    [self.nameBgView addSubview:self.nameLable];
    
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameImageView.mas_right).mas_offset(3);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(self.nameBgView);
    }];
    
    self.nameRightImageView = [MyController createImageViewWithFrame:self.nameBgView.frame ImageName:@""];
    [self.nameBgView addSubview:self.nameRightImageView];
    
    [self.nameRightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLable.mas_right).mas_offset(3);
        make.top.mas_equalTo(5);
        make.height.mas_offset(15);
        make.width.mas_offset(15);
    }];
    
    self.timeBgView = [MyController viewWithFrame:self.contentView.frame];
    self.timeBgView.backgroundColor = [UIColor whiteColor];
    //将图层的边框设置为圆脚
    self.timeBgView.layer.cornerRadius = 9;
    self.timeBgView.layer.masksToBounds = YES;
    [self.timeBgView setContentMode:UIViewContentModeScaleAspectFill];
    self.timeBgView.clipsToBounds = YES;
    [self.contentView addSubview:self.timeBgView];
    
    [self.timeBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameBgView);
//        make.right.mas_equalTo(self.nameBgView);
        make.top.mas_equalTo(self.nameBgView.mas_bottom).mas_offset(10);
        make.height.mas_offset(25);
    }];
    
    self.timeImageView = [MyController createImageViewWithFrame:self.timeBgView.frame ImageName:@"签到-日期"];
    [self.timeBgView addSubview:self.timeImageView];
    
    [self.timeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameImageView);
        make.top.mas_equalTo(5);
        make.height.mas_equalTo(self.nameImageView);
        make.width.mas_equalTo(self.nameImageView);
    }];
    
    self.timeLable = [MyController createLabelWithFrame:self.timeBgView.frame Font:12 Text:nil];
    [self.timeBgView addSubview:self.timeLable];
    
    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timeImageView.mas_right).mas_offset(3);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(self.nameLable);
    }];
    
    self.timeRightImageView = [MyController createImageViewWithFrame:self.timeBgView.frame ImageName:@"二级下拉"];
    [self.timeBgView addSubview:self.timeRightImageView];
    
    [self.timeRightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timeLable.mas_right).mas_offset(3);
        make.top.mas_equalTo(5);
        make.height.mas_equalTo(self.nameRightImageView);
        make.width.mas_equalTo(self.nameRightImageView);
    }];
    
    self.timeBtn = [MyController createButtonWithFrame:self.timeBgView.frame ImageName:nil Target:self Action:@selector(timeSelect) Title:nil];
    [self.timeBgView addSubview:self.timeBtn];
    
    [self.timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(self.timeBgView);
    }];
    
    self.hyb_lastViewInCell = self.timeBgView;
    self.hyb_bottomOffsetToCell = 15;
    
}

- (void)configCellWithModel:(Footprint0Model *)model{
    [self.nameBgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(self.nameRightImageView.mas_right).mas_offset(5);
        make.top.mas_equalTo(15);
        make.height.mas_offset(25);
    }];
    
    [self.timeBgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(self.timeRightImageView.mas_right).mas_offset(5);
        make.top.mas_equalTo(self.nameBgView.mas_bottom).mas_offset(10);
        make.height.mas_offset(25);
    }];
    
    self.hyb_lastViewInCell = self.timeBgView;
    self.hyb_bottomOffsetToCell = 15;
    
    self.nameLable.text = [NSString stringWithFormat:@"范围：%@",model.name];
    
    self.timeLable.text = model.time;

}

- (void)timeSelect{
    [self.Footprint0TableViewCellDelegate sendBackSelectTime];
}
@end
