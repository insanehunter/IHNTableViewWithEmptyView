/*
 * (c) Sergei Cherepanov, 2012
 *
 * Based on PGTableViewWithEmptyView.h by Pete Goodliffe.
 */
#import <UIKit/UIKit.h>

@interface IHNTableViewWithEmptyView : UITableView

// Let touches pass through. Defaults to NO.
@property(nonatomic, assign) BOOL passTouches;

// View to display when table is empty.
@property(nonatomic, strong) IBOutlet UIView *emptyView;

@end
