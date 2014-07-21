//
//  SpringnyFlowLayout.m
//  MDMShim
//
//  Created by Michael Fei on 7/12/14.
//  Copyright (c) 2014 Morgan Stanley. All rights reserved.
//

#import "SpringnyFlowLayout.h"

@implementation SpringnyFlowLayout
{
    UIDynamicAnimator *_dynamicAnimator;
}


- (void) prepareLayout
{
    [super prepareLayout];
    
    //Setup
    if(!_dynamicAnimator){
        _dynamicAnimator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
        
        CGSize contentSize = [self collectionViewContentSize];
        
        NSArray *items = [super layoutAttributesForElementsInRect:CGRectMake(0, 0, contentSize.width, contentSize.height)];
        
        for(UICollectionViewLayoutAttributes *item in items){
            UIAttachmentBehavior *spring = [[UIAttachmentBehavior alloc] initWithItem:item attachedToAnchor:item.center];
            spring.length = 0;
            spring.damping = 0.9;
            spring.frequency = 0.95;
            
            [_dynamicAnimator addBehavior:spring];
        }
    }
}

- (NSArray *) layoutAttributesForElementsInRect:(CGRect)rect
{
    return [_dynamicAnimator itemsInRect:rect];
}

- (UICollectionViewLayoutAttributes *) layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [_dynamicAnimator layoutAttributesForCellAtIndexPath:indexPath];
}


-(BOOL) shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    //vertical scrolling is the only direction we care about
    UIScrollView *scrollView = self.collectionView;
    
    CGFloat delta = newBounds.origin.y - scrollView.bounds.origin.y;
    
    CGPoint touchLocation = [scrollView.panGestureRecognizer locationInView:scrollView];
    
    for(UIAttachmentBehavior *spring in [_dynamicAnimator behaviors]){
        CGPoint anchorPoint = spring.anchorPoint;
        CGFloat distanceFromTouch = fabsf(touchLocation.y - anchorPoint.y); //float absolute value
        CGFloat scrollResistence = distanceFromTouch / 1088;
        
        UICollectionViewLayoutAttributes *item = [spring.items firstObject];
        
        //shift layout attributes position by delta
        CGPoint center = item.center;
        
        if(delta > 0)
            center.y += MIN(delta, delta * scrollResistence);
        else
            center.y += MAX(delta, delta *scrollResistence);
        
        item.center = center;
        
        //notify UIDynamicAnimator
        [_dynamicAnimator updateItemUsingCurrentState:item];
    }
    
    return [super shouldInvalidateLayoutForBoundsChange:newBounds];
}

@end
