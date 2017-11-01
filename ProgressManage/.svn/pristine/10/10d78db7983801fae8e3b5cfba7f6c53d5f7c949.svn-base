//
//  calenCollectionViewCell.m
//  CYHcalendar
//
//  Created by Macx on 16/3/25.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "calenCollectionViewCell.h"
#import "monthCalenbarview.h"

@implementation calenCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        self.numberlabel = [[UILabel alloc] initWithFrame:self.bounds];
//        self.numberlabel.clipsToBounds = YES;
//        self.numberlabel.layer.cornerRadius = 25;
//        [self.contentView addSubview:self.numberlabel];
//        self.numberlabel.textAlignment = 1;
        
    }
    return self;
}

-(void)TodayLabel:(NSIndexPath *)indexPath  comp:(NSDateComponents *)comp  todaycomp:(NSDateComponents *)todaycomp  week_firsday_month:(NSInteger)week_firsday_month number:(NSString *)num todayNumBGcolor:(UIColor *)color{
    
    self.numberlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
    self.numberlabel.clipsToBounds = YES;
    self.numberlabel.layer.cornerRadius = 22.5;
    [self.contentView addSubview:self.numberlabel];
    self.numberlabel.textAlignment = 1;
   
    self.numberlabel.text = num;
    
    if (comp.year == todaycomp.year && todaycomp.month == comp.month && comp.day == todaycomp.day &&indexPath.row ==( week_firsday_month - 1 + comp.day + 7 ) ){
  
//        self.numberlabel.textColor = [UIColor greenColor];
        
        self.numberlabel.backgroundColor = color;
    }

}


-(void)TodayLabelindexPath:(NSIndexPath *)indexPath comp:(NSDateComponents *)comp todaycomp:(NSDateComponents *)todaycomp week_firsday_month:(NSInteger)week_firsday_month number:(NSString *)num textcolor:(UIColor *)color
{

    if (comp.year == todaycomp.year && todaycomp.month == comp.month && comp.day == todaycomp.day &&indexPath.row ==( week_firsday_month - 1 + comp.day + 7 ) ){
        
        self.numberlabel.textColor = color;
    }

}


//========================月模式============
- (void)MonthLabel:(NSIndexPath *)indexPath comp:(NSDateComponents *)comp  todaycomp:(NSDateComponents *)todaycomp number:(NSString *)num thisMonthNumBGcolor:(UIColor *)color
{
    self.Monthnumberlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    self.Monthnumberlabel.center = self.contentView.center;
    
    self.Monthnumberlabel.clipsToBounds = YES;
    self.Monthnumberlabel.layer.cornerRadius = 28.5;
    [self.contentView addSubview:self.Monthnumberlabel];
    self.Monthnumberlabel.textAlignment = 1;
    
    self.Monthnumberlabel.text = num;
    if ((indexPath.row + 1 - 4) == comp.month && comp.year == todaycomp.year&&comp.month==todaycomp.month && comp.day == todaycomp.day) {

//        self.Monthnumberlabel.textColor = [UIColor colorWithRed:0.6 green:0.8 blue:0.3 alpha:0.8];
        self.Monthnumberlabel.backgroundColor = color;
    }
    
    
}

- (void)MonthLabelindexPath:(NSIndexPath *)indexPath comp:(NSDateComponents *)comp todaycomp:(NSDateComponents *)todaycomp number:(NSString *)num textcolor:(UIColor *)color
{
    if ((indexPath.row + 1 - 4) == comp.month && comp.year == todaycomp.year&&comp.month==todaycomp.month && comp.day == todaycomp.day) {
 
        self.Monthnumberlabel.textColor = color;
        
//        self.Monthnumberlabel.backgroundColor = [UIColor colorWithRed:R green:G blue:B alpha:1];
    }

}



@end
