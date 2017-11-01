//
//  RegistrationListTableViewCell.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/22.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "RegistrationListTableViewCell.h"

#import "RegistrationListModel.h"
@interface RegistrationListTableViewCell()
@property (nonatomic, strong) UIView* bgView;
@property (nonatomic, strong) UIView* headView;
@property (nonatomic, strong) UIView* lineView;

@property (nonatomic, strong) UIImageView* typeImageView;

@property (nonatomic, strong) UILabel* headLable;
@property (nonatomic, strong) UILabel* titleLable;
@property (nonatomic, strong) UILabel* typeLable;
@property (nonatomic, strong) UILabel* startLable;
@property (nonatomic, strong) UILabel* sendLable;
@end
@implementation RegistrationListTableViewCell

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
//    self.bgView.layer.cornerRadius = 6;
//    self.bgView.layer.masksToBounds = YES;
//    [self.bgView setContentMode:UIViewContentModeScaleAspectFill];
//    self.bgView.clipsToBounds = YES;
    [self.contentView addSubview:self.bgView];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.top.mas_equalTo(0);
        make.height.mas_offset(115);
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
        make.top.mas_equalTo(15);
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
    
    self.sendLable = [MyController createLabelWithFrame:self.bgView.frame Font:10 Text:nil];
    self.sendLable.textColor = [MyController colorWithHexString:@"81889d"];
    self.sendLable.textAlignment = NSTextAlignmentRight;
    [self.bgView addSubview:self.sendLable];
    
    [self.sendLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(25);
    }];
    
    self.titleLable = [MyController createLabelWithFrame:self.bgView.frame Font:18 Text:nil];
    self.titleLable.numberOfLines = 1;
    [self.bgView addSubview:self.titleLable];
    
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headView.mas_right).mas_offset(6);
        make.right.mas_equalTo(self.sendLable.mas_left).mas_offset(-6);
        make.top.mas_equalTo(20);
    }];
    
    self.typeImageView = [MyController createImageViewWithFrame:self.bgView.frame ImageName:nil];
    [self.bgView addSubview:self.typeImageView];
    
    [self.typeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(self.sendLable.mas_bottom).mas_offset(6);
        make.width.mas_offset(60);
        make.height.mas_offset(60);
    }];
    
    self.typeLable = [MyController createLabelWithFrame:self.bgView.frame Font:14 Text:nil];
    self.typeLable.textColor = [MyController colorWithHexString:@"81889d"];
    [self.bgView addSubview:self.typeLable];
    
    [self.typeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLable);
        make.right.mas_equalTo(self.typeImageView.mas_left).mas_offset(-2);
        make.top.mas_equalTo(self.titleLable.mas_bottom).mas_offset(16);
    }];
    
    self.startLable = [MyController createLabelWithFrame:self.bgView.frame Font:14 Text:nil];
    self.startLable.textColor = [MyController colorWithHexString:@"81889d"];
    self.startLable.numberOfLines = 1;
    self.startLable.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.bgView addSubview:self.startLable];
    
    [self.startLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.typeLable);
        make.right.mas_equalTo(self.typeImageView.mas_left).mas_offset(-2);
        make.top.mas_equalTo(self.typeLable.mas_bottom).mas_offset(6);
    }];

    
    self.lineView = [MyController viewWithFrame:self.bgView.frame];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    [self.bgView addSubview:self.lineView];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(self.bgView.mas_bottom).mas_offset(-0.5);
        make.height.mas_offset(0.5);
    }];
    
    self.hyb_lastViewInCell = self.lineView;
    self.hyb_bottomOffsetToCell = 0;
}

- (void)configCellWithModel:(RegistrationListModel *)model{
    if ([MyController returnStr:model.userName].length) {
        self.headLable.text = [model.userName substringToIndex:1];
    }
    
    self.titleLable.text = model.userName;
    
    if (1 == [model.leaveType intValue]) {
        self.typeLable.text = [NSString stringWithFormat:@"请假类型：事假"];
    }else {
        self.typeLable.text = [NSString stringWithFormat:@"请假类型：病假"];
    }
    
    self.startLable.text = [NSString stringWithFormat:@"开始时间:%@",model.stime];
    
    self.sendLable.text = model.etime;
    
    //这个地方 图标需要判断
    if (1 == [model.state intValue]) {
        self.typeImageView.image = [UIImage imageNamed:@"待审批"];
    }else if (2 == [model.state intValue]) {
        self.typeImageView.image = [UIImage imageNamed:@"审批通过"];
    }else if (3 == [model.state intValue]) {
        self.typeImageView.image = [UIImage imageNamed:@"已拒绝"];
    }
    
}

@end
