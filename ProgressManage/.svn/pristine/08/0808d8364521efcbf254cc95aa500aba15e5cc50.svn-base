//
//  SalesMessagesTableViewCell.m
//  ProgressManage
//
//  Created by Gem on 2017/5/31.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "SalesMessagesTableViewCell.h"

@implementation SalesMessagesTableViewCell{
    UIView *_topView;
    UILabel *_date;
    UILabel *_titleName;
    UILabel *_lable1;
    UILabel *_lable2;
    UIView *_line;
    UILabel *_money;
    UILabel *_remarks;
    UILabel *_time;
    UIButton *_deleate;
    UIImageView *_imageView;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //布局View
        self.backgroundColor = [UIColor clearColor];
        [self setUpView];
    }
    return self;
}

#pragma mark - setUpView
- (void)setUpView{
    _line = [UIView new];
    _line.backgroundColor = [MyController colorWithHexString:@"e2e4e8"];
    
    _topView = [UIView new];
    _topView.backgroundColor = [UIColor whiteColor];
    _topView.layer.cornerRadius = 5;
    _topView.clipsToBounds = YES;
    
    _date = [UILabel new];
    _date.textColor = [MyController colorWithHexString:@"81889d"];
    _date.backgroundColor = [UIColor whiteColor];
    _date.layer.cornerRadius = 25 / 2;
    _date.clipsToBounds = YES;
    _date.textAlignment = NSTextAlignmentCenter;
    _date.font = [UIFont systemFontOfSize:14];

    _titleName = [[UILabel alloc] init];
    _titleName.numberOfLines = 0;
    _titleName.font = [UIFont systemFontOfSize:14];
    _titleName.textColor = [MyController colorWithHexString:@"9298A9"];
    
    _money = [UILabel new];
    _money.font = [UIFont systemFontOfSize:14];
    _money.numberOfLines = 0;
    _money.textColor = [MyController colorWithHexString:@"9298A9"];
    
    _lable1 = [UILabel new];
    _lable1.font = [UIFont systemFontOfSize:14];
    _lable1.numberOfLines = 0;
    _lable1.textColor = [MyController colorWithHexString:@"9298A9"];
    
    
    _lable2 = [UILabel new];
    _lable2.font = [UIFont systemFontOfSize:14];
    _lable2.numberOfLines = 0;
    _lable2.textColor = [MyController colorWithHexString:@"9298A9"];

    _remarks = [UILabel new];
    _remarks.numberOfLines = 0;
    _remarks.font = [UIFont systemFontOfSize:14];
    _remarks.textColor = [MyController colorWithHexString:@"9298A9"];

    _time = [UILabel new];
    _time.layer.cornerRadius = 10;
    _time.clipsToBounds = YES;
    _time.backgroundColor = [MyController colorWithHexString:@"4c89f0"];
    _time.textColor = [UIColor whiteColor];
    _time.textAlignment = NSTextAlignmentCenter;
    _time.font = [UIFont boldSystemFontOfSize:14];
    
    _deleate = [UIButton new];
    [_deleate addTarget:self action:@selector(deleateAction:) forControlEvents:UIControlEventTouchUpInside];
    [_deleate setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
    
    _imageView = [UIImageView new];
    
    [_topView sd_addSubviews:@[_titleName,_money,_lable1,_lable2,_remarks,_deleate,_imageView]];
    NSArray *views = @[_line,_date,_time, _topView];
    [self.contentView sd_addSubviews:views];
}
- (void)deleateAction:(UIButton *)btn{
    [self.delegate removeCurrentRecord:self.index];
}
- (void)setModel:(SalesMessageModel *)model{
    NSInteger space = 10;
    
    _line.sd_layout
    .leftSpaceToView(self.contentView,40)
    .topEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .widthIs(3);
    
    _date.sd_layout
    .leftSpaceToView(self.contentView,space)
    .topSpaceToView(self.contentView, space)
    .widthIs(95)
    .heightIs(25);

    _time.sd_layout
    .centerXEqualToView(_line)
    .topSpaceToView(_date, space)
    .widthIs(60)
    .heightIs(20);
    
    _topView.sd_layout
    .leftSpaceToView(_time,15)
    .topEqualToView(_time)
    .rightSpaceToView(self.contentView,space);
    
    _titleName.sd_layout
    .leftSpaceToView(_topView,space * 1.5)
    .topSpaceToView(_topView,5)
    .rightSpaceToView(_deleate,space)
    .autoHeightRatio(0);

    _deleate.sd_layout
    .leftSpaceToView(_titleName,space)
    .topSpaceToView(_topView,5)
    .rightSpaceToView(_topView,space)
    .widthIs(15)
    .heightIs(15);
    
    _money.sd_layout
    .leftEqualToView(_titleName)
    .topSpaceToView(_titleName,5)
    .rightEqualToView(_titleName)
    .autoHeightRatio(0);
    
    _lable1.sd_layout
    .leftEqualToView(_titleName)
    .topSpaceToView(_money,5)
    .rightEqualToView(_titleName)
    .autoHeightRatio(0);
    
    _lable2.sd_layout
    .leftEqualToView(_titleName)
    .topSpaceToView(_lable1,5)
    .rightEqualToView(_titleName)
    .autoHeightRatio(0);
    
    if (model.sub2.length) {
        _remarks.sd_layout
        .leftEqualToView(_titleName)
        .topSpaceToView(_lable2,5)
        .rightEqualToView(_titleName)
        .autoHeightRatio(0);
    }else if (model.sub1.length){
        _remarks.sd_layout
        .leftEqualToView(_titleName)
        .topSpaceToView(_lable1,5)
        .rightEqualToView(_titleName)
        .autoHeightRatio(0);
    }else{
        _remarks.sd_layout
        .leftEqualToView(_titleName)
        .topSpaceToView(_money,5)
        .rightEqualToView(_titleName)
        .autoHeightRatio(0);
    }

    if (model.imageUrl.length) {
        _imageView.sd_layout
        .leftEqualToView(_remarks)
        .topSpaceToView(_remarks,space)
        .heightIs(60)
        .widthIs(80);
        [_topView setupAutoHeightWithBottomView:_imageView bottomMargin:5];

    }else{
        
        [_topView setupAutoHeightWithBottomView:_remarks bottomMargin:5];
    }
    //***********************高度自适应cell设置步骤************************
    
    [self setupAutoHeightWithBottomView:_topView bottomMargin:10];
    _titleName.text = model.titel;
    _money.text = model.money;
    _remarks.text = model.remarks;
    _time.text = model.time;
    _date.text = model.dates;
    _lable1.text = model.sub1;
    _lable2.text = model.sub2;
     [_imageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"拜访对象"]];
    
}

@end
