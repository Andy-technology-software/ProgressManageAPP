//
//  monthCalenbarview.h
//  CYHcalendar
//
//  Created by Macx on 16/3/28.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  获取当前月份协议
 */
@protocol monthdataString <NSObject>
/**
 *  获取当前月份
 *
 *  @param datestring <#datestring description#>
 */
- (void)getmonthString:(NSString *)datestring;

@end


//typedef void(^clearthisMonthcolor)(NSString *);
@interface monthCalenbarview : UIView

#pragma mark 以下是月日历部分
//================================================================
/**
 *  注册日历（按月计算）
 */
- (void)monthcalenbarviewNSdate;
/**
 *  按月计算日历方式
 */
@property (nonatomic , strong)monthCalenbarview * monthcalenbarview;

@property (nonatomic , strong)UILabel * Y_M_Dlabel;
@property (nonatomic , strong)NSMutableArray * datesource;
@property (nonatomic , assign)NSInteger  week_firsday_month;
@property (nonatomic , assign)NSInteger days;
@property (nonatomic , copy)NSString * weekstr;
@property (nonatomic , strong) NSDateComponents * comp ;
@property (nonatomic , assign)NSInteger offpage;//计算当天在第几页
@property (nonatomic , weak)id<monthdataString>monthdelegate;
//@property (nonatomic , copy)clearthisMonthcolor clearBlock;
/**
 *  日历背景颜色（按月计算）
 */
@property (nonatomic , strong)UIColor * McalenbarBGcolor;
/**
 *  被选中的月份圆点颜色
 */
@property (nonatomic , strong)UIColor * MSelecNumBGcolor;
/**
 *  当前月份圆点的背景颜色
 */
@property (nonatomic , strong)UIColor * thisMonthNumBGcolor;
/**
 *  当前月份数字颜色
 */
@property (nonatomic , strong)UIColor * thisMonthTextColor;
/**
 *  初始化日历（按月计算），如果日历小于120.0的高度将默认为120.0高度
 *
 *  @param frame 日历大小，位置
 *
 *  @return self
 */
-(id)initM_calenbarviewframe:(CGRect)frame;

@end
