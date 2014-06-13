//
//  VisuospatialDotCountingViewController.h
//  Dementia
//
//  Created by Jack Fletcher on 27/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "TestViewController.h"
#import <UIKit/UIKit.h>

@interface VisuospatialDotCountingViewController : TestViewController
{
	NSArray *images;
	int currentScore;
	int currentImageOrder;
	__weak IBOutlet UIImageView *imageViewer;
}

@end
