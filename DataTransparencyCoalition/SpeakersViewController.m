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

#import <Parse/Parse.h>

@interface SpeakersViewController() <UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UICollectionView *mainCollectionView;
@property (strong, nonatomic) IBOutlet UICollectionViewFlowLayout *customLayout;
@property (strong, nonatomic) UIActivityIndicatorView* spinner;
@property (strong, nonatomic) NSArray *speakersData;

@end

@implementation SpeakersViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Speakers";
    
    self.mainCollectionView.delegate = self;
    self.mainCollectionView.dataSource = self;
    self.mainCollectionView.backgroundColor = [UIColor grayColorVeryLight];
    
    float cellWidth = CGRectGetWidth(self.view.frame)/2;
    self.customLayout.itemSize = CGSizeMake(cellWidth, cellWidth*1.1);
    self.customLayout.minimumInteritemSpacing = 0;
    self.customLayout.minimumLineSpacing = 0;

    //for individual speaker pages, use textview so we can get free URL detection
    
    self.speakersData = [DTCUtil plistDataWithComponent:kPlistComponentForCurrentSpeakersData];
    if (!self.speakersData) {
        self.spinner = [self startSpinner:self.spinner inView:self.view];
    }
    
    dispatch_async(dispatch_queue_create("getSpeakersData", NULL), ^{
        NSArray* speakersDataFromParse = [[ParseWebService sharedInstance] retrieveSpeakersDataForConference:[DTCUtil plistDataWithComponent:kPlistComponentForConferenceMetadata][@"conferenceId"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self stopSpinner:self.spinner];
            NSArray* sortedSpeakers = [speakersDataFromParse sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"lastName" ascending:YES]]];
            [DTCUtil saveDataToPlistWithComponent:kPlistComponentForCurrentSpeakersData andInfo:sortedSpeakers];
            
            self.speakersData = sortedSpeakers;
            [self.mainCollectionView reloadData];
        });
    });
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.speakersData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CustomSpeakerTileCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    NSDictionary* currentData = self.speakersData[[indexPath row]];
    
    cell.speakerImage.image = nil;
    
    NSString* speakerURL = currentData[@"picture"];
//    dispatch_async(dispatch_queue_create("getPicture", NULL), ^{
//        NSData* pictureData = [NSData dataWithContentsOfURL:[NSURL URLWithString:speakerURL]];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            CustomSpeakerTileCell* updateCell = (CustomSpeakerTileCell*)[collectionView cellForItemAtIndexPath:indexPath];
//            if (updateCell) {
//                cell.speakerImage.image = [UIImage imageWithData:pictureData];
//            }
//        });
//    });
    
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:speakerURL] options:SDWebImageRetryFailed
                                                   progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                   }
                                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                                      cell.speakerImage.image = image;
                                                  }];
    
//    [speakerImageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
//        if (!error) {
//            cell.speakerImage.image = [UIImage imageWithData:data];
//        }
//        else {
//            NSLog(@"Error downloading speaker image: %@", error);
//        }
//    }];
    
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

}
@end
