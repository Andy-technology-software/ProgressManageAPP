//
//  NewCustomerTableViewCell.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/25.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "NewCustomerTableViewCell.h"

#import "NewCustomerModel.h"
@interface NewCustomerTableViewCell()<UITextFieldDelegate>
@property (nonatomic, strong) UIView* bgView;
@property (nonatomic, strong) UIView* lineView;

@property (nonatomic, strong) UIImageView* lImageView;
@property (nonatomic, strong) UIImageView* areaImageView;

@property (nonatomic, strong) UILabel* titleLable;
@property (nonatomic, strong) UILabel* contentLable;
@property (nonatomic, strong) UILabel* areaLable;
@end

@implementation NewCustomerTableViewCell
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
//    self.bgView.layer.cornerRadius = 6;
//    self.bgView.layer.masksToBounds = YES;
//    [self.bgView setContentMode:UIViewContentModeScaleAspectFill];
//    self.bgView.clipsToBounds = YES;
    [self.contentView addSubview:self.bgView];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(15);
        make.height.mas_offset(250);
    }];
    
    self.hyb_lastViewInCell = self.bgView;
    self.hyb_bottomOffsetToCell = 0;
}

- (void)configCellWithModel:(NewCustomerModel *)model{
    NSArray* titA = [[NSArray alloc] initWithObjects:@"客户名称：",@"客户类型：",@"客户级别：",@"联系人：",@"联系方式：", nil];
    NSArray* placeholderA = [[NSArray alloc] initWithObjects:@"请填写",@"请选择",@"请选择",@"请填写",@"请填写", nil];
    NSArray* leftArr = [NSArray arrayWithObjects:[MyController returnStr:model.name],[MyController returnStr:model.type],[MyController returnStr:model.jibie],[MyController returnStr:model.lxr],[MyController returnStr:model.phone], nil];
    
    for (int i = 0; i < titA.count; i++) {
        
        UILabel* tLbale = [MyController createLabelWithFrame:CGRectMake(15, 50 * i, 70, 50) Font:14 Text:titA[i]];
        tLbale.textColor = [MyController colorWithHexString:@"a7abba"];
        [self.bgView addSubview:tLbale];
        
        UITextField* rightTF = [MyController createTextFieldWithFrame:CGRectMake(CGRectGetMaxX(tLbale.frame) + 10, 50 * i, [MyController getScreenWidth] - 150, 50) placeholder:placeholderA[i] passWord:NO leftImageView:nil rightImageView:nil Font:13];
        rightTF.delegate = self;
        rightTF.tag = 200 + i;
        rightTF.text = leftArr[i];
        [self.bgView addSubview:rightTF];
        
        UIView* lineView = [MyController viewWithFrame:CGRectMake(15, 50 * (i + 1) - 0.5, [MyController getScreenWidth] - 60, 0.5)];
        lineView.backgroundColor = [MyController colorWithHexString:@"eeeff2"];
        [self.bgView addSubview:lineView];
        
        if (i == 1 || i == 2) {
            UIImageView* rImageView = [MyController createImageViewWithFrame:CGRectMake(CGRectGetMaxX(lineView.frame) - 20, 15 + (50 * i), 20, 20) ImageName:@"向右"];
            [self.bgView addSubview:rImageView];
            
            UIButton* temBtn = [MyController createButtonWithFrame:CGRectMake(0, 50 * i, [MyController getScreenWidth] - 60, 50) ImageName:nil Target:self Action:@selector(temBtnClick:) Title:nil];
            temBtn.tag = 100 + i;
            [self.bgView addSubview:temBtn];
        }
    }

}
- (void)temBtnClick:(UIButton*)btn{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder)
                                               to:nil
                                             from:nil
                                         forEvent:nil];
    
    if (101 == btn.tag) {
        [self.NewCustomerTableViewCellDelegate sendBackType];
    }else if (102 == btn.tag){
        [self.NewCustomerTableViewCellDelegate sendBackJibie];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (200 == textField.tag) {
        [self.NewCustomerTableViewCellDelegate sendBackName:textField.text];
    }else if (203 == textField.tag){
        [self.NewCustomerTableViewCellDelegate sendBackLXR:textField.text];
    }else if (204 == textField.tag){
        [self.NewCustomerTableViewCellDelegate sendBackPhone:textField.text];
    }
}

@end
