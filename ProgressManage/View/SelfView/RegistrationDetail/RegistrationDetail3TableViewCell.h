//
//  RegistrationDetail3TableViewCell.h
//  ProgressManage
//
//  Created by lingnet on 2017/5/23.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RegistrationDetail3Model;
@protocol RegistrationDetail3TableViewCellDelegate <NSObject>

- (void)sendBackCheckImage:(NSInteger)cellIndex;
@end
@interface RegistrationDetail3TableViewCell : UITableViewCell
- (void)configCellWithModel:(RegistrationDetail3Model *)model;
@property(nonatomic,assign)NSInteger cellIndex;
@property(nonatomic,weak)id<RegistrationDetail3TableViewCellDelegate>RegistrationDetail3TableViewCellDelegate;

@end
