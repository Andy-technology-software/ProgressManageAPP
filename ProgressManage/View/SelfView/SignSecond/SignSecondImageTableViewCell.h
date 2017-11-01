//
//  SignSecondImageTableViewCell.h
//  ProgressManage
//
//  Created by lingnet on 2017/5/12.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SignSecondImageModel;
@protocol SignSecondImageTableViewCellDelegate <NSObject>

- (void)sendBackAddImage;
- (void)sendBackSelectImage:(NSInteger)index;
- (void)sendBackDeleImage:(NSInteger)index;
@end
@interface SignSecondImageTableViewCell : UITableViewCell
- (void)configCellWithModel:(SignSecondImageModel *)model;
@property(nonatomic,weak)id<SignSecondImageTableViewCellDelegate>SignSecondImageTableViewCellDelegate;

@end
