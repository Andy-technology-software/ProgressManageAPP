//
//  ChartPartIndexTableViewCell.h
//  ProgressManage
//
//  Created by lingnet on 2017/5/25.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ChartPartIndexTableViewCellDelegate <NSObject>
- (void)sendBackSelectIndex:(NSInteger)index AndTitle:(NSString*)title;
@end
@interface ChartPartIndexTableViewCell : UITableViewCell
- (void)configCellWithModel;
@property(nonatomic,weak)id<ChartPartIndexTableViewCellDelegate>ChartPartIndexTableViewCellDelegate;
@end
