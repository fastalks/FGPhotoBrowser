//
//  FGPhotoBottomView.m
//  Pods
//
//  Created by wangfaguo on 16/6/3.
//
//

#import "FGPhotoBottomView.h"

@implementation FGPhotoBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.titleLabel = [[UILabel alloc]initWithFrame: CGRectMake(10, 0, CGRectGetWidth(frame) - 80,CGRectGetHeight(frame))];
        self.titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        
        self.progressLabel = [[UILabel alloc]initWithFrame: CGRectMake(CGRectGetWidth(frame) - 80, 0, 80,CGRectGetHeight(frame))];
        self.progressLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.progressLabel];
    }
    return self;
}
@end
