//
//  PersonalInfoModel.h
//  WhereAreYou
//
//  Created by Gem on 2017/6/30.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonalInfoModel : NSObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *position;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *telephone;
@property (nonatomic,copy) NSString *emails;
@property (nonatomic,copy) NSString *locateState;
@property (nonatomic,copy) NSString *phone_hidden;

@end
