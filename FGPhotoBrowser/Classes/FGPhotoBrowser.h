//
//  FGPhotoBrowser.h
//  Pods
//
//  Created by wangfaguo on 16/6/2.
//
//

#import <UIKit/UIKit.h>
#import "FGPhotoModel.h"

@interface FGPhotoBrowser : UIViewController

+(void)showSingleImageView:(UIImageView*)imageView withImageUrls:(NSArray<FGPhotoModel*>*)images  index:(NSInteger)index;

+(void)showMultiImagesView:(UIImageView*)imageView withImageUrls:(NSArray<FGPhotoModel*>*)images  index:(NSInteger)index;
@end
