//
//  SignInAddTableViewCell.h
//  ProgressManage
//
//  Created by lingnet on 2017/5/4.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SignInAddModel;
@protocol SignInAddTableViewCellDelegate <NSObject>

- (void)sendBackWeitiao;
- (void)sendBackQiandao;
- (void)sendBackKehuName:(NSString*)kehuName;
@end
@interface SignInAddTableViewCell : UITableViewCell
- (void)configCellWithModel:(SignInAddModel *)model;
@property(nonatomic,weak)id<SignInAddTableViewCellDelegate>SignInAddTableViewCellDelegate;

@end
