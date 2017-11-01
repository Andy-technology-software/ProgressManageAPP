//
//  SignInRecord1TableViewCell.h
//  ProgressManage
//
//  Created by lingnet on 2017/5/27.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SignInRecord1Model;
@protocol SignInRecord1TableViewCellDelegate <NSObject>

- (void)deleIndex:(NSInteger)cellIndex;
- (void)sendBackCheckImage:(NSInteger)cellIndex andSection:(NSInteger)cellSection;
@end
@interface SignInRecord1TableViewCell : UITableViewCell
- (void)configCellWithModel:(SignInRecord1Model *)model;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,assign)NSInteger cellSection;
@property(nonatomic,weak)id<SignInRecord1TableViewCellDelegate>SignInRecord1TableViewCellDelegate;

@end
