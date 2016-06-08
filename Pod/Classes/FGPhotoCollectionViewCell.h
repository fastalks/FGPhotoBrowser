//
//  FGPhotoCollectionViewCell.h
//  Pods
//
//  Created by wangfaguo on 16/6/2.
//
//

#import <UIKit/UIKit.h>

@interface FGPhotoCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong) UIImageView *imageView;
-(void)resetZoomingScale;
@end
