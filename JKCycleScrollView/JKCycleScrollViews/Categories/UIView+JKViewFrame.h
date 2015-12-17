//
//  UIView+JKViewFrame.h
//  JKCycleScrollView
//
//  Created by Kzj_ZhongJunKang on 15/12/15.
//  Copyright © 2015年 Kzj_ZhongJunKang. All rights reserved.
//

#import <UIKit/UIKit.h>
#define RGB(r, g, b, a) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a]

@interface UIView (JKViewFrame)
@property (nonatomic, assign) CGFloat jk_height;
@property (nonatomic, assign) CGFloat jk_width;

@property (nonatomic, assign) CGFloat jk_y;
@property (nonatomic, assign) CGFloat jk_x;
@end
