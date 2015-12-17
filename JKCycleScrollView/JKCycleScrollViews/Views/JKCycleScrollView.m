//
//  JKCycleScrollView.m
//  JKCycleScrollView
//
//  Created by Kzj_ZhongJunKang on 15/12/15.
//  Copyright © 2015年 Kzj_ZhongJunKang. All rights reserved.
//

#import "JKCycleScrollView.h"
#import <TAPageControl.h>
#import "JKCollectionViewCell.h"
#import "UIView+JKViewFrame.h"
#import <UIImageView+UIActivityIndicatorForSDWebImage.h>

NSString * const ID = @"cycleCell";

@interface JKCycleScrollView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) UICollectionView *mainView; // 显示图片的collectionView
@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger totalItemsCount;
@property (nonatomic, weak) TAPageControl *pageControl;

@end



@implementation JKCycleScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.pageControlAliment = JKCycleScrollViewPageContolAlimentCenter;
        _autoScrollTimeInterval = 1.0;
        [self setupMainView];
    }
    return self;
}

+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame imagesGroup:(NSArray *)imagesGroup
{
    JKCycleScrollView *cycleScrollView = [[self alloc] initWithFrame:frame];
    cycleScrollView.imagesGroup =imagesGroup;
    return cycleScrollView;
}
+(instancetype)cycleScrollViewWithFrame:(CGRect)frame imagesUrlStringGroup:(NSArray *)imagesUrlGroup
{
    JKCycleScrollView *cycleScrollView = [[self alloc] initWithFrame:frame];
    
    cycleScrollView.imagesUrlStringGroup = imagesUrlGroup;
  
    return cycleScrollView;
}


- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    _flowLayout.itemSize = self.frame.size;
}

- (void)setAutoScrollTimeInterval:(CGFloat)autoScrollTimeInterval
{
    _autoScrollTimeInterval = autoScrollTimeInterval;
    
    [_timer invalidate];
    _timer = nil;
    [self setupTimer];
}

// 设置显示图片的collectionView
- (void)setupMainView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    NSLog(@"%.2f===%.2f",self.frame.origin.y,self.frame.size.height);
    CGSize itemS = self.frame.size;
  
    itemS.height = itemS.height ;

    flowLayout.itemSize = itemS;
    NSLog(@"%.2f===%.2f",flowLayout.itemSize.width,flowLayout.itemSize.height);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout = flowLayout;
    
    UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:flowLayout];
    mainView.backgroundColor = [UIColor greenColor];
    mainView.pagingEnabled = YES;
    mainView.showsHorizontalScrollIndicator = NO;
    mainView.showsVerticalScrollIndicator = NO;
    [mainView registerClass:[JKCollectionViewCell class] forCellWithReuseIdentifier:ID];
    mainView.dataSource = self;
    mainView.delegate = self;
    [self addSubview:mainView];
    _mainView = mainView;
}

- (void)setImagesGroup:(NSArray *)imagesGroup
{
    _imagesGroup = imagesGroup;
    _totalItemsCount = imagesGroup.count *100;
    NSLog(@"%ld",_totalItemsCount);
    [self setupTimer];
    [self setupPageControl];
}
-(void)setImagesUrlStringGroup:(NSArray *)imagesUrlStringGroup{
    _imagesUrlStringGroup = imagesUrlStringGroup;
    _totalItemsCount = imagesUrlStringGroup.count *100;
    NSLog(@"%ld",_totalItemsCount);
    [self setupTimer];
    [self setupPageControl];
}
- (void)setupPageControl
{
    TAPageControl *pageControl = [[TAPageControl alloc] init];
    if (self.imagesGroup.count) {
      pageControl.numberOfPages = self.imagesGroup.count;
    }
    if (self.imagesUrlStringGroup.count) {
        pageControl.numberOfPages = self.imagesUrlStringGroup.count;
    }
 
    [self addSubview:pageControl];

    _pageControl = pageControl;
}


- (void)automaticScroll
{
    int currentIndex = _mainView.contentOffset.x / _flowLayout.itemSize.width;
    int targetIndex = currentIndex + 1;
    if (targetIndex == _totalItemsCount) {
        targetIndex = _totalItemsCount * 0.5;
        [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

- (void)setupTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _mainView.frame = self.bounds;
    if (_mainView.contentOffset.x == 0) {
        [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_totalItemsCount * 0.5 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    CGSize size ;
    if (self.imagesGroup.count) {
         size = [_pageControl sizeForNumberOfPages:self.imagesGroup.count];
    }
    if (self.imagesUrlStringGroup.count) {
        size = [_pageControl sizeForNumberOfPages:self.imagesUrlStringGroup.count];
    }
    CGFloat x = (self.jk_width - size.width) * 0.5;
    if (self.pageControlAliment == JKCycleScrollViewPageContolAlimentRight) {
        x = self.mainView.jk_width - size.width - 10;
    }
    if (self.pageControlAliment == JKCycleScrollViewPageContolAlimentLeft) {
        x = 10;
    }
    CGFloat y = self.mainView.jk_height - size.height - 10;
    NSLog(@"%.2f",x);
    _pageControl.frame = CGRectMake(x, y, size.width, size.height);
    if (self.betweenDots) {
        _pageControl.spacingBetweenDots = self.betweenDots;
    }
    if (self.dotImage) {
        _pageControl.dotImage = self.dotImage;
    }
    if (self.currentDotImage) {
        _pageControl.currentDotImage = self.currentDotImage;
    }
    _pageControl.dotSize = self.dotSize;
    [_pageControl sizeToFit];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"=========%ld",_totalItemsCount);
    return _totalItemsCount ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JKCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    long itemIndex = 0;
    if (self.imagesGroup.count) {
       itemIndex  = indexPath.item % self.imagesGroup.count;
        
        cell.imageView.image = self.imagesGroup[itemIndex];
    }
    if (self.imagesUrlStringGroup.count) {
        itemIndex  = indexPath.item % self.imagesUrlStringGroup.count;
        
        [cell.imageView setImageWithURL:[NSURL URLWithString:self.imagesUrlStringGroup[itemIndex]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

        } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    }

    if (_titlesGroup.count) {
        if (itemIndex < _titlesGroup.count) {
           cell.title = _titlesGroup[itemIndex];
        }else{
            cell.title = @"";
        }
        
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(cycleScrollView:didSelectItemAtIndex:)]) {
        if (self.imagesGroup.count) {
              [self.delegate cycleScrollView:self didSelectItemAtIndex:indexPath.item % self.imagesGroup.count];
        }
        if (self.imagesUrlStringGroup.count) {
              [self.delegate cycleScrollView:self didSelectItemAtIndex:indexPath.item % self.imagesUrlStringGroup.count];
        }
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int itemIndex = (scrollView.contentOffset.x + self.mainView.jk_width * 0.5) / self.mainView.jk_width;
    int indexOnPageControl = 0;
    if (self.imagesGroup.count) {
        indexOnPageControl  = itemIndex % self.imagesGroup.count;
    }
    if (self.imagesUrlStringGroup.count) {
        indexOnPageControl = itemIndex % self.imagesUrlStringGroup.count;
    }
    _pageControl.currentPage = indexOnPageControl;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_timer invalidate];
    _timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self setupTimer];
}


@end
