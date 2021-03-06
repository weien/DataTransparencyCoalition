//
//  CustomSpeakerTileCell.h
//  DataTransparencyCoalition
//
//  Created by Weien Wang on 2/6/15.
//  Copyright (c) 2015 Data Transparency Coalition. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomSpeakerTileCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *speakerImage;
@property (strong, nonatomic) IBOutlet UILabel *speakerName;
@property (strong, nonatomic) IBOutlet UILabel *speakerTitle;

@end
