//
//  FGViewController.m
//  FGPhotoBrowser
//
//  Created by wangfaguo on 06/03/2016.
//  Copyright (c) 2016 wangfaguo. All rights reserved.
//

#import "FGViewController.h"
#import <FGPhotoBrowser/FGPhotoBrowser.h>
#import <UIImageView+WebCache.h>

@interface FGViewController ()<FGPhotoBrowserDelegate>
{
    UIImageView *imageView;
}

@end

@implementation FGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    imageView = [[UIImageView alloc]init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://www.mobp2p.com/data/upfiles/images/2016-06/03/863599_users_avatar_1464938907691.JPEG"]];
    imageView.frame = CGRectMake(100, 200, 80, 80);
    [self.view addSubview:imageView];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tipAction)]];
    
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    UIView *view = [[UIView alloc]initWithFrame:self.view.bounds];
//    view.backgroundColor = [UIColor blackColor];
//    view.tag = 1000;
//    [self.view addSubview:view];
//    [self performSelector:@selector(removeview) withObject:nil afterDelay:10];
}
-(void)removeview{
    UIView *view = [self.view viewWithTag:1000];
    [view removeFromSuperview];
}
-(void)tipAction{
    NSLog(@"%@",NSStringFromCGSize(imageView.image.size));
    
    NSMutableArray *images= [[NSMutableArray alloc]init];
    for (int i = 1; i < 5; i++) {
        FGPhotoModel *model1 = [[FGPhotoModel alloc] init];
        model1.title = [NSString stringWithFormat:@"这是套图title %d",i];
        model1.imageUrl = @"http://www.mobp2p.com/data/upfiles/images/2016-06/03/863599_users_avatar_1464938907691.JPEG";
        [images addObject:model1];
        for (int j = 1 ;j < 5 ;j++) {
            FGPhotoModel *model2 = [[FGPhotoModel alloc] init];
            model2.title = model1.title;
            model2.imageUrl = @"http://www.mobp2p.com/data/upfiles/images/2016-06/03/863599_users_avatar_1464938907691.JPEG";
            [model1.childrens addObject:model2];
        }
    }

//    [FGPhotoBrowser showSingleImageView:imageView withImageUrls:images index:0];

   FGPhotoBrowser *browser = [FGPhotoBrowser showMultiImagesWithDelegate:self imageView:imageView withImageUrls:images index:0];
    
}
-(void)rightButtonItemDidTipAtIndex:(NSInteger)index{
    
}
-(void)FGPhotoBrowser:(FGPhotoBrowser*)browser didScrollToEnd:(NSInteger)index{
    NSMutableArray *images= [[NSMutableArray alloc]init];
    for (int i = 5; i < 7; i++) {
        FGPhotoModel *model1 = [[FGPhotoModel alloc] init];
        model1.title = [NSString stringWithFormat:@"这是套图title %d",i];
        model1.imageUrl = @"http://www.mobp2p.com/data/upfiles/images/2016-06/03/863599_users_avatar_1464938907691.JPEG";
        [images addObject:model1];
        for (int j = 1 ;j < 5 ;j++) {
            FGPhotoModel *model2 = [[FGPhotoModel alloc] init];
            model2.title = model1.title;
            model2.imageUrl = @"http://www.mobp2p.com/data/upfiles/images/2016-06/03/863599_users_avatar_1464938907691.JPEG";
            [model1.childrens addObject:model2];
        }
    }
    [browser loadMore:images];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
