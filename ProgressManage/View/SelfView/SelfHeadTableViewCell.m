//
//  SelfHeadTableViewCell.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/4.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "SelfHeadTableViewCell.h"

#import "SelfHeadModel.h"
@interface SelfHeadTableViewCell()
@property (nonatomic, strong) UIImageView* bgIV0;
@property (nonatomic, strong) UIImageView* bgIV;
@property (nonatomic, strong) UIImageView* headBgIV;
@property (nonatomic, strong) UIImageView* headIV;
@property (nonatomic, strong) UIImageView* photoIV;

@property (nonatomic, strong) UIButton* photoBtn;

@property (nonatomic, strong) UILabel* nameLable;
@property (nonatomic, strong) UILabel* cnameLable;

@property (nonatomic, strong) UIView* bottomView;
@end
@implementation SelfHeadTableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.backgroundColor = [UIColor clearColor];
    
    self.bgIV0 = [MyController createImageViewWithFrame:self.contentView.frame ImageName:@""];
    [self.contentView addSubview:self.bgIV0];
    
    [self.bgIV0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    
    self.bgIV = [[UIImageView alloc] init];
    [self.contentView addSubview:self.bgIV];
    [self.bgIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo([MyController getScreenWidth] * 58/64);
    }];
    
    self.headBgIV = [[UIImageView alloc] init];
    [self.contentView addSubview:self.headBgIV];
    [self.headBgIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(69);
        make.centerX.mas_equalTo(self.contentView);
        make.height.mas_offset(95);
        make.width.mas_offset(95);
    }];
    
    self.headIV = [[UIImageView alloc] init];
    [self.contentView addSubview:self.headIV];
    //将图层的边框设置为圆脚
    self.headIV.layer.cornerRadius = 43;
    self.headIV.layer.masksToBounds = YES;
    [self.headIV setContentMode:UIViewContentModeScaleAspectFill];
    self.headIV.clipsToBounds = YES;
    [self.headIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headBgIV).mas_offset(4.5);
        make.width.mas_offset(86);
        make.height.mas_offset(86);
        make.centerX.mas_equalTo(self.contentView);
    }];
    
    self.photoIV = [[UIImageView alloc] init];
    [self.contentView addSubview:self.photoIV];
    [self.photoIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.headBgIV);
        make.right.mas_equalTo(self.headBgIV);
        make.height.mas_offset(25);
        make.width.mas_offset(25);
    }];
    
    self.photoBtn = [MyController createButtonWithFrame:self.contentView.frame ImageName:nil Target:self Action:@selector(photoBtnClick) Title:nil];
    [self.contentView addSubview:self.photoBtn];
    [self.photoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headBgIV);
        make.right.mas_equalTo(self.headBgIV);
        make.top.mas_equalTo(self.headBgIV);
        make.bottom.mas_equalTo(self.headBgIV);
    }];
    
    self.cnameLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.cnameLable];
    self.cnameLable.textAlignment = NSTextAlignmentCenter;
    self.cnameLable.numberOfLines = 0;
    self.cnameLable.textColor = [MyController colorWithHexString:@"81889d"];
    self.cnameLable.font = [UIFont systemFontOfSize:14];
    
    [self.cnameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(self.headBgIV.mas_bottom).mas_offset(23);
        make.right.mas_equalTo(-10);
    }];
    
    self.nameLable = [[UILabel alloc] init];
    self.nameLable.text = @"";
    [self.contentView addSubview:self.nameLable];
    self.nameLable.textAlignment = NSTextAlignmentCenter;
    self.nameLable.textColor = [MyController colorWithHexString:@"4c89f0"];
    self.nameLable.numberOfLines = 0;
    self.nameLable.font = [UIFont systemFontOfSize:16];
    
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.cnameLable);
        make.top.mas_equalTo(self.cnameLable.mas_bottom).mas_offset(7.5);
        make.right.mas_equalTo(self.cnameLable);
    }];
    
    self.bottomView = [[UIView alloc] init];
    [self.contentView addSubview:self.bottomView];
    self.bottomView.alpha = 0.6;
    self.bottomView.backgroundColor = [MyController colorWithHexString:@"f9fbfb"];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.bgIV.mas_bottom).mas_offset(-65/2);
        make.height.mas_offset(150);
    }];
    
    float wid = ([MyController getScreenWidth] - 120) / 5;
    float wid1 = ([MyController getScreenWidth]) / 4;
    NSArray* imgaeArr = [[NSArray alloc] initWithObjects:@"签到",@"日报",@"统计",@"设置", nil];
    NSArray* imgaeArr1 = [[NSArray alloc] initWithObjects:@"我-签到",@"日报",@"统计",@"设置", nil];
    NSArray* imgaeArr12 = [[NSArray alloc] initWithObjects:@"我-签到-触发",@"日报-触发",@"统计-触发",@"设置-触发", nil];
    for (int i = 0; i < 4; i++) {
        
        UIButton* temBtn = [MyController createButtonWithFrame:CGRectMake(wid * (i + 1) + (30 * i), 10, 30, 30) ImageName:imgaeArr1[i] Target:self Action:@selector(temBtnClick:) Title:nil];
        temBtn.tag = 1000 + i;
        [temBtn setBackgroundImage:[UIImage imageNamed:imgaeArr12[i]] forState:UIControlStateHighlighted];
        [self.bottomView addSubview:temBtn];
        
        UILabel* titLable = [MyController createLabelWithFrame:CGRectMake(wid * (i + 1) + (30 * i), 38, 30, 30) Font:12 Text:imgaeArr[i]];
        titLable.textColor = [MyController colorWithHexString:@"969cac"];
        titLable.textAlignment = NSTextAlignmentCenter;
        [self.bottomView addSubview:titLable];
        
        UIButton* temBtn1 = [MyController createButtonWithFrame:CGRectMake(wid1 * i, 0, wid1, 65) ImageName:nil Target:self Action:@selector(temBtnClick:) Title:nil];
        temBtn1.tag = 1000 + i;
        [self.bottomView addSubview:temBtn1];
    }
    
    NSArray* imgaeArr2 = [[NSArray alloc] initWithObjects:@"外出",@"请假",@"审核", nil];
    NSArray* imgaeArr22 = [[NSArray alloc] initWithObjects:@"外出-触发",@"请假-触发",@"审核-触发", nil];
    for (int i = 0; i < 3; i++) {
        
        UIButton* temBtn = [MyController createButtonWithFrame:CGRectMake(wid * (i + 1) + (30 * i), 75, 30, 30) ImageName:imgaeArr2[i] Target:self Action:@selector(temBtnClick:) Title:nil];
        temBtn.tag = 1004 + i;
        [temBtn setBackgroundImage:[UIImage imageNamed:imgaeArr22[i]] forState:UIControlStateHighlighted];
        [self.bottomView addSubview:temBtn];
        
        UILabel* titLable = [MyController createLabelWithFrame:CGRectMake(wid * (i + 1) + (30 * i), 75 + 28, 30, 30) Font:12 Text:imgaeArr2[i]];
        titLable.textColor = [MyController colorWithHexString:@"969cac"];
        titLable.textAlignment = NSTextAlignmentCenter;
        [self.bottomView addSubview:titLable];
        
        UIButton* temBtn1 = [MyController createButtonWithFrame:CGRectMake(wid1 * i, 75, wid1, 65) ImageName:nil Target:self Action:@selector(temBtnClick:) Title:nil];
        temBtn1.tag = 1004 + i;
        [self.bottomView addSubview:temBtn1];
    }
    
    self.hyb_lastViewInCell = self.bottomView;
    self.hyb_bottomOffsetToCell = 0;
    
}
- (void)temBtnClick:(UIButton*)btn{
    [self.selfCellDelegate sendBackSelectNum:btn.tag - 1000];
}
- (void)photoBtnClick{
    NSLog(@"换头像");
    [self.selfCellDelegate sendBackChangeIamge];
}
-(void)configCellWithModel:(SelfHeadModel *)model{
    self.bgIV0.image = [UIImage imageNamed:@"图层-0"];
//    self.bgIV.image = [UIImage imageNamed:@"图层-0"];
    self.headBgIV.image = [UIImage imageNamed:@"头像"];
    self.photoIV.image = [UIImage imageNamed:@"头像修改"];
    [self.headIV sd_setImageWithURL:[NSURL URLWithString:model.headImage] placeholderImage:[UIImage imageNamed:@"我-默认头像"]];
    self.nameLable.text = model.name;
    self.cnameLable.text = model.cname;
}
@end
