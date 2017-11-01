//
//  SelfBottomTableViewCell.h
//  ProgressManage
//
//  Created by lingnet on 2017/5/4.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SelfBottomTableViewCellDelegate <NSObject>
- (void)sendBackClickIndex:(NSInteger)clickIndex;
@end
@interface SelfBottomTableViewCell : UITableViewCell
- (void)configCellWithModel;
@property(nonatomic,weak)id<SelfBottomTableViewCellDelegate>SelfBottomTableViewCellDelegate;

@end
