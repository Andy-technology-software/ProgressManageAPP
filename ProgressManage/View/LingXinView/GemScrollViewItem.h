//
//  GemScrollViewItem.h
//  ProgressManage
//
//  Created by Gem on 2017/5/4.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LingXinModel.h"

@interface GemScrollViewItem : UIView
@property (nonatomic,strong) LingXinModel *model;
- (instancetype)initWithFrame:(CGRect)frame;
@end
