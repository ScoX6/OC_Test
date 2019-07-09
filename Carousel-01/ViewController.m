//
//  ViewController.m
//  Carousel-01
//
//  Created by Sco.X on 2018/10/10.
//  Copyright © 2018 Scorpio.X. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *carousel;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, copy) NSArray<UIImage *> *images;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.carousel];
    [self.carousel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).mas_offset(44.f);
        make.width.equalTo(self.carousel.mas_height).multipliedBy(16.f/9.f);
    }];
    
    [self.view addSubview:self.pageControl];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.carousel);
        make.bottom.equalTo(self.carousel).mas_offset(-5.f);
    }];

    [self setupImages];
    
    [self setupPageControl];
    
    [self.carousel setNeedsLayout];
    [self.carousel layoutIfNeeded];
    [self resetCarousel];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
}

#pragma mark- Private Method
- (void)setupImages {
    
    NSMutableArray *imgs = [NSMutableArray array];
    for (NSInteger i = 0; i < 10; ++i) {
        [imgs addObject:[UIImage imageNamed:[NSString stringWithFormat:@"img%02ld", (long)i]]];
    }
    [imgs addObject:[UIImage imageNamed:@"img00"]];
    [imgs insertObject:[UIImage imageNamed:@"img09"] atIndex:0];
    self.images = [imgs copy];
    
    MASViewAttribute *preview = self.carousel.mas_left;
    for (UIImage *img in imgs) {
        UIImageView *imgView = [self createImageViewWithImage:img];
        [self.carousel addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.carousel);
            make.left.equalTo(preview);
            make.height.equalTo(self.carousel);
            make.width.equalTo(imgView.mas_height).multipliedBy(16.f/9.f);
        }];
        preview = imgView.mas_right;
    }

    [self.carousel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(preview);
    }];
}

- (void)setupPageControl {
    
    self.pageControl.numberOfPages = self.images.count - 2;
    self.pageControl.tintColor = UIColor.whiteColor;
    self.pageControl.pageIndicatorTintColor = UIColor.whiteColor;
    self.pageControl.currentPageIndicatorTintColor = UIColor.cyanColor;
    
}

- (void)resetCarousel {
    [self carouselMoveToIndex:0];
}

- (void)carouselMoveToIndex:(NSInteger)index {
    NSInteger i = MIN(MAX(index, self.images.count - 1), 0);
    self.pageControl.currentPage = i;
    self.carousel.contentOffset = CGPointMake(kScreenWidth * (i+1), 0);
}

- (UIImageView *)createImageViewWithImage:(UIImage *)image {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    return imageView;
}

#pragma mark- UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat relativeOffsetX = scrollView.contentOffset.x -  kScreenWidth + kScreenWidth / 2.f;
    CGFloat relativePosition = relativeOffsetX / kScreenWidth;
    relativePosition = relativePosition < 0 ? self.images.count - 2 : relativePosition;
    relativePosition = relativePosition > self.images.count - 2 ? 0 : relativePosition;
    self.pageControl.currentPage = (NSInteger)relativePosition;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    if (offsetX < kScreenWidth) {
        scrollView.contentOffset = CGPointMake(kScreenWidth * (self.images.count - 2), 0);
    }
    if (offsetX > kScreenWidth * (self.images.count - 2)) {
        scrollView.contentOffset = CGPointMake(kScreenWidth, 0);
    }
}


#pragma mark- Getter
- (UIScrollView *)carousel {
    if (!_carousel) {
        _carousel = [[UIScrollView alloc] init];
        _carousel.delegate = self;
        _carousel.pagingEnabled = YES;
        _carousel.bounces = NO;
        _carousel.showsHorizontalScrollIndicator = NO;
        _carousel.showsVerticalScrollIndicator = NO;
        _carousel.scrollEnabled = YES;
    }
    return _carousel;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
    }
    return _pageControl;
}

@end
