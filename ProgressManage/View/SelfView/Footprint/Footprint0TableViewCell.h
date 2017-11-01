//
//  Footprint0TableViewCell.h
//  ProgressManage
//
//  Created by lingnet on 2017/5/26.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Footprint0Model;
@protocol Footprint0TableViewCellDelegate <NSObject>

- (void)sendBackSelectTime;
@end
@interface Footprint0TableViewCell : UITableViewCell
- (void)configCellWithModel:(Footprint0Model *)model;
@property(nonatomic,weak)id<Footprint0TableViewCellDelegate>Footprint0TableViewCellDelegate;

@end
