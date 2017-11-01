//
//  SeetingTableViewCell.h
//  ProgressManage
//
//  Created by lingnet on 2017/5/25.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SeetingTableViewCellDelegate <NSObject>
- (void)sendBackSelectIndex:(NSInteger)index;
- (void)sendBackOut;

@end
@interface SeetingTableViewCell : UITableViewCell
- (void)configCellWithModel;
@property(nonatomic,weak)id<SeetingTableViewCellDelegate>SeetingTableViewCellDelegate;
@end
