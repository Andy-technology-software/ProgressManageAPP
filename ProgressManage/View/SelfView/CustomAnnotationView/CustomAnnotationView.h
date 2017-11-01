//
//  CustomAnnotationView.h
//  vosc
//
//  Created by lingnet on 2017/6/27.
//  Copyright © 2017年 Gem. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

#import "CustomCalloutView.h"
@protocol CustomAnnotationViewDelegate <NSObject>

- (void)sendBackSelect;

@end
@interface CustomAnnotationView : MAAnnotationView
@property (nonatomic, readonly) CustomCalloutView *calloutView;
@property(nonatomic,weak)id<CustomAnnotationViewDelegate>CustomAnnotationViewDelegate;

@end
