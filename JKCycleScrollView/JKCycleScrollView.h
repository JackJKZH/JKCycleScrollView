//
//  JKCycleScrollView.h
//  JKCycleScrollView
//
//  Created by Kzj_ZhongJunKang on 15/12/15.
//  Copyright © 2015年 Kzj_ZhongJunKang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    JKCycleScrollViewPageContolAlimentLeft,
    JKCycleScrollViewPageContolAlimentRight,
    JKCycleScrollViewPageContolAlimentCenter
}JKCycleScrollViewPageContolAliment;

@class JKCycleScrollView;
@protocol JKCycleScrollViewDelegate <NSObject>

- (void)cycleScrollView:(JKCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;

@end

@interface JKCycleScrollView : UIView

@property (nonatomic, strong) NSArray *imagesGroup;
@property (nonatomic, strong) NSArray *imagesUrlStringGroup;
@property (nonatomic, strong) NSArray *titlesGroup;
//设置轮播时间;默认1s
@property (nonatomic, assign) CGFloat autoScrollTimeInterval;
//当前pageControll的位置，默认居中
@property (nonatomic, assign) JKCycleScrollViewPageContolAliment pageControlAliment;
//当前pageControll的图片
@property (nonatomic) UIImage *dotImage;
//当前pageControll的点得图片
@property (nonatomic) UIImage *currentDotImage;
//pageControll的点得大小,默认是8*8
@property (nonatomic) CGSize dotSize;
//pageControll的两点得之间的间隙，默认是8
@property (nonatomic) NSInteger betweenDots;


@property (nonatomic, weak) id<JKCycleScrollViewDelegate> delegate;

+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame imagesGroup:(NSArray *)imagesGroup;
+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame imagesUrlStringGroup:(NSArray *)imagesUrlGroup;
@end
