//
//  DailyNew1TableViewCell.h
//  ProgressManage
//
//  Created by lingnet on 2017/5/24.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DailyNew1Model;
@protocol DailyNew1TableViewCellDelegate <NSObject>
- (void)sendBackAddPerson;
@end
@interface DailyNew1TableViewCell : UITableViewCell
- (void)configCellWithModel:(DailyNew1Model *)model;
@property(nonatomic,weak)id<DailyNew1TableViewCellDelegate>DailyNew1TableViewCellDelegate;
@end
