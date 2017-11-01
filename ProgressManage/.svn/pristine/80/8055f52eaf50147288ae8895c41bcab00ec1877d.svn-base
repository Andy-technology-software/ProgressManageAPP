//
//  CustomAnnotationView.m
//  vosc
//
//  Created by lingnet on 2017/6/27.
//  Copyright © 2017年 Gem. All rights reserved.
//

#import "CustomAnnotationView.h"

@interface CustomAnnotationView ()

@property (nonatomic, strong, readwrite) CustomCalloutView *calloutView;
@property(nonatomic,strong)UIButton* seleBtn;
@end

@implementation CustomAnnotationView
#define kCalloutWidth       200.0
#define kCalloutHeight      70.0

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    
//    [self.CustomAnnotationViewDelegate sendBackSelect];
    
    if (self.selected == selected){
        return;
    }
    
    if (selected)
    {
        if (self.calloutView == nil)
        {
            self.calloutView = [[CustomCalloutView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                                  -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
        }
        
        self.calloutView.image = [UIImage imageNamed:@"图层-9"];
        self.calloutView.title = self.annotation.title;
        self.calloutView.subtitle = self.annotation.subtitle;
        
        self.seleBtn = [MyController createButtonWithFrame:self.calloutView.frame ImageName:nil Target:self Action:@selector(seleBtnClick) Title:nil];
        
//        [self addSubview:self.calloutView];
        [self addSubview:self.seleBtn];
    }else{
        [self.calloutView removeFromSuperview];
    }
    
//    [super setSelected:selected animated:animated];
}

- (void)seleBtnClick{
    [self.CustomAnnotationViewDelegate sendBackSelect];
}
@end
