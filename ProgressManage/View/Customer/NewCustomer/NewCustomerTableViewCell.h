//
//  NewCustomerTableViewCell.h
//  ProgressManage
//
//  Created by lingnet on 2017/5/25.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewCustomerModel;
@protocol NewCustomerTableViewCellDelegate <NSObject>
- (void)sendBackName:(NSString*)name;
- (void)sendBackPhone:(NSString*)phone;
- (void)sendBackLXR:(NSString*)lxr;
- (void)sendBackType;
- (void)sendBackJibie;
@end

@interface NewCustomerTableViewCell : UITableViewCell
- (void)configCellWithModel:(NewCustomerModel *)model;
@property(nonatomic,weak)id<NewCustomerTableViewCellDelegate>NewCustomerTableViewCellDelegate;

@end
