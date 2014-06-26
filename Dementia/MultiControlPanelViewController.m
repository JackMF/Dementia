//
//  MultiControlPanelViewController.m
//  Dementia
//
//  Created by Chris on 31/05/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "MultiControlPanelViewController.h"
#define kButtonHeight 80.0f;
#define kButtonsWidth 768.0f;

@interface MultiControlPanelViewController ()

@end

@implementation MultiControlPanelViewController
@synthesize answerScore;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
	}
	return self;
}

-(void)setButtonTitles:(NSArray *)titles andValues:(NSArray *) values
{
	buttonTitles = titles;
	buttonValues = values;
}

-(void)updateButtonValues:(NSArray *)newValues
{
	buttonValues = newValues;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	[buttonCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
	[buttonCollectionView setBackgroundColor:[UIColor colorWithWhite:0.667 alpha:0.500]];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return [buttonTitles count];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return 1;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	// Get content for this cell
	NSString *labelContent = [buttonTitles objectAtIndex:[indexPath row]];
	NSDictionary *attributes = @{ NSFontAttributeName : [UIFont boldSystemFontOfSize:26.0] };
	CGSize suggestedSize = [labelContent sizeWithAttributes:attributes];
	suggestedSize.width = (768.0f / [buttonTitles count]) - 10.0f;
	suggestedSize.height = kButtonHeight;
	return suggestedSize;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];

	// Make the background view
	UIView *bgView = [[UIView alloc] initWithFrame:cell.bounds];
	[bgView setBackgroundColor:[UIColor clearColor]];
	cell.backgroundView = bgView;

	// Make the selected background view
	UIView *selectedBGView = [[UIView alloc] initWithFrame:cell.bounds];
	UIColor *selectedColor = [UIColor colorWithRed:0.000 green:0.463 blue:1.000 alpha:0.2f];
	[selectedBGView setBackgroundColor:selectedColor];
	cell.selectedBackgroundView = selectedBGView;

	// Populate the cell with the label
	UILabel *cellLabel = [[UILabel alloc] initWithFrame:cell.bounds];
	[cellLabel setTextAlignment:NSTextAlignmentCenter];
	[cellLabel setFont:[UIFont boldSystemFontOfSize:26.0]];
	NSString *labelValue = [buttonTitles objectAtIndex:[indexPath row]];
	[cellLabel setText:labelValue];
	[cell addSubview:cellLabel];

	return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
	int index = (int) indexPath.row;
	answerScore = (int)[[buttonValues objectAtIndex:index] integerValue];
	[cell setSelected:YES];
	[confirmButton setHidden:NO];           // Show the confirm button
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
	UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
	[cell setSelected:NO];
}

-(void)decisionButtonPressed:(id)sender
{
	[self resetDecisionButtons];
}

// Resets the decision buttons to their original state
-(void)resetDecisionButtons
{
	for (int i=0; i<[buttonCollectionView numberOfItemsInSection:0]; i++)
		[buttonCollectionView deselectItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0] animated:YES];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
