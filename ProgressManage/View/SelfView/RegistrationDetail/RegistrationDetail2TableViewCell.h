//
//  RegistrationDetail2TableViewCell.h
//  ProgressManage
//
//  Created by lingnet on 2017/5/23.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RegistrationDetail2Model;
@protocol RegistrationDetail2TableViewCellDelegate <NSObject>

- (void)sendBackCheckImage;
@end
@interface RegistrationDetail2TableViewCell : UITableViewCell
- (void)configCellWithModel:(RegistrationDetail2Model *)model;
@property(nonatomic,weak)id<RegistrationDetail2TableViewCellDelegate>RegistrationDetail2TableViewCellDelegate;

@end
