//
//  Footprint21TableViewCell.h
//  ProgressManage
//
//  Created by lingnet on 2017/5/26.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Footprint21Model;
@protocol Footprint21TableViewCellDelegate <NSObject>

- (void)sendBackTixing;
@end
@interface Footprint21TableViewCell : UITableViewCell
- (void)configCellWithModel:(Footprint21Model *)model;
@property(nonatomic,weak)id<Footprint21TableViewCellDelegate>Footprint21TableViewCellDelegate;
@end
