//
//  SignInRecord1TableViewCell.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/27.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "SignInRecord1TableViewCell.h"

#import "SignInRecord1Model.h"
@interface SignInRecord1TableViewCell()
@property (nonatomic, strong) UIView* bgView;
@property (nonatomic, strong) UIView* lineView;
@property (nonatomic, strong) UIView* lineView1;

@property (nonatomic, strong) UILabel* timeLable;
@property (nonatomic, strong) UILabel* addLable;
@property (nonatomic, strong) UILabel* addDetailLable;
@property (nonatomic, strong) UILabel* remarkLable;
@property (nonatomic, strong) UILabel* cNameLable;

@property (nonatomic, strong) UIImageView* rImageView;
@property (nonatomic, strong) UIImageView* cNameImageView;

@property (nonatomic, strong) UIButton* delBtn;

@property (nonatomic, strong) UIButton* checkBtn;

@end
@implementation SignInRecord1TableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.contentView.backgroundColor = [MyController colorWithHexString:DEFAULTCOLOR];
    
    self.lineView = [MyController viewWithFrame:self.contentView.frame];
    self.lineView.backgroundColor = [MyController colorWithHexString:LINECOLOR];
    [self.contentView addSubview:self.lineView];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_offset(4);
    }];
    
    self.timeLable = [MyController createLabelWithFrame:self.contentView.frame Font:12 Text:nil];
    self.timeLable.backgroundColor = [MyController colorWithHexString:@"4c89f0"];
    self.timeLable.textColor = [UIColor whiteColor];
    self.timeLable.textAlignment = NSTextAlignmentCenter;
    //将图层的边框设置为圆脚
    self.timeLable.layer.cornerRadius = 9;
    self.timeLable.layer.masksToBounds = YES;
    [self.timeLable setContentMode:UIViewContentModeScaleAspectFill];
    self.timeLable.clipsToBounds = YES;
    [self.contentView addSubview:self.timeLable];
    
    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.width.mas_offset(66);
        make.height.mas_offset(19);
    }];
    
    self.bgView = [MyController viewWithFrame:self.contentView.frame];
    self.bgView.backgroundColor = [UIColor whiteColor];
    //将图层的边框设置为圆脚
    self.bgView.layer.cornerRadius = 9;
    self.bgView.layer.masksToBounds = YES;
    [self.bgView setContentMode:UIViewContentModeScaleAspectFill];
    self.bgView.clipsToBounds = YES;
    [self.contentView addSubview:self.bgView];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timeLable.mas_right).mas_offset(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(0);
    }];
    
    self.delBtn = [MyController createButtonWithFrame:self.bgView.frame ImageName:@"" Target:self Action:@selector(delBtnClick) Title:nil];
    [self.bgView addSubview:self.delBtn];
    
    [self.delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(12);
        make.width.mas_offset(15);
        make.height.mas_offset(15);
    }];
    
    self.addLable = [MyController createLabelWithFrame:self.bgView.frame Font:14 Text:nil];
    self.addLable.numberOfLines = 0;
    self.addLable.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.bgView addSubview:self.addLable];
    
    [self.addLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.delBtn.mas_left).mas_offset(-5);
        make.top.mas_equalTo(self.delBtn);
        make.left.mas_equalTo(10);
    }];
    
    self.addDetailLable = [MyController createLabelWithFrame:self.bgView.frame Font:12 Text:nil];
    self.addDetailLable.textColor = [MyController colorWithHexString:TEXTCOLOR];
    self.addDetailLable.numberOfLines = 0;
    self.addDetailLable.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.bgView addSubview:self.addDetailLable];
    
    [self.addDetailLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.addLable.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self.addLable);
    }];
    
    self.lineView1 = [MyController viewWithFrame:self.bgView.frame];
    self.lineView1.backgroundColor = [MyController colorWithHexString:LINECOLOR];
    [self.bgView addSubview:self.lineView1];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.addDetailLable);
        make.top.mas_equalTo(self.addDetailLable.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self.addDetailLable);
        make.height.mas_offset(0.5);
    }];
    
    self.remarkLable = [MyController createLabelWithFrame:self.bgView.frame Font:14 Text:nil];
    self.remarkLable.textColor = [MyController colorWithHexString:@"a6abb9"];
    [self.bgView addSubview:self.remarkLable];
    
    [self.remarkLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.addDetailLable);
        make.right.mas_equalTo(self.addDetailLable);
        make.top.mas_equalTo(self.lineView1.mas_bottom).mas_offset(10);
    }];
    
    self.rImageView = [MyController createImageViewWithFrame:self.bgView.frame ImageName:nil];
    [self.bgView addSubview:self.rImageView];
    
    [self.rImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.remarkLable);
        make.top.mas_equalTo(self.remarkLable.mas_bottom).mas_offset(10);
        make.width.mas_offset(110);
        make.height.mas_offset(70);
    }];
    
    self.checkBtn = [MyController createButtonWithFrame:self.bgView.frame ImageName:nil Target:self Action:@selector(checkBtnClick:) Title:nil];
    [self.bgView addSubview:self.checkBtn];
    
    [self.checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.rImageView);
        make.top.mas_equalTo(self.rImageView);
        make.height.mas_equalTo(self.rImageView);
        make.width.mas_equalTo(self.rImageView);
    }];
    
    self.cNameImageView = [MyController createImageViewWithFrame:self.bgView.frame ImageName:@"拜访对象"];
    [self.bgView addSubview:self.cNameImageView];
    
    [self.cNameImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.rImageView);
        make.top.mas_equalTo(self.rImageView.mas_bottom).mas_offset(10);
        make.width.mas_offset(16);
        make.height.mas_offset(16);
    }];
    
    self.cNameLable = [MyController createLabelWithFrame:self.bgView.frame Font:14 Text:nil];
    self.cNameLable.textColor = [MyController colorWithHexString:@"a6abb9"];
    self.cNameLable.numberOfLines = 0;
    [self.bgView addSubview:self.cNameLable];
    
    [self.cNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.cNameImageView.mas_right).mas_offset(4);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.cNameImageView);
    }];
    
    self.hyb_lastViewInCell = self.bgView;
    self.hyb_bottomOffsetToCell = 10;
}

- (void)configCellWithModel:(SignInRecord1Model *)model{
    if (!model.image.length) {
        [self.rImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.remarkLable);
            make.top.mas_equalTo(self.remarkLable.mas_bottom).mas_offset(10);
            make.width.mas_offset(0);
            make.height.mas_offset(0);
        }];
        [self.rImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@""]];
        
        [self.checkBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.rImageView);
            make.top.mas_equalTo(self.rImageView);
            make.height.mas_equalTo(self.rImageView);
            make.width.mas_equalTo(self.rImageView);
        }];
    }else{
        [self.rImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.remarkLable);
            make.top.mas_equalTo(self.remarkLable.mas_bottom).mas_offset(10);
            make.width.mas_offset(110);
            make.height.mas_offset(70);
        }];
        [self.rImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@""]];
        
        [self.checkBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.rImageView);
            make.top.mas_equalTo(self.rImageView);
            make.height.mas_equalTo(self.rImageView);
            make.width.mas_equalTo(self.rImageView);
        }];
    }
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timeLable.mas_right).mas_offset(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(self.cNameLable).mas_offset(15);
    }];
    
    self.timeLable.text = [model.time substringFromIndex:10];
    self.addLable.text = model.addDetail;
    self.addDetailLable.text = model.add;
    self.remarkLable.text = model.remark;
    self.cNameLable.text = [NSString stringWithFormat:@"拜访对象：%@",model.cName];
    
}

- (void)delBtnClick{
//    [self.SignInRecord1TableViewCellDelegate deleIndex:self.index];
}

- (void)checkBtnClick:(UIButton*)btn{
    [self.SignInRecord1TableViewCellDelegate sendBackCheckImage:self.index andSection:self.cellSection];
}

@end
