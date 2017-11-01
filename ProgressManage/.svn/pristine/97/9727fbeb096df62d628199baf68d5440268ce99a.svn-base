//
//  Remind1TableViewCell.h
//  ProgressManage
//
//  Created by lingnet on 2017/5/27.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Remind1Model;
@protocol Remind1TableViewCellDelegate <NSObject>

- (void)sendIndex:(NSInteger)selectIndex;;
@end
@interface Remind1TableViewCell : UITableViewCell
- (void)configCellWithModel:(Remind1Model *)model;
@property(nonatomic,weak)id<Remind1TableViewCellDelegate>Remind1TableViewCellDelegate;

@end
