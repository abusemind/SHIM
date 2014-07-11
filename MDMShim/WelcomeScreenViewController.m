//
//  WelcomeScreenViewController.m
//  MDMShim
//
//  Created by Michael Fei on 7/11/14.
//  Copyright (c) 2014 Morgan Stanley. All rights reserved.
//

#import "WelcomeScreenViewController.h"
#import "ApplicationSmallCell.h"
#import "MDMApplication.h"

#import <Cordova/CDVAvailability.h>

static NSString *const cellId = @"ApplicationSmallCell";

@interface WelcomeScreenViewController ()
{
    BOOL _pageControlBeingUsed;
    
    int _currentPage;
    int _firstIndex;
    
    int _numberOfItemsPerRow;
    int _itemDefaultHeight;
}

@property (nonatomic, strong) NSMutableArray *applications;

@property (weak, nonatomic) IBOutlet UILabel *morganstanley;
@property (weak, nonatomic) IBOutlet UILabel *enterpriseAppStore;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;


@end

@implementation WelcomeScreenViewController

#pragma mark - UIViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    _pageControlBeingUsed = NO;
    _numberOfItemsPerRow = CDV_IsIPad()? 2:1;
    _itemDefaultHeight   = CDV_IsIPad()? 150: 115;
    
    UIColor *defaultBGColor = [UIColor colorWithRed:239.0/255 green:223.0/255 blue:222.0/255 alpha:1];
    self.morganstanley.backgroundColor = self.view.backgroundColor = defaultBGColor;
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = 1;
    self.pageControl.userInteractionEnabled = NO;
    self.pageControl.hidden = CDV_IsIPad()? NO:YES;
    
    [self setupCollectionView];
    [self setupFakeData];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration
{
    int numberOfItemsInPage = floor(self.collectionView.bounds.size.height / _itemDefaultHeight) * _numberOfItemsPerRow;
    
    int currentPage = self.pageControl.currentPage;
    _firstIndex = currentPage * numberOfItemsInPage;
    
    [self.collectionView.collectionViewLayout invalidateLayout];
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    
    self.pageControl.numberOfPages = ceil(self.collectionView.contentSize.width / self.collectionView.bounds.size.width);
    
    [self.collectionView setContentOffset:CGPointMake(0, 0) animated:NO];
    
    //make sure the first item before rotation is still visible after rotating
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        int countInAPage = [[self.collectionView indexPathsForVisibleItems] count];
        
        int pageOffset = floor(_firstIndex/countInAPage);
        [self.collectionView
            setContentOffset:CGPointMake(pageOffset * self.view.bounds.size.width, 0) animated:NO];
        [self.collectionView.collectionViewLayout invalidateLayout];
    });
}

#pragma mark - Private
- (void) setupCollectionView
{
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    UICollectionViewFlowLayout* layout = [UICollectionViewFlowLayout new];
    
    layout.minimumLineSpacing = 1.0;
    layout.minimumInteritemSpacing = 1.0;
    
    layout.scrollDirection = CDV_IsIPad()? UICollectionViewScrollDirectionHorizontal:UICollectionViewScrollDirectionVertical;
    
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.pagingEnabled = CDV_IsIPad()?YES:NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    [self.collectionView registerNib:[UINib nibWithNibName:cellId bundle:nil] forCellWithReuseIdentifier:cellId];
}

- (void) setupFakeData
{
    NSArray *urls = @[@"www.sina.com", @"www.baidu.com", @"www.youku.com", @"www.sohu.com"];
    
    self.applications = [NSMutableArray new];
    
    for(int i = 0; i < 30; i++)
    {
        MDMApplication *app = [MDMApplication new];
        app.name = [NSString stringWithFormat:@"App: %d", i];
        app.url = [urls objectAtIndex:(i%4)];
        app.id = i;
        app.description =
        [NSString stringWithFormat:@"This is a very long description text for app: %d. This is the end. This is a very long description text for app. This is the end. This is a very long description text for app. This is the end.", i];
        [self.applications addObject:app];
    }
    
    [self.collectionView reloadData];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.pageControl.numberOfPages = ceil(self.collectionView.contentSize.width / self.collectionView.bounds.size.width);
    });
}


#pragma mark - UICollection Delegates
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.applications count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ApplicationSmallCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:cellId
                                                                           forIndexPath:indexPath];

    if(cell)
    {
        MDMApplication *app = [self.applications objectAtIndex:indexPath.item];
        if(app)
        {
            cell.appTitleLabel.text = app.name;
            cell.description.text = app.description;
            cell.description.backgroundColor = [UIColor clearColor];
            cell.appIcon.image = [UIImage imageNamed:@"application.png"];
        }
        
        cell.appTitleLabel.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
    }

    return cell;

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout  *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.collectionView.bounds.size.width/_numberOfItemsPerRow, _itemDefaultHeight);
}

#pragma mark - Scroll view delegate (Update PageControl's current page)
- (void)scrollViewDidScroll:(UIScrollView *)sender {
	if (!_pageControlBeingUsed && CDV_IsIPad()) {
		CGFloat pageWidth = self.collectionView.frame.size.width;
        int page = ceil(self.collectionView.contentOffset.x / pageWidth);
		self.pageControl.currentPage = page;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	if(CDV_IsIPad()) _pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if(CDV_IsIPad()) _pageControlBeingUsed = NO;
}


@end
