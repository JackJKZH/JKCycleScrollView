//
//  JKViewController.m
//  JKCycleScrollView
//
//  Created by Kzj_ZhongJunKang on 15/12/15.
//  Copyright © 2015年 Kzj_ZhongJunKang. All rights reserved.
//

#import "JKViewController.h"
#import "JKCycleScrollView.h"
#import "JKWebViewController.h"

@interface JKViewController ()<JKCycleScrollViewDelegate>
@property (nonatomic , strong) NSArray *imageUrlArr;
@end

@implementation JKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"轮播图";
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *images = @[[UIImage imageNamed:@"1.jpg"],
                        [UIImage imageNamed:@"2.jpg"],
                        [UIImage imageNamed:@"3.jpg"],
                        [UIImage imageNamed:@"4.jpg"]
                        ];
    
    NSArray *titles = @[@"私人定制轮播效果",
                        @"banner广告不错的选择",
                        @"支持URL图片",
                        @"支持本地图片",
                        @"欢迎下载使用"
                        ];
    
    self.imageUrlArr = @[@"http://pic2.ooopic.com/10/74/38/63bOOOPIC9d.jpg",
                     @"http://pic38.nipic.com/20140215/12359647_224249442128_2.jpg",
                     @"http://pic38.nipic.com/20140215/12359647_224249271130_2.jpg",
                     @"http://pic38.nipic.com/20140215/12359647_224250481137_2.jpg",
                     @"http://i2.tietuku.com/cfe7af7521f13a3d.jpg"];
    CGFloat width = self.view.bounds.size.width;
   
    // 创建不带标题的图片轮播器
    JKCycleScrollView *cycleScrollView = [JKCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 64, width, 200) imagesGroup:images];
    cycleScrollView.delegate = self;
    cycleScrollView.autoScrollTimeInterval = 3.0;
    cycleScrollView.pageControlAliment = JKCycleScrollViewPageContolAlimentCenter;
 
    cycleScrollView.dotSize = CGSizeMake(10, 10);
    [self.view addSubview:cycleScrollView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 创建带标题的url图片轮播器
    JKCycleScrollView *cycleScrollView2 = [JKCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 270, width, 190) imagesUrlStringGroup:self.imageUrlArr];
    cycleScrollView2.pageControlAliment = JKCycleScrollViewPageContolAlimentRight;
    cycleScrollView2.autoScrollTimeInterval = 2.0;
    cycleScrollView2.delegate = self;
    cycleScrollView2.titlesGroup = titles;
    cycleScrollView2.tag = 2;
    [self.view addSubview:cycleScrollView2];

    // 创建带标题的url图片轮播器
    JKCycleScrollView *cycleScrollView3 = [JKCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 470, width, 190) imagesGroup:images];
    cycleScrollView3.pageControlAliment = JKCycleScrollViewPageContolAlimentRight;
    cycleScrollView3.autoScrollTimeInterval = 1.0;
    cycleScrollView3.delegate = self;
    cycleScrollView3.titlesGroup = titles;
    [self.view addSubview:cycleScrollView3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - JKCycleScrollViewDelegate
-(void)cycleScrollView:(JKCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    if (cycleScrollView.tag ==2) {
//          NSLog(@"%ld",index);
        NSURL *url = [NSURL URLWithString:self.imageUrlArr[index]];
        JKWebViewController *web = [[JKWebViewController alloc] init];
        web.webUrl = url;
        [self.navigationController pushViewController:web animated:YES];
    }
  NSLog(@"%ld",index);
}
@end
