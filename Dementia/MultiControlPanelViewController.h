//
//  MultiControlPanelViewController.h
//  Dementia
//
//  Created by Chris on 31/05/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "ControlPanelViewController.h"

@interface MultiControlPanelViewController : ControlPanelViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
	NSArray *buttonTitles;
	NSArray *buttonValues;
	__weak IBOutlet UICollectionView *buttonCollectionView;
}
@property (nonatomic) int answerScore;
-(void)setButtonTitles:(NSArray *)titles andValues:(NSArray *) values;
-(void)updateButtonValues:(NSArray *)newValues;
@end
