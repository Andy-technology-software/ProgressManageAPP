//
//  RegistrationDetail0TableViewCell.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/23.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "RegistrationDetail0TableViewCell.h"

#import "RegistrationDetail0Model.h"
@interface RegistrationDetail0TableViewCell()
@property (nonatomic, strong) UIView* bgView;
@property (nonatomic, strong) UIView* headView;
@property (nonatomic, strong) UIView* lineView;

@property (nonatomic, strong) UILabel* headLable;
@property (nonatomic, strong) UILabel* nameLable;
@property (nonatomic, strong) UILabel* stateLable;
@end
@implementation RegistrationDetail0TableViewCell

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
        make.height.mas_offset(71);
    }];
    
    self.headView = [MyController viewWithFrame:self.bgView.frame];
    self.headView.backgroundColor = [MyController randomColor];//[MyController colorWithHexString:@"bee099"];
    [self.bgView addSubview:self.headView];
    //将图层的边框设置为圆脚
    self.headView.layer.cornerRadius = 22;
    self.headView.layer.masksToBounds = YES;
    [self.headView setContentMode:UIViewContentModeScaleAspectFill];
    self.headView.clipsToBounds = YES;
    
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(12);
        make.height.mas_offset(44);
        make.width.mas_offset(44);
    }];
    
    self.headLable = [MyController createLabelWithFrame:self.bgView.frame Font:20 Text:nil];
    self.headLable.textAlignment = NSTextAlignmentCenter;
    self.headLable.textColor = [UIColor whiteColor];
    [self.bgView addSubview:self.headLable];
    
    [self.headLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headView);
        make.top.mas_equalTo(self.headView);
        make.height.mas_equalTo(self.headView);
        make.width.mas_equalTo(self.headView);
    }];
    
    self.nameLable = [MyController createLabelWithFrame:self.bgView.frame Font:16 Text:nil];
    self.nameLable.numberOfLines = 1;
    [self.bgView addSubview:self.nameLable];
    
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headView.mas_right).mas_offset(10);
        make.right.mas_equalTo(-6);
        make.top.mas_equalTo(20);
    }];
    
    self.stateLable = [MyController createLabelWithFrame:self.bgView.frame Font:12 Text:nil];
    self.stateLable.numberOfLines = 1;
    self.stateLable.textColor = [MyController colorWithHexString:@"ff8d71"];
    [self.bgView addSubview:self.stateLable];
    
    [self.stateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLable);
        make.right.mas_equalTo(self.nameLable);
        make.top.mas_equalTo(self.nameLable.mas_bottom).mas_offset(6);
    }];

    self.lineView = [MyController viewWithFrame:self.bgView.frame];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"eeeff2"];
    [self.bgView addSubview:self.lineView];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(self.bgView.mas_bottom).mas_offset(-0.5);
        make.height.mas_offset(0.5);
    }];
    
    self.hyb_lastViewInCell = self.bgView;
    self.hyb_bottomOffsetToCell = 0;
    
}

- (void)configCellWithModel:(RegistrationDetail0Model *)model{
    if ([MyController returnStr:model.name].length) {
        self.headLable.text = [model.name substringToIndex:1];
    }
    
    self.nameLable.text = model.name;
    
    self.stateLable.text = model.state;
}
@end
