//
//  FGPhotoModel.h
//  Pods
//
//  Created by wangfaguo on 16/6/3.
//
//

#import <Foundation/Foundation.h>

@interface FGPhotoModel : NSObject

@property (nonatomic,strong) NSString *title;//名称
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) NSString *imageUrl;
@property (nonatomic,strong) NSMutableArray<FGPhotoModel*> *childrens;
@end
