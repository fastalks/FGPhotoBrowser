//
//  FGPhotoBrowser.m
//  Pods
//
//  Created by wangfaguo on 16/6/2.
//
//

#import "FGPhotoBrowser.h"
#import "FGPhotoCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "FGPhotoTopView.h"
#import "FGPhotoBottomView.h"


#define TopViewHeight 64
#define BottomViewHeight 40

#define FG_Screen_Rect [[UIScreen mainScreen]bounds]
#define FG_Screen_Size [[UIScreen mainScreen]bounds].size
#define FG_Screen_Width [[UIScreen mainScreen]bounds].size.width
#define FG_Screen_Height [[UIScreen mainScreen]bounds].size.height


static UIWindow *photo_Window = nil;

@interface FGPhotoBrowser ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
     CGRect _endTempFrame;
}
@property (nonatomic,strong) NSMutableArray<FGPhotoModel*> *images;//要展示的图片模型集合
@property (nonatomic,strong) UICollectionView *photoCollectView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) FGPhotoTopView *topView;
@property (nonatomic, strong) FGPhotoBottomView *bottomView;
@property (nonatomic,assign) BOOL showMultiImages;//显示套图
@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic,assign) NSInteger currentPageIndex;

@property (nonatomic,weak,readwrite) id<FGPhotoBrowserDelegate>delegate;
@end

@implementation FGPhotoBrowser

+(id)showSingleImagesWithDelegate:(id<FGPhotoBrowserDelegate>)delegate imageView:(UIImageView *)imageView withImageUrls:(NSArray<FGPhotoModel *> *)images index:(NSInteger)index{
    if (photo_Window == nil)
    {
        photo_Window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        photo_Window.windowLevel = UIWindowLevelNormal;
        photo_Window.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.];
        [photo_Window makeKeyAndVisible];
    }
    
    FGPhotoBrowser *browser = [[FGPhotoBrowser alloc]init];
    browser.delegate = delegate;
    browser.currentIndex = index;
    browser.imageView = imageView;
    [browser.images addObjectsFromArray:images];
    photo_Window.rootViewController = browser;
    return browser;
}

+(id)showMultiImagesWithDelegate:(id<FGPhotoBrowserDelegate>)delegate imageView:(UIImageView *)imageView withImageUrls:(NSArray<FGPhotoModel *> *)images index:(NSInteger)index{
    if (photo_Window == nil)
    {
        photo_Window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        photo_Window.windowLevel = UIWindowLevelNormal;
        photo_Window.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.];
        [photo_Window makeKeyAndVisible];
    }
    
    FGPhotoBrowser *browser = [[FGPhotoBrowser alloc]init];
    browser.showMultiImages = YES;
    browser.delegate = delegate;
    browser.currentIndex = index;
    browser.imageView = imageView;
    [browser.images addObjectsFromArray:images];
    photo_Window.rootViewController = browser;
    return browser;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor blackColor];
        self.images = [[NSMutableArray alloc]init];
    }
    return self;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.photoCollectView];
    self.photoCollectView.frame =  CGRectMake(0, TopViewHeight, FG_Screen_Width, CGRectGetHeight(self.view.bounds)-TopViewHeight);
    [self.view addSubview:self.bottomView];
    self.photoCollectView.frame =  CGRectMake(0, TopViewHeight, FG_Screen_Width, CGRectGetHeight(self.view.bounds)- TopViewHeight - BottomViewHeight);
    if ([self.delegate respondsToSelector:@selector(rigthItemButtonImageForFGPhotoBrowser:)]) {
        UIImage *image = [self.delegate rigthItemButtonImageForFGPhotoBrowser:self];
        if (image) {
            [self.topView.collectionButton setImage:image forState:UIControlStateNormal];
        }
    }
    [self configProgress:0];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self animationAtIndex:self.currentIndex];
}
-(void)animationAtIndex:(NSInteger)index{
    CGRect startFrame = [self.imageView.superview convertRect:self.imageView.frame toView:[UIApplication sharedApplication].keyWindow];
    CGRect endFrame = [self frameForImage];
    _endTempFrame = endFrame;
    
    [self.photoCollectView setContentOffset:CGPointMake(FG_Screen_Width * index,0) animated:NO];
    UIImageView *tempImageView = [[UIImageView alloc] initWithFrame:startFrame];
    tempImageView.image = self.imageView.image;
    tempImageView.contentMode = UIViewContentModeScaleAspectFit;
    [[UIApplication sharedApplication].keyWindow addSubview:tempImageView];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        tempImageView.frame = endFrame;
        
    } completion:^(BOOL finished) {
        self.photoCollectView.hidden = NO;
        [tempImageView removeFromSuperview];
        
    }];
    
}

-(CGRect)frameForImage{
    if (self.imageView.image) {
        UIImage *image = self.imageView.image;

        CGRect tempFrame = FG_Screen_Rect;
        CGFloat ratio = image.size.width / image.size.height;
        
        if (ratio > FG_Screen_Width / FG_Screen_Height) {
            
            tempFrame.size.width = FG_Screen_Width;
            tempFrame.size.height = FG_Screen_Width / ratio;
            
        } else {
            tempFrame.size.height = FG_Screen_Height;
            tempFrame.size.width = FG_Screen_Height * ratio;
            
        }
        tempFrame.origin.x = (FG_Screen_Width - tempFrame.size.width) / 2;
        tempFrame.origin.y = (FG_Screen_Height - tempFrame.size.height + TopViewHeight - BottomViewHeight) / 2;
        return tempFrame;
    }
    
    return FG_Screen_Rect;
    
}
-(void)backButtonAction{
    CGRect endFrame = [self.imageView.superview convertRect:self.imageView.frame toView:[UIApplication sharedApplication].keyWindow];
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithFrame:_endTempFrame];
    tempImageView.image = self.imageView.image;
    tempImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.photoCollectView.hidden = YES;
    
    [[UIApplication sharedApplication].keyWindow addSubview:tempImageView];
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        tempImageView.frame = endFrame;
        self.view.alpha = 0;
    } completion:^(BOOL finished) {
       
        [tempImageView removeFromSuperview];
        self.imageView = nil;
        photo_Window.rootViewController = nil;
        if (photo_Window) {
            photo_Window.hidden = YES;
            photo_Window = nil;
            
        }
    }];
}
-(void)collectionButtonAction{
    if (self.showMultiImages) {
        if ([self.delegate respondsToSelector:@selector(rightButtonItemDidTipAtIndex:)]) {
            [self.delegate rightButtonItemDidTipAtIndex:self.indexPath.section];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(rightButtonItemDidTipAtIndex:)]) {
            [self.delegate rightButtonItemDidTipAtIndex:self.currentPageIndex];
        }
    }
}
-(void)loadMore:(NSArray*)photos{
    [self.images addObjectsFromArray:photos];
    [self.photoCollectView reloadData];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger contentOffsetX = scrollView.contentOffset.x;
    NSInteger index =  contentOffsetX / CGRectGetWidth(scrollView.frame);
    self.currentPageIndex = index;
    [self configProgress:index];
}
-(void)configProgress:(NSInteger)index{
    NSLog(@"index = %d",index);
    if (self.showMultiImages) {
        NSInteger count = 0;
        BOOL find = NO;
        for (int i = 0; i< [self.images count]; i++) {
            FGPhotoModel *model = self.images[i];
            for (int j = 0; j <[model.childrens count]; j++) {
                if (count >= index) {
                    self.indexPath = [NSIndexPath indexPathForRow:j inSection:i];
                    find = YES;
                    break;
                }
                count++;
            }
            if (find) {
                break;
            }
        }
        FGPhotoModel *model = self.images[self.indexPath.section];
        self.bottomView.titleLabel.text = model.title;
        self.bottomView.progressLabel.text = [NSString stringWithFormat:@"%zd/%zd",self.indexPath.row+1,[model.childrens count]];
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
   
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSInteger contentOffsetX = scrollView.contentOffset.x;
    NSInteger contentSizeW = scrollView.contentSize.width;
    NSLog(@"contentOffsetX %ld",contentOffsetX);
    NSLog(@"contentSizeW %ld",contentSizeW);
    if (contentOffsetX + CGRectGetWidth(scrollView.frame)>= contentSizeW) {
        //到头了
        NSLog(@"到头了");
        if ([self.delegate respondsToSelector:@selector(FGPhotoBrowser:didScrollToEnd:)]) {
           [self.delegate FGPhotoBrowser:self didScrollToEnd:self.currentIndex];
        }
    }
}
#pragma mark -

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.showMultiImages) {
        FGPhotoModel *model = self.images[section];
        return [model.childrens count];
    }
    return [self.images count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (self.showMultiImages) {
      return [self.images count];
    }
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FGPhotoCollectionViewCell *cell =
    (FGPhotoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"FGPhotoCollectionViewCell"forIndexPath:indexPath];
     [cell resetZoomingScale];
    if (self.showMultiImages) {
        FGPhotoModel *model = self.images[indexPath.section];
        FGPhotoModel *subModel = model.childrens[indexPath.row];
        if (subModel.image) {
            cell.imageView.image = subModel.image;
        }else{
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:subModel.imageUrl]];
        }
    }else{
        FGPhotoModel *model = self.images[indexPath.row];
        if (model.image) {
            cell.imageView.image = model.image;
        }else{
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
        }
    }
    return cell;
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.photoCollectView.bounds.size;
}
#pragma mark - getters and setters
-(UICollectionView *)photoCollectView{
    if (!_photoCollectView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        _photoCollectView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        _photoCollectView.pagingEnabled = YES;
        _photoCollectView.hidden = YES;
        _photoCollectView.showsHorizontalScrollIndicator = NO;
        _photoCollectView.dataSource = self;
        _photoCollectView.delegate = self;
        [_photoCollectView registerClass:[FGPhotoCollectionViewCell class] forCellWithReuseIdentifier:@"FGPhotoCollectionViewCell"];
    }
    return _photoCollectView;
}
-(FGPhotoTopView *)topView{
    if (!_topView) {
        _topView = [[FGPhotoTopView alloc]initWithFrame:CGRectMake(0, 0, FG_Screen_Width, TopViewHeight)];
        [_topView.backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
         [_topView.collectionButton addTarget:self action:@selector(collectionButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _topView;
}
-(FGPhotoBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[FGPhotoBottomView alloc]initWithFrame:CGRectMake(0, FG_Screen_Height - BottomViewHeight, FG_Screen_Width,BottomViewHeight)];
    }
    return _bottomView;
}
@end
