//
//  FGPhotoTopView.m
//  Pods
//
//  Created by wangfaguo on 16/6/3.
//
//

#import "FGPhotoTopView.h"

@implementation FGPhotoTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.backButton.frame = CGRectMake(10, CGRectGetMidY(frame) - 11, 22, 22);
        [self.backButton setImage:[UIImage imageNamed:@"FGPhotoBrowserImages.bundle/titlebar_back"] forState:UIControlStateNormal];
        [self addSubview:self.backButton];
        
        self.collectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.collectionButton.frame = CGRectMake(CGRectGetMaxX(frame) - 32, CGRectGetMidY(frame) - 11, 22, 22);
        [self.collectionButton setImage:[UIImage imageNamed:@"FGPhotoBrowserImages.bundle/message_icon"] forState:UIControlStateNormal];
        [self addSubview:self.collectionButton];
    }
    return self;
}
@end
