//
//  ChartPart0Model.h
//  ProgressManage
//
//  Created by lingnet on 2017/5/24.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChartPart0Model : NSObject
@property(nonatomic,copy)NSString* sTime;
@property(nonatomic,copy)NSString* eTime;
@property(nonatomic,assign)NSInteger selectIndex;
@property(nonatomic,strong)NSMutableArray* timeArr;

@end
