//
//  ChangePWTableViewCell.h
//  ProgressManage
//
//  Created by lingnet on 2017/5/25.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ChangePWTableViewCellDelegate <NSObject>
- (void)sendBackTextIndex:(NSInteger)index AndText:(NSString* )text;
@end
@interface ChangePWTableViewCell : UITableViewCell
- (void)configCellWithModel;
@property(nonatomic,weak)id<ChangePWTableViewCellDelegate>ChangePWTableViewCellDelegate;
@end
