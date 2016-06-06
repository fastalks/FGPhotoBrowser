//
//  FGPhotoCollectionViewCell.m
//  Pods
//
//  Created by wangfaguo on 16/6/2.
//
//

#import "FGPhotoCollectionViewCell.h"
@interface FGPhotoCollectionViewCell () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation FGPhotoCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       [self setupView];
    }
    return self;
}
- (void)setupView {
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor blackColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.maximumZoomScale = 2;
    _scrollView.minimumZoomScale = 0.5;
    _scrollView.delegate = self;
    
    [self addSubview:_scrollView];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.userInteractionEnabled = YES;
    [_scrollView addSubview:imageView];
    _imageView = imageView;
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    _scrollView.frame = self.bounds;
    _imageView.frame = _scrollView.bounds;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

@end
