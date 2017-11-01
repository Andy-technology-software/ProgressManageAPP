//
//  SelfHeadTableViewCell.h
//  ProgressManage
//
//  Created by lingnet on 2017/5/4.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SelfHeadModel;
@protocol selfCellDelegate <NSObject>

- (void)sendBackChangeIamge;
- (void)sendBackSelectNum:(NSInteger)seleIndex;
@end
@interface SelfHeadTableViewCell : UITableViewCell
- (void)configCellWithModel:(SelfHeadModel *)model;
@property(nonatomic,weak)id<selfCellDelegate>selfCellDelegate;

@end
