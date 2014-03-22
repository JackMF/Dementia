//
//  ButtonListViewController.m
//  Dementia
//
//  Created by Chris on 22/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "ButtonListViewController.h"
#define kMinCellWidth 120.0f;
#define kMinCellHeight 60.0f;


@interface ButtonListViewController ()

@end

@implementation ButtonListViewController
@synthesize buttonLabelValues, oneItemPerRow;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
		buttonLabelValues = [NSArray array];
		oneItemPerRow = NO;
	}
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	[listCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
	[listCollectionView setAllowsMultipleSelection:YES];
}

-(NSInteger)getNumberOfCorrectAnswers
{
	return [[listCollectionView indexPathsForSelectedItems] count];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return [buttonLabelValues count];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return 1;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	// Get content for this cell
	NSString *labelContent = [buttonLabelValues objectAtIndex:[indexPath row]];
	NSDictionary *attributes = @{ NSFontAttributeName : [UIFont boldSystemFontOfSize:26.0] };
	CGSize suggestedSize = [labelContent sizeWithAttributes:attributes];
	if (oneItemPerRow) suggestedSize.width = self.view.frame.size.width;
	else suggestedSize.width = fmax(suggestedSize.width+10, 120.0f);
	suggestedSize.height = fmax(suggestedSize.height+10, 60.0f);
	return suggestedSize;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];

	// Make the background view
	UIView *bgView = [[UIView alloc] initWithFrame:cell.bounds];
	[bgView setBackgroundColor:[UIColor redColor]];
	cell.backgroundView = bgView;

	// Make the selected background view
	UIView *selectedBGView = [[UIView alloc] initWithFrame:cell.bounds];
	[selectedBGView setBackgroundColor:[UIColor greenColor]];
	cell.selectedBackgroundView = selectedBGView;

	// Populate the cell with the label
	UILabel *cellLabel = [[UILabel alloc] initWithFrame:cell.bounds];
	[cellLabel setTextAlignment:NSTextAlignmentCenter];
	[cellLabel setFont:[UIFont boldSystemFontOfSize:26.0]];
	NSString *labelValue = [buttonLabelValues objectAtIndex:[indexPath row]];
	[cellLabel setText:labelValue];
	[cell addSubview:cellLabel];

	return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
	[cell setSelected:YES];
//	cell.backgroundColor = [UIColor greenColor];
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
	UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
	[cell setSelected:NO];

//	[cell setBackgroundColor:[UIColor redColor]];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
