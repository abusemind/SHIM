#import <Foundation/Foundation.h>

@interface ALAlertBannerManager : NSObject

/**
 The global shared instance that manages the presentation and dismissal of alert banners.
 */
+ (ALAlertBannerManager *)sharedManager;

- (NSArray *)alertBannersInView:(UIView *)view;
- (void)hideAllAlertBanners;
- (void)hideAlertBannersInView:(UIView *)view;
- (void)forceHideAllAlertBannersInView:(UIView *)view;

@end
