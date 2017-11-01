//
//  ContactTableViewCell.h
//  ProgressManage
//
//  Created by Gem on 2017/5/25.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactModel.h"
@interface ContactTableViewCell : UITableViewCell
@property (nonatomic,strong) ContactModel *model;
+ (CGFloat)fixedHeight;
@end
