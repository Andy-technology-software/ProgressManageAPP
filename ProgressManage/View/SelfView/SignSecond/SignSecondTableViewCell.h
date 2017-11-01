//
//  SignSecondTableViewCell.h
//  ProgressManage
//
//  Created by lingnet on 2017/5/11.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SignSecondModel;
@protocol SignSecondTableViewCellDelegate <NSObject>

- (void)sendBackKehuName:(NSString*)name;

@end
@interface SignSecondTableViewCell : UITableViewCell
- (void)configCellWithModel:(SignSecondModel *)model;
@property(nonatomic,weak)id<SignSecondTableViewCellDelegate>SignSecondTableViewCellDelegate;

@end
