#import "ALAlertBanner.h"

#define AL_IOS_7_OR_GREATER [UIDevice iOSVersion] >= 7.0

@interface UIDevice (ALSystemVersion)

+ (float)iOSVersion;

@end

@interface UIApplication (ALApplicationBarHeights)

+ (CGFloat)navigationBarHeight;
+ (CGFloat)statusBarHeight;

@end

@class ALAlertBanner;
@protocol ALAlertBannerViewDelegate <NSObject>
@required
- (void)showAlertBanner:(ALAlertBanner *)alertBanner hideAfter:(NSTimeInterval)delay;
- (void)hideAlertBanner:(ALAlertBanner *)alertBanner forced:(BOOL)forced;
- (void)alertBannerWillShow:(ALAlertBanner *)alertBanner inView:(UIView *)view;
- (void)alertBannerDidShow:(ALAlertBanner *)alertBanner inView:(UIView *)view;
- (void)alertBannerWillHide:(ALAlertBanner *)alertBanner inView:(UIView *)view;
- (void)alertBannerDidHide:(ALAlertBanner *)alertBanner inView:(UIView *)view;
@end

@interface ALAlertBanner ()

@property (nonatomic, weak) id <ALAlertBannerViewDelegate> delegate;
@property (nonatomic) BOOL isScheduledToHide;
@property (nonatomic, copy) void(^tappedBlock)(ALAlertBanner *alertBanner);
@property (nonatomic) NSTimeInterval fadeInDuration;
@property (nonatomic) BOOL showShadow;
@property (nonatomic) BOOL shouldForceHide;

- (void)showAlertBanner;
- (void)hideAlertBanner;
- (void)pushAlertBanner:(CGFloat)distance forward:(BOOL)forward delay:(double)delay;
- (void)updateSizeAndSubviewsAnimated:(BOOL)animated;
- (void)updatePositionAfterRotationWithY:(CGFloat)yPos animated:(BOOL)animated;
- (id)nextAvailableViewController:(id)view;

@end