//
//  FGPhotoBrowser.h
//  Pods
//
//  Created by wangfaguo on 16/6/2.
//
//

#import <UIKit/UIKit.h>
#import "FGPhotoModel.h"
@class FGPhotoBrowser;
@protocol FGPhotoBrowserDelegate <NSObject>
@optional
-(void)rightButtonItemDidTipAtIndex:(NSInteger)index;
-(void)FGPhotoBrowser:(FGPhotoBrowser*)browser didScrollToEnd:(NSInteger)index;
-(UIImage*)rigthItemButtonImageForFGPhotoBrowser:(FGPhotoBrowser*)browser;

@end

@interface FGPhotoBrowser : UIViewController

@property (nonatomic,weak,readonly) id<FGPhotoBrowserDelegate>delegate;

+(id)showSingleImagesWithDelegate:(id<FGPhotoBrowserDelegate>)delegate imageView:(UIImageView*)imageView withImageUrls:(NSArray<FGPhotoModel*>*)images  index:(NSInteger)index;

+(id)showMultiImagesWithDelegate:(id<FGPhotoBrowserDelegate>)delegate imageView:(UIImageView*)imageView withImageUrls:(NSArray<FGPhotoModel*>*)images  index:(NSInteger)index;

-(void)loadMore:(NSArray*)photos;
@end
