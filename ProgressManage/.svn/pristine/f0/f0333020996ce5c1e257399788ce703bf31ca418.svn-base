//
//  ChangeFramePageControl.m
//  ProgressManage
//
//  Created by Gem on 2017/5/4.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "ChangeFramePageControl.h"

@implementation ChangeFramePageControl

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void) setCurrentPage:(NSInteger)page {
    [super setCurrentPage:page];
    for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++) {
        UIImageView* subview = [self.subviews objectAtIndex:subviewIndex];
        CGSize size;
        size.height = 7;
        size.width = 10;
        //        [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y,
        //                                     size.width,size.height)];
        //        if (subviewIndex == page) [subview setImage:[UIImage imageNamed:@"BluePoint.png"]];
        //        else [subview setImage:[UIImage imageNamed:@"BlackPoint.png"]];
        if (subviewIndex == page){
            [subview setFrame:CGRectMake(subview.x, subview.y,size.width,size.height)];
        }
    }
}
@end
