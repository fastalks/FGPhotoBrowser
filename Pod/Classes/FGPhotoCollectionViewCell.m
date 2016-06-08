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
@property (nonatomic,strong) UITapGestureRecognizer *doubleTap;
@end

@implementation FGPhotoCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       [self setupView];
        [self addGestureRecognizer:self.doubleTap];
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

- (void)resetZoomingScale {
    
    if (self.scrollView.zoomScale !=1) {
        self.scrollView.zoomScale = 1;
    }
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    _scrollView.frame = self.bounds;
    _imageView.frame = _scrollView.bounds;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}
- (void)doubleTapGestrueHandle:(UITapGestureRecognizer *)sender {
    CGPoint p = [sender locationInView:self];
    if (self.scrollView.zoomScale <=1.0) {
        CGFloat scaleX = p.x + self.scrollView.contentOffset.x;
        CGFloat scaley = p.y + self.scrollView.contentOffset.y;
        [self.scrollView zoomToRect:CGRectMake(scaleX, scaley, 10, 10) animated:YES];
    }
    else {
        [self.scrollView setZoomScale:1.0 animated:YES];
    }
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    self.imageView.center = [self centerOfScrollViewContent:scrollView];
}

- (UITapGestureRecognizer *)doubleTap {
    if (!_doubleTap) {
        _doubleTap  =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapGestrueHandle:)];
        _doubleTap.numberOfTapsRequired = 2;
        _doubleTap.numberOfTouchesRequired = 1;
    }
    return _doubleTap;
}
- (CGPoint)centerOfScrollViewContent:(UIScrollView *)scrollView {
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    CGPoint actualCenter = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                       scrollView.contentSize.height * 0.5 + offsetY);
    return actualCenter;
}
@end
