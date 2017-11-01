//
//  Registration3TableViewCell.h
//  ProgressManage
//
//  Created by lingnet on 2017/5/22.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Registration3Model;
@protocol Registration3TableViewCellDelegate <NSObject>
- (void)sendBackDel3:(NSInteger)index;
- (void)sendBackAdd3;
@end
@interface Registration3TableViewCell : UITableViewCell
- (void)configCellWithModel:(Registration3Model *)model;
@property(nonatomic,weak)id<Registration3TableViewCellDelegate>Registration3TableViewCellDelegate;
@end
