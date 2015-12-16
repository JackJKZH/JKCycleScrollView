# JKCycleScrollView
## 无限循环轮播图  banner专用
 ![image](https://github.com/JackJKZH/JKCycleScrollView/blob/master/lunbo.png)

### 使用方法：将demo中得JKCycleScrollViews加入项目中，导入#import "JKCycleScrollView.h"头文；如要实现图片点击方法则要遵守JKCycleScrollViewDelegate，设置代理，实现代理方法

#### // 创建不带标题的本地图片轮播器
    JKCycleScrollView *cycleScrollView = [JKCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 64, width, 200) imagesGroup:images];
    [self.view addSubview:cycleScrollView];

####  // 创建带标题的url图片轮播器
    JKCycleScrollView *cycleScrollView2 = [JKCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 270, width, 190) imagesUrlStringGroup:self.imageUrlArr];
      [self.view addSubview:cycleScrollView2];
      
####  // 创建带标题的本地图片轮播器
    JKCycleScrollView *cycleScrollView3 = [JKCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 470, width, 190) imagesGroup:images];
    cycleScrollView3.titlesGroup = titles;
    [self.view addSubview:cycleScrollView3];
    
#### //相关属性的设置  
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

### 具体请查看Demo
