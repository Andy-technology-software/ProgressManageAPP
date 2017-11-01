//
//  ChartPart0TableViewCell.h
//  ProgressManage
//
//  Created by lingnet on 2017/5/24.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChartPart0Model;
@protocol ChartPart0TableViewCellDelegate <NSObject>
- (void)sendBackStartTime;
- (void)sendBackEndTime;
- (void)sendBackIndex:(NSInteger)selectIndex;
@end
@interface ChartPart0TableViewCell : UITableViewCell
- (void)configCellWithModel:(ChartPart0Model *)model;
@property(nonatomic,weak)id<ChartPart0TableViewCellDelegate>ChartPart0TableViewCellDelegate;
@end
