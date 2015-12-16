# JKCycleScrollView
无限循环轮播图  banner专用
使用方法：将demo中得JKCycleScrollViews加入项目中，导入#import "JKCycleScrollView.h"头文件

// 创建不带标题的本地图片轮播器
JKCycleScrollView *cycleScrollView = [JKCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 64, width, 200) imagesGroup:images];
[self.view addSubview:cycleScrollView];