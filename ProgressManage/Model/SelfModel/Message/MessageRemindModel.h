//
//  MessageRemindModel.h
//  WhereAreYou
//
//  Created by Gem on 2017/6/30.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageRemindModel : NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *subTitle;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *attNames;
@property (nonatomic,copy) NSString *attIDs;

@end
