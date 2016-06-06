//
//  FGPhotoModel.m
//  Pods
//
//  Created by wangfaguo on 16/6/3.
//
//

#import "FGPhotoModel.h"

@implementation FGPhotoModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.childrens = [[NSMutableArray alloc]init];
    }
    return self;
}
@end
