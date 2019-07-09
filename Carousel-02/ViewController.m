//
//  ViewController.m
//  Carousel-02
//
//  Created by Sco.X on 2018/10/10.
//  Copyright © 2018 Scorpio.X. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>

@interface ViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *carousel;

@property (nonatomic, strong) UIImageView *leftImageView;

@property (nonatomic, strong) UIImageView *centerImageView;

@property (nonatomic, strong) UIImageView *rightImageView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, assign) NSInteger currenPageIndex;

@property (nonatomic, copy) NSArray<UIImage *> *images;

@end

@implementation ViewController {
    struct {
        unsigned hasLogin : 1;
        unsigned hasRead : 1;
        unsigned hasWrite : 1;
    }Status;
    
    struct {
        unsigned age;
        unsigned no;
        unsigned pId;
    }Person;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    [self.view addSubview:self.carousel];
    [self.carousel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).mas_offset(44.f);
        make.height.equalTo(self.carousel.mas_width).multipliedBy(9.f/16.f);
    }];
    
    [self.view addSubview:self.pageControl];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.bottom.equalTo(self.carousel.mas_bottom).mas_offset(-5.f);
    }];

    [self setupImages];
}

#pragma mark- Private Method
- (void)setupImages {
    
    NSMutableArray *imgs = [NSMutableArray array];
    for (NSInteger i = 0; i < 10; ++i) {
        [imgs addObject:[UIImage imageNamed:[NSString stringWithFormat:@"img%02ld", (long)i]]];
    }
    self.images = [imgs copy];
    
    self.leftImageView = [self createImageViewWithImage:self.images.lastObject];
    self.leftImageView = [self createImageViewWithImage:self.images.]
    
}

- (void)carouselReset {
    [self.carousel setNeedsLayout];
    [self.carousel layoutIfNeeded];
    [self carouselMoveToIndex:0];
}

- (void)carouselMoveToIndex:(NSInteger)index {
    
}

- (UIImageView *)createImageViewWithImage:(UIImage *)image {
    UIImageView *imgV = [[UIImageView alloc] initWithImage:image];
    imgV.contentMode = UIViewContentModeScaleAspectFill;
    return imgV;
}

#pragma mark- UIScrollView Delegate


#pragma mark- Getter
- (UIScrollView *)carousel {
    if (!_carousel) {
        _carousel = [[UIScrollView alloc] init];
        _carousel.pagingEnabled = YES;
        _carousel.scrollEnabled = YES;
        _carousel.showsHorizontalScrollIndicator = NO;
        _carousel.showsVerticalScrollIndicator = NO;
    }
    return _carousel;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.pageIndicatorTintColor = UIColor.whiteColor;
        _pageControl.currentPageIndicatorTintColor = UIColor.cyanColor;
    }
    return _pageControl;
}

@end
