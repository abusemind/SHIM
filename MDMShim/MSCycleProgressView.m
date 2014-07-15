//
//  MSCycleProgressView.m
//  CycleProgressView
//
//  Created by Michael Fei on 7/10/14.
//  Copyright (c) 2014 Morgan Stanley. All rights reserved.
//

#import "MSCycleProgressView.h"

#import <QuartzCore/QuartzCore.h>

double lineWidth = 2.5;
double borderWidth = 1.6;


@implementation MSCycleProgressView
{
    CAShapeLayer *_backgroundRingLayer;
    CAShapeLayer *_ringLayer;
    
    UIView *_centerView;
    BOOL _isLoading;
    BOOL _isAnimating;
}

@synthesize progress = _progress;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self sharedSetup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self sharedSetup];
    }
    return self;
}

- (void)sharedSetup {
    _centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width/3.3
                                                           , self.bounds.size.height/3.3)];
    _centerView.backgroundColor = self.tintColor;
    [self addSubview:_centerView];
    _centerView.center = CGPointMake( self.bounds.size.width / 2, self.bounds.size.height / 2);
    
	_progress = 0.0;
    _isLoading = NO;
    _isAnimating = NO;
}

- (void)tintColorDidChange {
    
    [super tintColorDidChange];
	
	[self updateLayerProperties];
}


//Override
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //lazy
    if(!_backgroundRingLayer)
    {
        _backgroundRingLayer = [CAShapeLayer new];
        [self.layer addSublayer:_backgroundRingLayer];
        
        
        //UIBezierPath
        CGRect rect = CGRectInset(self.bounds, borderWidth/2.0, borderWidth/2.0);
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:rect];
        
        _backgroundRingLayer.path = bezierPath.CGPath;
        _backgroundRingLayer.fillColor = nil;
        _backgroundRingLayer.lineWidth = borderWidth;
        _backgroundRingLayer.strokeColor = self.tintColor.CGColor;
    }
    _backgroundRingLayer.frame = self.layer.bounds;
    
    if(!_ringLayer)
    {
        _ringLayer = [CAShapeLayer new];
        
        CGRect innerRect = CGRectInset(self.bounds, borderWidth + lineWidth/2.0, borderWidth + lineWidth/2.0);
        UIBezierPath *innerPath = [UIBezierPath bezierPathWithOvalInRect:innerRect];
        
        _ringLayer.path = innerPath.CGPath;
        _ringLayer.fillColor = nil;
        _ringLayer.lineWidth = lineWidth;
        _ringLayer.strokeColor = self.tintColor.CGColor;
        _ringLayer.anchorPoint = CGPointMake(0.5, 0.5);
        _ringLayer.transform = CATransform3DRotate(_ringLayer.transform, -M_PI_2, 0, 0, 1);
        _ringLayer.lineCap = kCALineCapRound;
        
        [self.layer addSublayer:_ringLayer];
    }
    
    _ringLayer.frame = self.layer.bounds;

    [self updateLayerProperties];
}


#pragma mark - Properties
- (void) setProgress:(CGFloat)progress
{
    if(progress < 0) progress = 0;
    if(progress > 1) progress = 1;
    
    _progress = progress;

    if(progress > 0)
    {
        _isLoading = YES;
    }
    
    [self updateLayerProperties];
}

- (CGFloat) progress
{
    if(_ringLayer)
        return _ringLayer.strokeEnd;
    else
        return 0.0;
}

#pragma mark - Private Methods
- (void) updateLayerProperties
{
    if(_ringLayer){
        _ringLayer.strokeEnd = _progress;
        _ringLayer.strokeColor = self.tintColor.CGColor;
    }
    
    if(_backgroundRingLayer){
        _backgroundRingLayer.strokeColor = self.tintColor.CGColor;
    }
    
    if(_centerView){
        _centerView.backgroundColor = self.tintColor;
    }
    
    [self spiningIfNotLoading];
}

- (void) spiningIfNotLoading
{
    if(_backgroundRingLayer){
        
        if(!_isLoading && !_isAnimating)
        {
            _backgroundRingLayer.strokeEnd = 0.93;
            NSNumber *rotationAtStart = [_backgroundRingLayer valueForKeyPath:@"transform.rotation"];//0
            CABasicAnimation *myAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
            myAnimation.duration = 1.05;
            myAnimation.repeatCount = 1e50;
            myAnimation.fromValue = rotationAtStart;
            myAnimation.toValue = [NSNumber numberWithFloat:([rotationAtStart floatValue] + 2 * M_PI)];
            [_backgroundRingLayer addAnimation:myAnimation forKey:@"transform.rotation"];
            _isAnimating = YES;
            
            [_centerView setHidden:YES];
        }
        else if(_isLoading && _isAnimating)
        {
            _backgroundRingLayer.strokeEnd = 1;
            [_backgroundRingLayer removeAnimationForKey:@"transform.rotation"];
            _isAnimating = NO;
            
            [_centerView setHidden:NO];
        }
    }
}

@end
