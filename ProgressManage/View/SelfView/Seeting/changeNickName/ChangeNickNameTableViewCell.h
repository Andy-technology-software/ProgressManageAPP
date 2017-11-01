//
//  ChangeNickNameTableViewCell.h
//  ProgressManage
//
//  Created by lingnet on 2017/10/24.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import <UIKit/UIKit.h>
@class changeNickNameModel;
@protocol ChangeNickNameTableViewCellDelegate <NSObject>
- (void)sendBackNickName:(NSString* )text;
- (void)sendBackPhone:(NSString* )text;
@end
@interface ChangeNickNameTableViewCell : UITableViewCell
- (void)configCellWithModel:(changeNickNameModel*)model;
@property(nonatomic,weak)id<ChangeNickNameTableViewCellDelegate>ChangeNickNameTableViewCellDelegate;
@end