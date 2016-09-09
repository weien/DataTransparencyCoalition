//
//  CustomSpeakerTileCell.m
//  DataTransparencyCoalition
//
//  Created by Weien Wang on 2/6/15.
//  Copyright (c) 2015 Data Transparency Coalition. All rights reserved.
//

#import "CustomSpeakerTileCell.h"
#import "DTCUtil.h"
#import "UIColor+Custom.h"

@implementation CustomSpeakerTileCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.speakerImage.clipsToBounds = NO;
    self.speakerImage.layer.cornerRadius = CGRectGetWidth(self.speakerImage.frame)/2;
    self.speakerImage.layer.masksToBounds = YES;
    self.speakerImage.layer.borderWidth = 5.0f;
    self.speakerImage.layer.borderColor = [UIColor grayColorThunder].CGColor;
    
    self.speakerName.font = [DTCUtil currentBoldFontWithSize:14];
    self.speakerName.textColor = [UIColor grayColorVeryDark];
    self.speakerTitle.font = [DTCUtil currentMainFontWithSize:12];
    self.speakerTitle.textColor = [UIColor blueColorBlueDeFrance];
}
@end
