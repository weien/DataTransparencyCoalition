//
//  SpeakersViewController.m
//  DataTransparencyCoalition
//
//  Created by Weien Wang on 2/3/15.
//  Copyright (c) 2015 Data Transparency Coalition. All rights reserved.
//

#import "SpeakersViewController.h"
#import "UIColor+Custom.h"
#import "DTCUtil.h"
#import "Constants.h"
#import "ParseWebService.h"
#import "UIViewController+DTC.h"
#import "CustomSpeakerTileCell.h"
#import "UIImageView+WebCache.h"
#import "IndividualViewController.h"

//#import <Parse/Parse.h>

@interface SpeakersViewController() <UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UICollectionView *mainCollectionView;
@property (strong, nonatomic) IBOutlet UICollectionViewFlowLayout *customLayout;
@property (strong, nonatomic) UIActivityIndicatorView* spinner;
@property (strong, nonatomic) NSArray *speakersData;
@property (strong, nonatomic) IndividualViewController *individualVC;

@end

@implementation SpeakersViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Speakers";
    
    self.mainCollectionView.delegate = self;
    self.mainCollectionView.dataSource = self;
    self.mainCollectionView.backgroundColor = [UIColor grayColorVeryLight];
    
    float cellWidth = CGRectGetWidth(self.view.frame)/2;
    self.customLayout.itemSize = CGSizeMake(cellWidth, cellWidth*1.05);
    self.customLayout.minimumInteritemSpacing = 0;
    self.customLayout.minimumLineSpacing = 0;
    
//    self.speakersData = [DTCUtil plistDataWithComponent:kPlistComponentForCurrentSpeakersData];
//    if (!self.speakersData) {
        self.spinner = [self startSpinner:self.spinner inView:self.view];
//    }
//    else {
//        [self sortAndDisplayData];
//    }
    
    dispatch_async(dispatch_queue_create("getSpeakersData", NULL), ^{
        NSArray* speakersDataFromParse = [[ParseWebService sharedInstance] retrieveSpeakersDataForConference:[DTCUtil plistDataWithComponent:kPlistComponentForConferenceMetadata][@"conferenceId"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self stopSpinner:self.spinner];
//            [DTCUtil saveDataToPlistWithComponent:kPlistComponentForCurrentSpeakersData andInfo:speakersDataFromParse];
            self.speakersData = speakersDataFromParse;
            [self sortAndDisplayData];
        });
    });
}

- (void) sortAndDisplayData {
    self.speakersData = [self.speakersData sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"lastName" ascending:YES]]];
    [self.mainCollectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.speakersData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CustomSpeakerTileCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    //cell.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary* currentData = self.speakersData[[indexPath row]];
    
    cell.speakerImage.image = nil;
    cell.speakerImage.file = currentData[@"picture"];
    [cell.speakerImage loadInBackground];
    
    //NSString* speakerURL = currentData[@"pictureUrl"];
    //cell.speakerImage.image = [UIImage imageNamed:@"gray"];
    //the old way caused the images to jump around horribly
    /* [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:speakerURL] options:SDWebImageHighPriority
                                                   progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                   }
                                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                                      if (image) {
                                                          cell.speakerImage.image = image;
                                                      }
                                                      if (error) {
                                                          NSLog(@"Error getting speaker image: %@", error);
                                                          //cell.speakerImage.image = [UIImage imageNamed:@"gray"];
                                                      }
                                                  }]; */
    
    cell.speakerName.text = [[NSString stringWithFormat:@"%@ %@", currentData[@"firstName"], currentData[@"lastName"]] uppercaseString];
    cell.speakerTitle.text = currentData[@"title"];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    CustomSpeakerTileCell *cell = (CustomSpeakerTileCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.speakerImage.layer.borderColor = [UIColor grayColorMountainMist].CGColor;
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    CustomSpeakerTileCell *cell = (CustomSpeakerTileCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.speakerImage.layer.borderColor = [UIColor grayColorThunder].CGColor;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary* currentData = self.speakersData[[indexPath row]];
    CustomSpeakerTileCell* currentCell = (CustomSpeakerTileCell*)[collectionView cellForItemAtIndexPath:indexPath];
    
    if (!self.individualVC) {
        NSString* identifier = @"IndividualViewController";
        UIStoryboard* storyboard = [DTCUtil currentStoryboard];
        self.individualVC = [storyboard instantiateViewControllerWithIdentifier:identifier];
    }
    self.individualVC.speakerData = currentData;
    self.individualVC.speakerImage = currentCell.speakerImage.image;
    [self.navigationController pushViewController:self.individualVC animated:YES];
}
@end
