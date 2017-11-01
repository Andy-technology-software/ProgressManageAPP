//
//  ApplyTableViewCell.h
//  ProgressManage
//
//  Created by lingnet on 2017/5/27.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ApplyTableViewCellDelegate <NSObject>

- (void)sendIndex:(NSInteger)selectIndex AndText:(NSString*)text;
@end
@interface ApplyTableViewCell : UITableViewCell
- (void)configCellWithModel;
@property(nonatomic,weak)id<ApplyTableViewCellDelegate>ApplyTableViewCellDelegate;
@end
