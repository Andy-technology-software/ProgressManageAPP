//
//  CustomerDetailModel.h
//  ProgressManage
//
//  Created by lingnet on 2017/5/25.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomerDetailModel : NSObject
@property(nonatomic,copy)NSString* name;
@property(nonatomic,copy)NSString* tel;
@property(nonatomic,copy)NSString* jibie;
@property(nonatomic,copy)NSString* remark;
@property(nonatomic,assign)BOOL isVIP;

@end
