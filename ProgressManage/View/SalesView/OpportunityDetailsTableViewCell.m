//
//  OpportunityDetailsTableViewCell.m
//  ProgressManage
//
//  Created by Gem on 2017/6/1.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "OpportunityDetailsTableViewCell.h"

@implementation OpportunityDetailsTableViewCell{
    UIView *_point;
    UIView *_bgView;
    UIView *_topView;
    UILabel *_title;
    UILabel *_content;
   
    
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
    _bgView = [UIView new];
    _bgView.backgroundColor = [UIColor whiteColor];
    
    _point = [UIView new];
    _point.backgroundColor = [MyController colorWithHexString:@"CBCED6"];
    _point.layer.cornerRadius = 2;
    _point.clipsToBounds = YES;
    
    _topView = [UIView new];
    _topView.backgroundColor = [MyController colorWithHexString:@"FCFCFC"];
    _topView.layer.cornerRadius = 5;
    _topView.clipsToBounds = YES;
    
    _title = [[UILabel alloc] init];
    _title.numberOfLines = 0;
    _title.textColor = [MyController colorWithHexString:@"abafbc"];
    _title.font = [UIFont systemFontOfSize:14];
    
    
    _content = [UILabel new];
    _content.textColor = [MyController colorWithHexString:@"abafbc"];
    _content.font = [UIFont systemFontOfSize:14];
    
    [_topView sd_addSubviews:@[_point,_title,_content]];
    
    [_bgView sd_addSubviews:@[_topView]];
    NSArray *views = @[_bgView];
    [self.contentView sd_addSubviews:views];
}

- (void)setModel:(OpportunityDetailsModel *)model{
    _title.text = model.title;
    _content.text = model.content;
    
    NSInteger space = 10;
     _bgView.sd_layout
    .leftSpaceToView(self.contentView,space)
    .topEqualToView(self.contentView)
    .rightSpaceToView(self.contentView,space)
   ;
    
    _topView.sd_layout
    .leftSpaceToView(_bgView,space)
    .topEqualToView(_bgView)
    .rightSpaceToView(_bgView,space)
    ;
    
    _title.sd_layout
    .leftSpaceToView(_topView,space + 10)
    .topSpaceToView(_topView,5)
    .widthIs(70)
    .heightIs(20);
    
    _point.sd_layout
    .leftSpaceToView(_topView, space)
    .centerYEqualToView(_title)
    .widthIs(4)
    .heightIs(4);
    
    _content.sd_layout
    .leftSpaceToView(_title,space)
    .topSpaceToView(_topView,5)
    .rightSpaceToView(_topView,space)
    .autoHeightRatio(0);
    
    //***********************高度自适应cell设置步骤************************
    if ([model.title isEqualToString:@"备注："]) {
        [_topView setupAutoHeightWithBottomView:_content bottomMargin:10];
    }else{
        [_topView setupAutoHeightWithBottomView:_content bottomMargin:0];
    }
    [_bgView setupAutoHeightWithBottomView:_topView bottomMargin:0];
    [self setupAutoHeightWithBottomView:_bgView bottomMargin:0];
 
    
}

@end
