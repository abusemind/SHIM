//
//  WelcomeScreenViewController.m
//  MDMShim
//
//  Created by Michael Fei on 7/11/14.
//  Copyright (c) 2014 Morgan Stanley. All rights reserved.
//

#import "WelcomeScreenViewController.h"
#import "ApplicationSmallCell.h"
#import "PassengerAppHybridViewController.h"
#import "SpringnyFlowLayout.h"
#import "CustomSegue.h"
#import "CustomUnwindSegue.h"

#import <Cordova/CDVAvailability.h>

//If you want to support landscape in iPhone for this welcome screen, set to NO
#define USE_SPRINGNI_IN_IPHONE YES
#define CELL_SELECTED_MASK_VIEW_TAG 3356

static NSString *const cellId = @"ApplicationSmallCell";

@interface WelcomeScreenViewController ()
{
    BOOL _pageControlBeingUsed;

    int _firstIndexBeforeRotation;
    int _numberOfItemsPerRow;
    int _itemDefaultHeight;
    
    int _topContentInsect;
    int _bottomContentInsect;
    
    CGPoint _originatingPoint;
}

@property (weak, nonatomic) IBOutlet UILabel *morganstanley;
@property (weak, nonatomic) IBOutlet UILabel *enterpriseAppStore;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIView *bannerView;

@end

@implementation WelcomeScreenViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    _pageControlBeingUsed = NO;
    _numberOfItemsPerRow = CDV_IsIPad()? 2: 1;
    _itemDefaultHeight   = CDV_IsIPad()? 150: 115;
    _topContentInsect    = CDV_IsIPad()? 0: 80;
    _bottomContentInsect = CDV_IsIPad()? 0: 40;
    
    
    UIColor *defaultBGColor = [UIColor colorWithRed:222.0/255 green:231.0/255 blue:239.0/255 alpha:1];
    self.morganstanley.backgroundColor = self.view.backgroundColor = defaultBGColor;
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = 1;
    self.pageControl.userInteractionEnabled = NO;
    self.pageControl.hidden = CDV_IsIPad()? NO:YES;
    
    [self setupCollectionView];
    [self setupFakeData];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.collectionView.collectionViewLayout invalidateLayout];
    
    if(self.passengerAppToOpen != nil && self.bouncingImmediately)
    {
        [self launchPassengerApp];
    }
}

- (NSUInteger) supportedInterfaceOrientations
{
    if(USE_SPRINGNI_IN_IPHONE && !CDV_IsIPad()){
        //iPhone's springny layout would break autolayout when rotation
        return UIInterfaceOrientationMaskPortrait;
    }
    else{
        return UIInterfaceOrientationMaskAll;
    }
}

#pragma mark - Setup
- (void) setupCollectionView
{
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    UICollectionViewFlowLayout* layout =
        CDV_IsIPad()? [UICollectionViewFlowLayout new]:
                    USE_SPRINGNI_IN_IPHONE? [SpringnyFlowLayout new]: [UICollectionViewFlowLayout new];
    
    layout.minimumLineSpacing = 1.0;
    layout.minimumInteritemSpacing = 1.0;
    layout.sectionInset = CDV_IsIPad()? UIEdgeInsetsMake(30, 0, 0, 0): UIEdgeInsetsMake(12, 0, 0, 0);
    layout.scrollDirection = CDV_IsIPad()?
        UICollectionViewScrollDirectionHorizontal:UICollectionViewScrollDirectionVertical;
    self.collectionView.contentInset = UIEdgeInsetsMake(_topContentInsect, 0, _bottomContentInsect, 0);
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.pagingEnabled = CDV_IsIPad()?YES:NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    [self.collectionView registerNib:[UINib nibWithNibName:cellId bundle:nil] forCellWithReuseIdentifier:cellId];
}

//TODO: Delete using fake data!
- (void) setupFakeData
{
    NSArray *urls = @[@"www.sina.com", @"www.google.com", @"www.youku.com", @"www.sohu.com"];
    
    self.applications = [NSMutableArray new];
    
    for(int i = 1; i < 40; i++)
    {
        MDMApplication *app = [MDMApplication new];
        app.name = [NSString stringWithFormat:@"App: %d", i];
        app.url = [urls objectAtIndex:(i%4)];
        app.appId = i;
        app.description =
        [NSString stringWithFormat:@"This is a very long description text for app: %d. This is the end. This is a very long description text for app. This is the end. This is a very long description text for app. This is the end.", i];
        [self.applications addObject:app];
    }
    
    [self.collectionView reloadData];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.pageControl.numberOfPages = ceil((double)[self.applications count] /  [self.collectionView.visibleCells count]);
    });
}

#pragma mark - Rotate
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration
{
    //Important!
    [self.collectionView.collectionViewLayout invalidateLayout];
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    
    [self.collectionView setContentOffset:CGPointMake(_topContentInsect, 0) animated:NO];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.pageControl.numberOfPages = ceil((double)[self.applications count] /  [self.collectionView.visibleCells count]);
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
        //Visual
        cell.appTitleLabel.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
        
        //Logical
        MDMApplication *app = [self.applications objectAtIndex:indexPath.item];
        if(app)
        {
            cell.appTitleLabel.text = app.name;
            cell.description.text = app.description;
            cell.description.backgroundColor = [UIColor clearColor];
            [cell.appIcon setImageWithURL:[NSURL URLWithString:app.iconUrl]
                           placeholderImage:[UIImage imageNamed:@"application.png"] options:0];
        }
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //Visual
    ApplicationSmallCell *cell = (ApplicationSmallCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if(cell.selected)
    {
        CATransition *animation=[CATransition animation];
        [animation setDelegate:self];
        [animation setDuration:0.6];
        [animation setTimingFunction:UIViewAnimationCurveEaseInOut];
        [animation setType:@"rippleEffect"];
        
        [animation setFillMode:kCAFillModeRemoved];
        animation.endProgress=0.99;
        [animation setRemovedOnCompletion:NO];
        [cell.layer addAnimation:animation forKey:nil];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //Keep record of which point is clicked...
        CGPoint imageCenter = [cell convertPoint:cell.appIcon.center toView:collectionView];
        _originatingPoint = [collectionView convertPoint:imageCenter toView:self.view];
        
        
        //Logical
        MDMApplication *app = [self.applications objectAtIndex:indexPath.item];
        if(app && app.url != nil)
        {
            self.passengerAppToOpen = app;
            [self launchPassengerApp];
        }
    });
}

#pragma mark - Scroll view delegate (To Update PageControl's current page)
- (void)scrollViewDidScroll:(UIScrollView *)sender {
	if (!_pageControlBeingUsed && CDV_IsIPad())
    {
		CGFloat pageWidth = self.collectionView.frame.size.width;
        int page = ceil(self.collectionView.contentOffset.x / pageWidth);
		self.pageControl.currentPage = page;
    }
    
    if(!CDV_IsIPad()){
        CGFloat offset = self.collectionView.contentOffset.y + _topContentInsect;
        CGFloat alpha = 1- (offset / 3) / _topContentInsect;
        if(alpha < 0) alpha = 0;
        if(self.bannerView){
            if(alpha != 1)
                self.bannerView.userInteractionEnabled = NO;
            self.bannerView.alpha = alpha;
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	if(CDV_IsIPad()) _pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if(CDV_IsIPad()) _pageControlBeingUsed = NO;
}

#pragma mark - Segue and launch Passenger App
- (void) launchPassengerApp
{
    if(self.passengerAppToOpen != nil)
       [self performSegueWithIdentifier:SEGUE_LAUNCH_PASSENGER_APP sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //TODO: remove observers to notification center
    
    if([segue.identifier isEqualToString:SEGUE_LAUNCH_PASSENGER_APP] && [segue isKindOfClass:[CustomSegue class]]) {
        //setup PassengerAppViewController
        PassengerAppHybridViewController *destination = segue.destinationViewController;
        destination.passengerApp = self.passengerAppToOpen;
        destination.allApps = self.applications;
        
        //setup segue status
        CustomSegue *segueToPerform = (CustomSegue *) segue;
        segueToPerform.originatingPoint = _originatingPoint;
        
        //clean
        self.passengerAppToOpen = nil;
        self.bouncingImmediately = NO;
    }
}

- (UIStoryboardSegue *)segueForUnwindingToViewController:(UIViewController *)toViewController fromViewController:(UIViewController *)fromViewController identifier:(NSString *)identifier {
    // Instantiate a new CustomUnwindSegue
    CustomUnwindSegue *segue = [[CustomUnwindSegue alloc] initWithIdentifier:identifier source:fromViewController destination:toViewController];
    // Set the target point
    segue.targetPoint = _originatingPoint;
    //reset originating point
    _originatingPoint = self.view.center;
    return segue;
}

- (IBAction)returnToWelcome:(UIStoryboardSegue *)segue {
    
}

@end
