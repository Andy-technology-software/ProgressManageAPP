//
//  calenCollectionViewCell.h
//  CYHcalendar
//
//  Created by Macx on 16/3/25.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface calenCollectionViewCell : UICollectionViewCell

@property (nonatomic , strong)UILabel * numberlabel;
@property (nonatomic , strong)UILabel * Monthnumberlabel;

-(void)TodayLabel:(NSIndexPath *)indexPath  comp:(NSDateComponents *)comp  todaycomp:(NSDateComponents *)todaycomp  week_firsday_month:(NSInteger)week_firsday_month number:(NSString *)num todayNumBGcolor:(UIColor *)color;
-(void)TodayLabelindexPath:(NSIndexPath *)indexPath  comp:(NSDateComponents *)comp  todaycomp:(NSDateComponents *)todaycomp  week_firsday_month:(NSInteger)week_firsday_month number:(NSString *)num textcolor:(UIColor *)color;

//==================以下是月模式
- (void)MonthLabel:(NSIndexPath *)indexPath comp:(NSDateComponents *)comp  todaycomp:(NSDateComponents *)todaycomp number:(NSString *)num thisMonthNumBGcolor:(UIColor *)color;

- (void)MonthLabelindexPath:(NSIndexPath *)indexPath comp:(NSDateComponents *)comp  todaycomp:(NSDateComponents *)todaycomp number:(NSString *)num textcolor:(UIColor *)color;

- (void)MonthLabelthisMonthindexPath:(NSIndexPath *)indexPath comp:(NSDateComponents *)comp  todaycomp:(NSDateComponents *)todaycomp number:(NSString *)num labelcolor:(UIColor *)color;
@end
