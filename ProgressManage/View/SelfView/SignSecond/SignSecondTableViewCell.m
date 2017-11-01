//
//  SignSecondTableViewCell.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/11.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "SignSecondTableViewCell.h"

#import "SignSecondModel.h"
@interface SignSecondTableViewCell()<UITextFieldDelegate>
@property (nonatomic, strong) UIView* bgView;
@property (nonatomic, strong) UIView* lineView;
@property (nonatomic, strong) UIView* lineView1;

@property (nonatomic, strong) UILabel* timeLable;
@property (nonatomic, strong) UILabel* nameLable;
@property (nonatomic, strong) UILabel* addLable;

@property (nonatomic, strong) UITextField* nameTF;

@property (nonatomic, strong) UIImageView* timeImageview;
@property (nonatomic, strong) UIImageView* addImageview;
@property (nonatomic, strong) UIImageView* nameImageview;
@end
@implementation SignSecondTableViewCell

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
        make.top.mas_equalTo(15);
        make.height.mas_offset(120);
    }];
    
    self.timeImageview = [[UIImageView alloc] init];
    self.timeImageview.image = [UIImage imageNamed:@"签到-日期"];
    [self.bgView addSubview:self.timeImageview];
    
    [self.timeImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18);
        make.top.mas_equalTo(12);
        make.width.mas_offset(16);
        make.height.mas_offset(16);
    }];

    self.timeLable = [[UILabel alloc] init];
    [self.bgView addSubview:self.timeLable];
    self.timeLable.numberOfLines = 1;
    self.timeLable.font = [UIFont systemFontOfSize:14];
    
    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timeImageview.mas_right).mas_offset(6);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(0);
        make.height.mas_offset(40);
    }];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"eeeff2"];
    [self.bgView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timeImageview);
        make.right.mas_equalTo(self.timeLable);
        make.height.mas_offset(0.5);
        make.top.mas_equalTo(self.timeLable.mas_bottom);
    }];
    
    self.addImageview = [[UIImageView alloc] init];
    self.addImageview.image = [UIImage imageNamed:@"定位-触发"];
    [self.bgView addSubview:self.addImageview];
    
    [self.addImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timeImageview);
        make.top.mas_equalTo(self.lineView.mas_bottom).mas_offset(10);
        make.width.mas_equalTo(self.timeImageview);
        make.height.mas_equalTo(self.timeImageview);
    }];
    
    self.addLable = [[UILabel alloc] init];
    [self.bgView addSubview:self.addLable];
    self.addLable.numberOfLines = 1;
    self.addLable.font = [UIFont systemFontOfSize:14];
    
    [self.addLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timeLable);
        make.right.mas_equalTo(self.timeLable);
        make.top.mas_equalTo(self.lineView.mas_bottom);
        make.height.mas_equalTo(self.timeLable);
    }];
    
    self.lineView1 = [[UIView alloc] init];
    self.lineView1.backgroundColor = [MyController colorWithHexString:@"eeeff2"];
    [self.bgView addSubview:self.lineView1];
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lineView);
        make.right.mas_equalTo(self.lineView);
        make.height.mas_offset(0.5);
        make.top.mas_equalTo(self.addLable.mas_bottom);
    }];
    
    self.nameImageview = [[UIImageView alloc] init];
    self.nameImageview.image = [UIImage imageNamed:@"拜访对象"];
    [self.bgView addSubview:self.nameImageview];
    
    [self.nameImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.addImageview);
        make.top.mas_equalTo(self.lineView1.mas_bottom).mas_offset(10);
        make.width.mas_equalTo(self.addImageview);
        make.height.mas_equalTo(self.addImageview);
    }];
    
    self.nameLable = [[UILabel alloc] init];
    [self.bgView addSubview:self.nameLable];
    self.nameLable.numberOfLines = 1;
    self.nameLable.textColor = [MyController colorWithHexString:@"a7abba"];
    self.nameLable.font = [UIFont systemFontOfSize:14];
    
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.addLable);
//        make.right.mas_equalTo(self.addLable);
        make.width.mas_offset(74);
        make.top.mas_equalTo(self.lineView1.mas_bottom);
        make.height.mas_equalTo(self.addLable);
    }];
    
    self.nameTF = [MyController createTextFieldWithFrame:self.bgView.frame placeholder:@"请填写客户" passWord:NO leftImageView:nil rightImageView:nil Font:14];
    self.nameTF.delegate = self;
    [self.bgView addSubview:self.nameTF];
    
    [self.nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLable.mas_right);
        make.right.mas_equalTo(self.addLable);
        make.top.mas_equalTo(self.lineView1.mas_bottom);
        make.height.mas_equalTo(self.addLable);
    }];
    
    self.hyb_lastViewInCell = self.bgView;
    self.hyb_bottomOffsetToCell = 10;
}

- (void)configCellWithModel:(SignSecondModel *)model{
    self.timeLable.text = [NSString stringWithFormat:@"签到时间：%@",model.time];
    [MyController fuwenbenLabel:self.timeLable FontNumber:[UIFont systemFontOfSize:14] AndRange:NSMakeRange(0, 5) AndColor:[MyController colorWithHexString:@"a7abba"]];
    self.addLable.text = [NSString stringWithFormat:@"签到地点：%@",model.add];
    [MyController fuwenbenLabel:self.addLable FontNumber:[UIFont systemFontOfSize:14] AndRange:NSMakeRange(0, 5) AndColor:[MyController colorWithHexString:@"a7abba"]];
    self.nameLable.text = [NSString stringWithFormat:@"拜访客户："];
    self.nameTF.text = [MyController returnStr:model.name];
//    [MyController fuwenbenLabel:self.nameLable FontNumber:[UIFont systemFontOfSize:14] AndRange:NSMakeRange(0, 5) AndColor:[MyController colorWithHexString:@"a7abba"]];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self.SignSecondTableViewCellDelegate sendBackKehuName:textField.text];
}
@end
