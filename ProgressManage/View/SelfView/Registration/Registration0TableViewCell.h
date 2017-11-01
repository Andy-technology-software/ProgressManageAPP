//
//  Registration0TableViewCell.h
//  ProgressManage
//
//  Created by lingnet on 2017/5/22.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Registration0Model;
@protocol Registration0TableViewCellDelegate <NSObject>
- (void)sendBackSelect:(NSInteger)index AndTime:(NSString*)lTime;
@end
@interface Registration0TableViewCell : UITableViewCell
- (void)configCellWithModel:(Registration0Model *)model;
@property(nonatomic,weak)id<Registration0TableViewCellDelegate>Registration0TableViewCellDelegate;
@end
