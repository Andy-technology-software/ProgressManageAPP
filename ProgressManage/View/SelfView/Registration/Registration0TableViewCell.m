//
//  Registration0TableViewCell.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/22.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "Registration0TableViewCell.h"

#import "Registration0Model.h"
@interface Registration0TableViewCell()<UITextFieldDelegate>
@property (nonatomic, strong) UIView* bgView;

@end
@implementation Registration0TableViewCell

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
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.top.mas_equalTo(0);
        make.height.mas_offset(185);
    }];
    
    
    self.hyb_lastViewInCell = self.bgView;
    self.hyb_bottomOffsetToCell = 0;
}

- (void)configCellWithModel:(Registration0Model *)model{
    NSArray* leftArr;
    if (0 == [model.selfType intValue]) {
        leftArr = [[NSArray alloc] initWithObjects:@"外出类型",@"开始时间",@"结束时间",@"时长(天)", nil];
    }else {
        leftArr = [[NSArray alloc] initWithObjects:@"请假类型",@"开始时间",@"结束时间",@"时长(天)", nil];
    }
    NSArray* rightArr = [[NSArray alloc] initWithObjects:@"请选择",@"请选择",@"请选择",@"请填写", nil];
    for (int i = 0; i < 4; i++) {
        UILabel* leftLable = [MyController createLabelWithFrame:CGRectMake(15, 45 * i, 69, 45) Font:14 Text:leftArr[i]];
        leftLable.textAlignment = NSTextAlignmentLeft;
        leftLable.textColor = [MyController colorWithHexString:@"a6abb9"];
        [self.bgView addSubview:leftLable];
        
        UIView* lineView = [MyController viewWithFrame:CGRectMake(15, 45 * (i + 1) - 0.5, self.contentView.frame.size.width - 30 - 24, 0.5)];
        lineView.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
        [self.bgView addSubview:lineView];
        
        UITextField* rightTf = [MyController createTextFieldWithFrame:CGRectMake(CGRectGetMaxX(leftLable.frame), leftLable.frame.origin.y, self.contentView.frame.size.width - 30 - 120, 45) placeholder:rightArr[i] passWord:NO leftImageView:nil rightImageView:nil Font:14];
        rightTf.delegate = self;
        rightTf.keyboardType = UIKeyboardTypeNumberPad;
        rightTf.tag = 2000 + i;
        [self.bgView addSubview:rightTf];
        
        if (i < 3) {
            UIImageView* aa = [MyController createImageViewWithFrame:CGRectMake(CGRectGetMaxX(rightTf.frame), rightTf.frame.origin.y + 15, 15, 15) ImageName:@"向右"];
            [self.bgView addSubview:aa];
            
            UIButton* seleBtn = [MyController createButtonWithFrame:CGRectMake(0, 45 * i, self.bgView.frame.size.width, 45) ImageName:nil Target:self Action:@selector(seleBtnClick:) Title:nil];
            seleBtn.tag = 1000 + i;
            [self.bgView addSubview:seleBtn];
        }
    }
    
    UITextField* tf0 = (UITextField*)[self.bgView viewWithTag:2000];
    tf0.text = model.goType;
    
    UITextField* tf1 = (UITextField*)[self.bgView viewWithTag:2001];
    tf1.text = model.sTiem;
    
    UITextField* tf2 = (UITextField*)[self.bgView viewWithTag:2002];
    tf2.text = model.eTiem;
    
    UITextField* tf3 = (UITextField*)[self.bgView viewWithTag:2003];
    tf3.text = model.lTime;
}

- (void)seleBtnClick:(UIButton*)btn{
    [self.Registration0TableViewCellDelegate sendBackSelect:btn.tag - 1000 AndTime:@""];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self.Registration0TableViewCellDelegate sendBackSelect:3 AndTime:textField.text];
}
@end
