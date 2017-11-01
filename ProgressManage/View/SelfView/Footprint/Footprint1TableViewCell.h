//
//  Footprint1TableViewCell.h
//  ProgressManage
//
//  Created by lingnet on 2017/5/26.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Footprint1Model;
@protocol Footprint1TableViewCellDelegate <NSObject>

- (void)sendBackGuiji;
@end
@interface Footprint1TableViewCell : UITableViewCell
- (void)configCellWithModel;
@property(nonatomic,weak)id<Footprint1TableViewCellDelegate>Footprint1TableViewCellDelegate;
@property(nonatomic,copy)NSString* jingdu;
@property(nonatomic,copy)NSString* weidu;
@end