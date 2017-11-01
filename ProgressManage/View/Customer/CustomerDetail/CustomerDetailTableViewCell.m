//
//  CustomerDetailTableViewCell.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/25.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "CustomerDetailTableViewCell.h"

#import "CustomerDetailModel.h"
@interface CustomerDetailTableViewCell()
@property (nonatomic, strong) UIView* bgView;
@property (nonatomic, strong) UIView* lineView;
@property (nonatomic, strong) UIView* lineView1;
@property (nonatomic, strong) UIView* lineView2;

@property (nonatomic, strong) UIImageView* vipImageView;

@property (nonatomic, strong) UILabel* nameLable;
@property (nonatomic, strong) UILabel* nameLable1;
@property (nonatomic, strong) UILabel* telLable;
@property (nonatomic, strong) UILabel* telLable1;
@property (nonatomic, strong) UILabel* jibieLable;
@property (nonatomic, strong) UILabel* jibieLable1;
@property (nonatomic, strong) UILabel* remarkLable;
@property (nonatomic, strong) UILabel* remarkLable1;
@end

@implementation CustomerDetailTableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.contentView.backgroundColor = [MyController colorWithHexString:DEFAULTCOLOR];
    
    self.bgView = [MyController viewWithFrame:self.contentView.frame];
    self.bgView.backgroundColor = [UIColor whiteColor];
    //将图层的边框设置为圆脚
    self.bgView.layer.cornerRadius = 6;
    self.bgView.layer.masksToBounds = YES;
    [self.bgView setContentMode:UIViewContentModeScaleAspectFill];
    self.bgView.clipsToBounds = YES;
    [self.contentView addSubview:self.bgView];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.top.mas_equalTo(0);
    }];
    
    self.nameLable = [MyController createLabelWithFrame:self.bgView.frame Font:14 Text:@"客户名称"];
    self.nameLable.textColor = [MyController colorWithHexString:@"81889d"];
    [self.bgView addSubview:self.nameLable];
    
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(15);
        make.width.mas_offset(69);
    }];
    
    self.nameLable1 = [MyController createLabelWithFrame:self.bgView.frame Font:13 Text:nil];
    self.nameLable1.textColor = [MyController colorWithHexString:@"9fa4b3"];
    self.nameLable1.numberOfLines = 0;
    [self.bgView addSubview:self.nameLable1];
    
    [self.nameLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLable.mas_right);
        make.right.mas_lessThanOrEqualTo(-30);
        make.top.mas_equalTo(self.nameLable);
    }];
    
    self.vipImageView = [MyController createImageViewWithFrame:self.bgView.frame ImageName:@"vip"];
    [self.bgView addSubview:self.vipImageView];
    
    [self.vipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLable1.mas_right);
        make.top.mas_equalTo(self.nameLable1);
        make.width.mas_offset(20);
        make.height.mas_offset(20);
    }];
    
    self.lineView = [MyController viewWithFrame:self.bgView.frame];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"eeeff2"];
    [self.bgView addSubview:self.lineView];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLable);
        make.top.mas_equalTo(self.nameLable1.mas_bottom).mas_offset(15);
        make.right.mas_equalTo(-12);
        make.height.mas_offset(0.5);
    }];
    
    self.telLable = [MyController createLabelWithFrame:self.bgView.frame Font:14 Text:@"电话"];
    self.telLable.textColor = [MyController colorWithHexString:@"81889d"];
    [self.bgView addSubview:self.telLable];
    
    [self.telLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLable);
        make.top.mas_equalTo(self.lineView.mas_bottom).mas_offset(15);
        make.width.mas_equalTo(self.nameLable);
    }];
    
    self.telLable1 = [MyController createLabelWithFrame:self.bgView.frame Font:13 Text:nil];
    self.telLable1.textColor = [MyController colorWithHexString:@"9fa4b3"];
    self.telLable1.numberOfLines = 0;
    [self.bgView addSubview:self.telLable1];
    
    [self.telLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLable1);
        make.right.mas_equalTo(-12);
        make.top.mas_equalTo(self.telLable);
    }];
    
    self.lineView1 = [MyController viewWithFrame:self.bgView.frame];
    self.lineView1.backgroundColor = [MyController colorWithHexString:@"eeeff2"];
    [self.bgView addSubview:self.lineView1];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lineView);
        make.top.mas_equalTo(self.telLable1.mas_bottom).mas_offset(15);
        make.right.mas_equalTo(self.lineView);
        make.height.mas_offset(0.5);
    }];
    
    self.jibieLable = [MyController createLabelWithFrame:self.bgView.frame Font:14 Text:@"客户级别"];
    self.jibieLable.textColor = [MyController colorWithHexString:@"81889d"];
    [self.bgView addSubview:self.jibieLable];
    
    [self.jibieLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.telLable);
        make.top.mas_equalTo(self.lineView1.mas_bottom).mas_offset(15);
        make.width.mas_equalTo(self.telLable);
    }];
    
    self.jibieLable1 = [MyController createLabelWithFrame:self.bgView.frame Font:13 Text:nil];
    self.jibieLable1.textColor = [MyController colorWithHexString:@"9fa4b3"];
    self.jibieLable1.numberOfLines = 0;
    [self.bgView addSubview:self.jibieLable1];
    
    [self.jibieLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.telLable1);
        make.right.mas_equalTo(self.telLable1);
        make.top.mas_equalTo(self.jibieLable);
    }];
    
    self.lineView2 = [MyController viewWithFrame:self.bgView.frame];
    self.lineView2.backgroundColor = [MyController colorWithHexString:@"eeeff2"];
    [self.bgView addSubview:self.lineView2];
    
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lineView1);
        make.top.mas_equalTo(self.jibieLable1.mas_bottom).mas_offset(15);
        make.right.mas_equalTo(self.lineView1);
        make.height.mas_equalTo(self.lineView1);
    }];
    
    self.remarkLable = [MyController createLabelWithFrame:self.bgView.frame Font:14 Text:@"备注"];
    self.remarkLable.textColor = [MyController colorWithHexString:@"81889d"];
    [self.bgView addSubview:self.remarkLable];
    
    [self.remarkLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.jibieLable);
        make.top.mas_equalTo(self.lineView2.mas_bottom).mas_offset(15);
        make.width.mas_equalTo(self.jibieLable);
    }];
    
    self.remarkLable1 = [MyController createLabelWithFrame:self.bgView.frame Font:13 Text:nil];
    self.remarkLable1.textColor = [MyController colorWithHexString:@"9fa4b3"];
    self.remarkLable1.numberOfLines = 0;
    [self.bgView addSubview:self.remarkLable1];
    
    [self.remarkLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.jibieLable1);
        make.right.mas_equalTo(self.jibieLable1);
        make.top.mas_equalTo(self.remarkLable);
    }];
    
    self.hyb_lastViewInCell = self.bgView;
    self.hyb_bottomOffsetToCell = 0;
}

- (void)configCellWithModel:(CustomerDetailModel *)model{
    self.nameLable1.text = model.name;
    self.telLable1.text = model.tel;
    self.jibieLable1.text = model.jibie;
    self.remarkLable1.text = model.remark;
    if (model.isVIP) {
        self.vipImageView.image = [UIImage imageNamed:@"vip"];
    }else{
        self.vipImageView.image = [UIImage imageNamed:@""];
    }
    
    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(self.remarkLable1.mas_bottom).mas_offset(15);
    }];
    
}

@end
