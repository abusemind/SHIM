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

static NSString *const cellId = @"ApplicationSmallCell";

@interface WelcomeScreenViewController ()
{
    BOOL _pageControlBeingUsed;
}

@property (nonatomic, strong) NSMutableArray *applications;

@property (weak, nonatomic) IBOutlet UILabel *morganstanley;
@property (weak, nonatomic) IBOutlet UILabel *enterpriseAppStore;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation WelcomeScreenViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _pageControlBeingUsed = NO;
    
    UIColor *defaultBGColor = [UIColor colorWithRed:239.0/255 green:223.0/255 blue:222.0/255 alpha:1];
    self.morganstanley.backgroundColor = defaultBGColor;
    
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = defaultBGColor;
    
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = 1;
    
    [self setupCollectionView];
    [self setupFakeData];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void) setupCollectionView
{
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    UICollectionViewFlowLayout* layout = [UICollectionViewFlowLayout new];

    
    layout.minimumLineSpacing = 0.0;
    layout.minimumInteritemSpacing = 0.0;
    layout.itemSize = CGSizeMake(self.collectionView.frame.size.width/3, 90);
    
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.collectionViewLayout = layout;
    
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.contentSize = self.collectionView.bounds.size;
    
    [self.collectionView registerNib:[UINib nibWithNibName:cellId bundle:nil] forCellWithReuseIdentifier:cellId];
}

- (void) setupFakeData
{
    NSArray *urls = @[@"www.sina.com", @"www.baidu.com", @"www.youku.com", @"www.sohu.com"];
    
    self.applications = [NSMutableArray new];
    
    for(int i = 0; i < 100; i++)
    {
        MDMApplication *app = [MDMApplication new];
        app.name = [NSString stringWithFormat:@"App: %d", i];
        app.url = [urls objectAtIndex:(i%4)];
        app.id = i;
        app.description =
            [NSString stringWithFormat:@"This is a very long description text for app: %d. This is the end", i];
        [self.applications addObject:app];
    }
    
    [self reload];
}

- (void) reload
{
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView invalidateIntrinsicContentSize];
    [self.collectionView reloadData];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"%f", self.collectionView.contentSize.width);
        NSLog(@"%f", self.collectionView.bounds.size.width);
        
        self.pageControl.numberOfPages = ceil(self.collectionView.contentSize.width / self.collectionView.bounds.size.width);
    });
}

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
            cell.appTitleLabel.textColor = [UIColor blackColor];
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

#pragma mark - scroll view delegate
- (void)scrollViewDidScroll:(UIScrollView *)sender {
	if (!_pageControlBeingUsed) {
		// Switch the indicator when more than 50% of the previous/next page is visible
		CGFloat pageWidth = self.collectionView.frame.size.width;
        int page = ceil(self.collectionView.contentOffset.x / pageWidth);
		self.pageControl.currentPage = page;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	_pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
	_pageControlBeingUsed = NO;
}

#pragma mark - rotation
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self reload];
}

- (IBAction)changePage:(id)sender {
    
    NSLog(@"%d", self.pageControl.currentPage);
    
}


@end
