//
//  UIView+JKViewFrame.m
//  JKCycleScrollView
//
//  Created by Kzj_ZhongJunKang on 15/12/15.
//  Copyright © 2015年 Kzj_ZhongJunKang. All rights reserved.
//

#import "UIView+JKViewFrame.h"

@implementation UIView (JKViewFrame)

-(CGFloat)jk_height{
    return self.frame.size.height;
}
-(void)setJk_height:(CGFloat)jk_height{
    CGRect temp = self.frame;
    temp.size.height = jk_height;
    self.frame = temp;
}
- (CGFloat)jk_width
{
    return self.frame.size.width;
}

- (void)setJk_width:(CGFloat)jk_width
{
    CGRect temp = self.frame;
    temp.size.width = jk_width;
    self.frame = temp;
}


- (CGFloat)jk_y
{
    return self.frame.origin.y;
}

- (void)setJk_y:(CGFloat)jk_y
{
    CGRect temp = self.frame;
    temp.origin.y = jk_y;
    self.frame = temp;
}

- (CGFloat)jk_x
{
    return self.frame.origin.x;
}

- (void)setJk_x:(CGFloat)jk_x
{
    CGRect temp = self.frame;
    temp.origin.x = jk_x;
    self.frame = temp;
}

@end
