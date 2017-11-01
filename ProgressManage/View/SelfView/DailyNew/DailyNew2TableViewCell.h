//
//  DailyNew2TableViewCell.h
//  ProgressManage
//
//  Created by lingnet on 2017/5/24.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DailyNew2Model;
@protocol DailyNew2TableViewCellDelegate <NSObject>
- (void)sendBackIsOn:(BOOL)isOn;
@end
@interface DailyNew2TableViewCell : UITableViewCell
- (void)configCellWithModel:(DailyNew2Model *)model;
@property(nonatomic,weak)id<DailyNew2TableViewCellDelegate>DailyNew2TableViewCellDelegate;
@end
