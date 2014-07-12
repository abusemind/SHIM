#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <Accelerate/Accelerate.h>

#pragma mark - others
typedef NS_ENUM(NSInteger, BTPopUpStyle) {
    BTPopUpStyleDefault,
    BTPopUpStyleMinimalRoundedCorner
};

typedef NS_ENUM(NSInteger, BTPopUpBorderStyle) {
    BTPopUpBorderStyleDefaultNone,
    BTPopUpBorderStyleLightContent,
    BTPopUpBorderStyleDarkContent
};

#pragma mark - item
@interface BTPopUpItemView : UIView

- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title action:(dispatch_block_t)action;

- (instancetype)initWithImageURL: (NSURL *) url
                placeholderImage: (UIImage *) placeholder
                           title: (NSString *)title
                          action: (dispatch_block_t)action;

@end

#pragma mark - menu
@interface PopupView : UIView <UIScrollViewDelegate>

@property (nonatomic, assign) BTPopUpStyle popUpStyle;
@property (nonatomic, assign) BTPopUpBorderStyle popUpBorderStyle;
@property (nonatomic, assign) UIColor *popUpBackgroundColor;
@property (nonatomic) BOOL setShowRipples;

- (instancetype) initWithItems: (NSArray *) items addToViewController:(UIViewController*)sender;

-(void)setPopUpBackgroundColor:(UIColor *)popUpBackgroundColor;

-(void)show;
-(void)dismiss;

@end


