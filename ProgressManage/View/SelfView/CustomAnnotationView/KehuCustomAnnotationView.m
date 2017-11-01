//
//  KehuCustomAnnotationView.m
//  vosc
//
//  Created by lingnet on 2017/7/18.
//  Copyright © 2017年 Gem. All rights reserved.
//

#import "KehuCustomAnnotationView.h"
@interface KehuCustomAnnotationView ()

//@property (nonatomic, strong, readwrite) CustomCalloutView *calloutView;
//@property(nonatomic,strong)UIButton* seleBtn;
@end
@implementation KehuCustomAnnotationView

#define kCalloutWidth       200.0
#define kCalloutHeight      70.0

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews{
    
//    [self addSubview:self.calloutView];
    
    self.subTitleLable = [MyController createLabelWithFrame:CGRectMake(0, 0, 20, 12) Font:12 Text:self.name];
    self.subTitleLable.textAlignment = NSTextAlignmentCenter;
    self.subTitleLable.backgroundColor = [UIColor redColor];
    self.subTitleLable.lineBreakMode = NSLineBreakByTruncatingTail;
//    [self addSubview:self.subTitleLable];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [self.KehuCustomAnnotationViewDelegate sendBackSelect:self.idStr];
    
}

- (void)seleBtnClick{
    [self.KehuCustomAnnotationViewDelegate sendBackSelect:self.idStr];
}
@end
