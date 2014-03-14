//
//  DebugViewController.h
//  Dementia
//
//  Created by Chris on 14/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DebugViewController : UIViewController <UITableViewDataSource, UITabBarControllerDelegate>
{
    __weak IBOutlet UITableView *tableView;
    NSMutableArray *tests;
}

@end
