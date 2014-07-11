//
//  ApplicationSmallCell.h
//  MDMShim
//
//  Created by Michael Fei on 7/11/14.
//  Copyright (c) 2014 Morgan Stanley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApplicationSmallCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *appTitleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *appIcon;

@end
