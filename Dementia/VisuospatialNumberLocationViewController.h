//
//  VisuospatialNumberLocationViewController.h
//  Dementia
//
//  Created by Chris on 26/05/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "TestViewController.h"

@interface VisuospatialNumberLocationViewController : TestViewController
{
	NSArray *images;
	int currentScore;
	int currentImageOrder;
	__weak IBOutlet UIImageView *imageView;
}

@end
