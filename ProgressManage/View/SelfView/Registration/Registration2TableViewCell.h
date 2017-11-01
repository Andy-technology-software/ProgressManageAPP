//
//  Registration2TableViewCell.h
//  ProgressManage
//
//  Created by lingnet on 2017/5/22.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Registration2Model;
@protocol Registration2TableViewCellDelegate <NSObject>
- (void)sendBackCheckImage;
- (void)sendBackAddImage;
- (void)sendBackDelImage;
@end
@interface Registration2TableViewCell : UITableViewCell
- (void)configCellWithModel:(Registration2Model *)model;
@property(nonatomic,weak)id<Registration2TableViewCellDelegate>Registration2TableViewCellDelegate;
@end
