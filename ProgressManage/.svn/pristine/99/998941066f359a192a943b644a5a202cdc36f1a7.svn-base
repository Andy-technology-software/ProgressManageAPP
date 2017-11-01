//
//  KehuCustomAnnotationView.h
//  vosc
//
//  Created by lingnet on 2017/7/18.
//  Copyright © 2017年 Gem. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

//#import "CustomCalloutView.h"
@protocol KehuCustomAnnotationViewDelegate <NSObject>

- (void)sendBackSelect:(NSString*)str;

@end
@interface KehuCustomAnnotationView : MAAnnotationView
//@property (nonatomic, readonly) CustomCalloutView *calloutView;
@property(nonatomic,weak)id<KehuCustomAnnotationViewDelegate>KehuCustomAnnotationViewDelegate;
@property(nonatomic,strong)UILabel* subTitleLable;
@property(nonatomic,strong)UIButton* seleBtn;

@property(nonatomic,copy)NSString* name;
@property(nonatomic,copy)NSString* idStr;
@end
