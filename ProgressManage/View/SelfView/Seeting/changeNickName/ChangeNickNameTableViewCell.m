//
//  ChangeNickNameTableViewCell.m
//  ProgressManage
//
//  Created by lingnet on 2017/10/24.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "ChangeNickNameTableViewCell.h"

#import "changeNickNameModel.h"
@interface ChangeNickNameTableViewCell()<UITextFieldDelegate>
@property (nonatomic, strong) UIView* bgView;

@property (nonatomic, strong) UIView* lineView;

@property (nonatomic, strong) UITextField* tf;
@property (nonatomic, strong) UILabel* titLable;

@property (nonatomic, strong) UITextField* tf1;
@property (nonatomic, strong) UILabel* titLable1;

@end
@implementation ChangeNickNameTableViewCell

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
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(15);
        make.height.mas_offset(45 * 2);
    }];
    
    self.titLable = [MyController createLabelWithFrame:self.bgView.frame Font:14 Text:@"昵称"];
    self.titLable.textColor = [MyController colorWithHexString:TEXTCOLOR];
    [self.bgView addSubview:self.titLable];
    
    [self.titLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(0);
        make.height.mas_offset(45);
        make.width.mas_offset(80);
    }];
    
    self.tf = [MyController createTextFieldWithFrame:self.bgView.frame placeholder:@"请填写昵称" passWord:NO leftImageView:nil rightImageView:nil Font:14];
    self.tf.delegate = self;
    self.tf.tag = 100;
    [self.bgView addSubview:self.tf];
    
    [self.tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titLable.mas_right).mas_offset(10);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-10);
        make.height.mas_offset(45);
    }];
    
    self.lineView = [MyController viewWithFrame:self.bgView.frame];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"d4d4d4"];
    [self.bgView addSubview:self.lineView];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self.titLable.mas_bottom);
        make.height.mas_offset(0.5);
        make.right.mas_offset(0);
    }];
    
    self.titLable1 = [MyController createLabelWithFrame:self.bgView.frame Font:14 Text:@"手机号"];
    self.titLable1.textColor = [MyController colorWithHexString:TEXTCOLOR];
    [self.bgView addSubview:self.titLable1];
    
    [self.titLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(self.lineView.mas_bottom);
        make.height.mas_offset(44.5);
        make.width.mas_offset(80);
    }];
    
    self.tf1 = [MyController createTextFieldWithFrame:self.bgView.frame placeholder:@"请填写手机号" passWord:NO leftImageView:nil rightImageView:nil Font:14];
    self.tf1.delegate = self;
    self.tf1.tag = 101;
    [self.bgView addSubview:self.tf1];
    
    [self.tf1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titLable1.mas_right).mas_offset(10);
        make.top.mas_equalTo(self.titLable1);
        make.right.mas_equalTo(-10);
        make.height.mas_offset(44.5);
    }];
    
    self.hyb_lastViewInCell = self.bgView;
    self.hyb_bottomOffsetToCell = 0;
}

- (void)configCellWithModel:(changeNickNameModel *)model{
    self.tf.text = model._nickName;
    
    self.tf1.text = model._phone;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (100 == textField.tag) {
        [self.ChangeNickNameTableViewCellDelegate sendBackNickName:textField.text];
    }else {
        [self.ChangeNickNameTableViewCellDelegate sendBackPhone:textField.text];
    }
    
    
}


@end
