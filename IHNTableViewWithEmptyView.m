/*
 * (c) Sergei Cherepanov, 2012
 *
 * Based on PGTableViewWithEmptyView.h by Pete Goodliffe.
 */
#import "IHNTableViewWithEmptyView.h"
#import <QuartzCore/QuartzCore.h>

@implementation IHNTableViewWithEmptyView
- (BOOL) ihnHasRows
{
    NSInteger sectionCount = [self numberOfSections];
    for (NSInteger section = 0; section != sectionCount; ++section)
        if ([self numberOfRowsInSection:section] > 0)
            return YES;
    return NO;
}

- (void) ihnUpdateEmptyPage
{
    if (_emptyView == nil)
        return;
    
    BOOL shouldShowEmptyView = ![self ihnHasRows];
    BOOL emptyViewShown = (_emptyView.superview != nil);
    
    if ((shouldShowEmptyView && emptyViewShown) || (!shouldShowEmptyView && !emptyViewShown))
        return;
    
    const CGRect rect = (CGRect){CGPointZero, self.frame.size};
    _emptyView.frame = rect;
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.3f];
    [animation setType:kCATransitionFade];
    [animation setTimingFunction:
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [[self layer] addAnimation:animation forKey:kCATransitionReveal];
    
    if (shouldShowEmptyView)
        [self addSubview:_emptyView];
    else
        [_emptyView removeFromSuperview];
}

- (void) setEmptyView:(UIView *)newView
{
    if (newView == _emptyView)
        return;
    
    [_emptyView removeFromSuperview];
    _emptyView = newView;
    [self ihnUpdateEmptyPage];
}


#pragma mark - UIView & UITableView Overrides
- (void) reloadData
{
    [super reloadData];
    [self ihnUpdateEmptyPage];
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    [self ihnUpdateEmptyPage];
}

- (UIView *) hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    // Prevent any interaction when the empty view is shown
    const bool emptyViewShown = (_emptyView.superview != nil);
    return emptyViewShown ? nil : [super hitTest:point withEvent:event];
}
@end
