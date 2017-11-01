//
//  GemScrollViewItem.m
//  ProgressManage
//
//  Created by Gem on 2017/5/4.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "GemScrollViewItem.h"
@interface GemScrollViewItem()
{
    UIView *bgView;
    UIImageView *headView;
    UILabel *name;
    UILabel *title;
    UILabel *message;
    UILabel *time;
    
    UIView *line;
}

@end
@implementation GemScrollViewItem


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createView];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)createView{
    bgView = [UIView new];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 5;
    bgView.clipsToBounds = YES;
    [self addSubview:bgView];
    
    headView = [UIImageView new];
    [bgView addSubview:headView];
    
    name = [MyController createLabelWithFrame:CGRectZero Font:14 Text:@""];
    name.lineBreakMode = NSLineBreakByTruncatingTail;
    [bgView addSubview:name];
    
    title = [MyController createLabelWithFrame:CGRectZero Font:12 Text:@""];
    title.textColor = [MyController colorWithHexString:@"81889d"];
    title.lineBreakMode = NSLineBreakByTruncatingTail;
    [bgView addSubview:title];
    
    
    message = [MyController createLabelWithFrame:CGRectZero Font:12 Text:@""];
    message.layer.cornerRadius = 9;
    message.clipsToBounds = YES;
    message.textAlignment = NSTextAlignmentCenter;
    message.textColor = [UIColor whiteColor];
    [bgView addSubview:message];
    
    time = [MyController createLabelWithFrame:CGRectZero Font:12 Text:@""];
    time.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:time];
    
    line = [[UIView alloc] init];
    line.backgroundColor = [MyController colorWithHexString:@"eeeeee"];
    [bgView addSubview:line];
    
}

- (void)setModel:(LingXinModel *)model{
    
    int padding = 10;
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(padding / 2);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-padding / 2);
    }];
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgView).offset(20);
        make.left.mas_equalTo(padding);
        make.width.mas_offset(40);
        make.height.mas_offset(40);
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headView.mas_top);
        make.left.mas_equalTo(headView.mas_right).mas_offset(padding);
        make.width.mas_offset(1);
        make.bottom.mas_equalTo(headView.mas_bottom);
    }];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_top);
        make.left.mas_equalTo(line.mas_right).mas_offset(padding);
        make.right.mas_equalTo(message.mas_left).mas_offset(-padding);
        //        make.bottom.mas_equalTo(title.mas_top).offset(-3);
    }];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(name.mas_bottom).offset(padding / 2);
        make.left.mas_equalTo(line.mas_right).mas_offset(padding);
        make.right.mas_equalTo(time.mas_left).mas_offset(-padding);
        make.bottom.mas_equalTo(headView.mas_bottom);
    }];
    [message mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_top);
        make.left.mas_equalTo(name.mas_right).mas_offset(padding);
        make.right.mas_equalTo(bgView.mas_right).mas_offset(-padding);
        make.bottom.mas_equalTo(name.mas_bottom);
        make.width.mas_offset(70);
        make.height.mas_offset(20);
    }];
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(title.mas_top);
        make.left.mas_equalTo(message.mas_left);
        make.right.mas_equalTo(message.mas_right);
        make.bottom.mas_equalTo(title.mas_bottom);
    }];
    

    
    name.text = model.name;
    title.text = model.title;
    message.text = model.message;
    time.text = model.time;
    
    if ([model.flag isEqualToString:@"0"]) {
        headView.image = [UIImage imageNamed:@"日报消息"];
        message.backgroundColor = [MyController colorWithHexString:@"4395E7"];
        message.text = @"日报消息";
    }else if ([model.flag isEqualToString:@"1"]){
        headView.image = [UIImage imageNamed:@"提醒消息"];
        message.backgroundColor = [MyController colorWithHexString:@"F34B33"];
        message.text = @"提醒消息";
    }else if ([model.flag isEqualToString:@"2"]){
        headView.image = [UIImage imageNamed:@"项目跟进"];
        message.backgroundColor = [MyController colorWithHexString:@"70B848"];
        message.text = @"项目跟进";

    }
}


@end
