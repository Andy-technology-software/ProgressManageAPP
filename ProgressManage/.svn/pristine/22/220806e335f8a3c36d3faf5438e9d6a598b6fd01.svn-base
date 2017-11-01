//
//  DailyTableViewCell.h
//  ProgressManage
//
//  Created by lingnet on 2017/5/15.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DailyModel;
@protocol DailyTableViewCellDelegate <NSObject>
- (void)sendBackTime:(NSString*)time;
@end
@interface DailyTableViewCell : UITableViewCell
- (void)configCellWithModel:(DailyModel *)model;
@property(nonatomic,weak)id<DailyTableViewCellDelegate>DailyTableViewCellDelegate;

@end
