//
//  MessageRemindTableViewCell.m
//  WhereAreYou
//
//  Created by Gem on 2017/6/30.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import "MessageRemindTableViewCell.h"

@implementation MessageRemindTableViewCell{
    UILabel *title;
    UILabel *subtitle;
    UILabel *time;
    UILabel *content;
    UIView *flag;
    UIView *bgView;
    UIImageView *_flag;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createView];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)createView{
    
    flag = [UIView new];
    flag.backgroundColor = [MyController colorWithHexString:ThemeColor];
    
    title = [MyController createLabelWithFrame:CGRectZero Font:14 Text:@""];
    title.numberOfLines = 0;
    time = [MyController createLabelWithFrame:CGRectZero Font:12 Text:@""];
    time.textAlignment = NSTextAlignmentCenter;
    time.textColor = [MyController colorWithHexString:TintColor];
    time.backgroundColor = [MyController colorWithHexString:@"ececec"];
    ViewBorderRadius(time, 10, 0, [UIColor clearColor]);
    
    subtitle = [MyController createLabelWithFrame:CGRectZero Font:14 Text:@""];
    subtitle.numberOfLines = 0;

    content = [MyController createLabelWithFrame:CGRectZero Font:12 Text:@""];
    content.textColor = [MyController colorWithHexString:TintColor];
    content.numberOfLines = 0;
    
    _flag = [UIImageView new];
    _flag.image = [UIImage imageNamed:@"atta"];
    _flag.hidden = YES;

    bgView = [UIView new];
    ViewBorderRadius(bgView, 0, 0.5, [MyController colorWithHexString:TintColor]);
    bgView.backgroundColor = [UIColor whiteColor];
    
    [bgView sd_addSubviews:@[subtitle,content,_flag]];
    [self.contentView sd_addSubviews:@[flag,title,time,bgView]];

    int padding = 10;
    
    flag.sd_layout
    .topSpaceToView(self.contentView,padding * 2)
    .leftSpaceToView(self.contentView,padding * 2)
    .widthIs(padding)
    .heightIs(padding);
    ViewBorderRadius(flag, 5, 0, [UIColor clearColor]);
    
    title.sd_layout
    .topSpaceToView(flag,-14)
    .leftSpaceToView(flag,padding)
    .widthIs(SCREEN_WIDTH - 210)
    .autoHeightRatio(0);
    
    time.sd_layout
    .rightSpaceToView(self.contentView,padding)
    .centerYEqualToView(flag)
    .leftSpaceToView(title,padding)
    .heightIs(20)
    .widthIs(150);
    
    bgView.sd_layout
    .leftSpaceToView(self.contentView,padding)
    .rightSpaceToView(self.contentView,padding)
    .topSpaceToView(title,padding * 2)
    .autoHeightRatio(0);
    
    subtitle.sd_layout
    .topSpaceToView(bgView,padding * 2)
    .leftSpaceToView(bgView,padding)
    .rightSpaceToView(_flag,padding)
    .autoHeightRatio(0);
    
    _flag.sd_layout
    .rightSpaceToView(bgView,padding)
    .topSpaceToView(bgView,padding)
    .widthIs(20)
    .heightIs(20);
    
    content.sd_layout
    .topSpaceToView(subtitle,padding)
    .leftEqualToView(subtitle)
    .rightSpaceToView(bgView,padding)
    .autoHeightRatio(0);
    
    [bgView setupAutoHeightWithBottomView:content bottomMargin:padding * 2];
    [self setupAutoHeightWithBottomView:bgView bottomMargin:padding];
    
}

- (void)setModel:(MessageRemindModel *)model{
    
    title.text = @"通知";
    time.text = model.time;
    subtitle.text = model.subTitle;
    content.text = model.content;
    if (model.attIDs.length) {
        _flag.hidden = NO;
    }
}

@end
