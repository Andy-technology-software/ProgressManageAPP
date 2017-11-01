//
//  RegistrationDetail2TableViewCell.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/23.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "RegistrationDetail2TableViewCell.h"

#import "RegistrationDetail2Model.h"
@interface RegistrationDetail2TableViewCell()
@property (nonatomic, strong) UIView* bgView;
@property (nonatomic, strong) UIImageView* tempImageView;

@property (nonatomic, strong) UILabel* titleLable;

@property (nonatomic, strong) UIButton* checkBtn;
@end
@implementation RegistrationDetail2TableViewCell

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
    [self.contentView addSubview:self.bgView];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.top.mas_equalTo(0);
        make.height.mas_offset(125);
    }];
    
    self.titleLable = [MyController createLabelWithFrame:self.bgView.frame Font:14 Text:@"图片"];
    self.titleLable.textColor = [MyController colorWithHexString:@"8b91a4"];
    [self.bgView addSubview:self.titleLable];
    
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(0);
        make.height.mas_offset(43);
        make.width.mas_offset(69);
    }];
    
    self.tempImageView = [MyController createImageViewWithFrame:self.bgView.frame ImageName:nil];
    [self.bgView addSubview:self.tempImageView];
    
    [self.tempImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLable.mas_right);
        make.top.mas_equalTo(14);
        make.height.mas_offset(90);
        make.width.mas_offset(120);
    }];
    
    self.checkBtn = [MyController createButtonWithFrame:self.bgView.frame ImageName:nil Target:self Action:@selector(checkBtnClick) Title:nil];
    [self.bgView addSubview:self.checkBtn];
    
    [self.checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tempImageView);
        make.top.mas_equalTo(self.tempImageView);
        make.height.mas_equalTo(self.tempImageView);
        make.width.mas_equalTo(self.tempImageView);
    }];
    
    self.hyb_lastViewInCell = self.bgView;
    self.hyb_bottomOffsetToCell = 0;
}

- (void)configCellWithModel:(RegistrationDetail2Model *)model{
    [self.tempImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@""]];
}

- (void)checkBtnClick{
    [self.RegistrationDetail2TableViewCellDelegate sendBackCheckImage];
}
@end
