
//
//  DailyTableViewCell.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/15.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "DailyTableViewCell.h"

#import "DailyModel.h"

#import "cyhCalenbarview.h"
@interface DailyTableViewCell()<getdataString>
@property (nonatomic, strong) UIView* bgView;
@property (nonatomic , strong)cyhCalenbarview * cyhcalenbar;
@property (nonatomic , copy)NSString * daydatestr;
@end
@implementation DailyTableViewCell

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
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(0);
        make.height.mas_offset(140);
    }];
    
    //初始化，如果日历小于120.0的高度将默认为120.0高度
    _cyhcalenbar = [[cyhCalenbarview alloc] initD_calenbarframe:CGRectMake(0, 10, [MyController getScreenWidth] - 20, 120)];
    _cyhcalenbar.backgroundColor = [UIColor clearColor];
    _cyhcalenbar.daydelegate = self;
    //注册使用
    [_cyhcalenbar daycalenbarviewNSdate];
    //日历背景颜色
    _cyhcalenbar.calenbarBGcolor = [UIColor clearColor];
    
    //星期排列背景颜色
    _cyhcalenbar.WeekBGcolor = [UIColor clearColor];
    
    //当天日期圆点颜色
    _cyhcalenbar.todayNumBGcolor = [MyController colorWithHexString:@"4c89f0"];
    
    //被选中的日期圆点颜色
    _cyhcalenbar.SelecNumBGcolor = [MyController colorWithHexString:@"4c89f0"];
    
    CGFloat R_5 = 235.0/255.0;
    CGFloat G_5 = 104.0/255.0;
    CGFloat B_5 = 89.0/255.0;
    //当天日期数字颜色
    _cyhcalenbar.todaytextColor = [UIColor colorWithRed:R_5 green:G_5 blue:B_5 alpha:1];
    
    [self.bgView addSubview:_cyhcalenbar.daycalenbarview];

    self.hyb_lastViewInCell = self.bgView;
    self.hyb_bottomOffsetToCell = 0;
}

- (void)configCellWithModel:(DailyModel *)model{
    
}

- (void)getDatestring:(NSString *)datestring {
    _daydatestr = datestring;
    NSLog(@"回调回来的日期:%@",_daydatestr);
    [self.DailyTableViewCellDelegate sendBackTime:_daydatestr];
}

@end
