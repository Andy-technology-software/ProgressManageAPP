//
//  SignInRecordTableViewCell.h
//  ProgressManage
//
//  Created by lingnet on 2017/5/27.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SignInRecordModel;
@protocol SignInRecordTableViewCellDelegate <NSObject>

- (void)sendBackSelectTime;
@end
@interface SignInRecordTableViewCell : UITableViewCell
- (void)configCellWithModel:(SignInRecordModel *)model;
@property(nonatomic,weak)id<SignInRecordTableViewCellDelegate>SignInRecordTableViewCellDelegate;

@end
