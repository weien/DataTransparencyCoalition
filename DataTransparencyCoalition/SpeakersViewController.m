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
    
    self.mainCollectionView.delegate = self;
    self.mainCollectionView.dataSource = self;
    self.mainCollectionView.backgroundColor = [UIColor grayColorVeryLight];
    
    self.customLayout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame)/2, CGRectGetWidth(self.view.frame)/2);
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
            [DTCUtil saveDataToPlistWithComponent:kPlistComponentForCurrentSpeakersData andInfo:speakersDataFromParse];
            
            self.speakersData = speakersDataFromParse;
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
    
    PFFile* speakerImageFile = currentData[@"picture"];
    [speakerImageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            cell.speakerImage.image = [UIImage imageWithData:data];
        }
        else {
            NSLog(@"Error downloading speaker image: %@", error);
        }
    }];
    
    cell.speakerName.text = currentData[@"name"];
    cell.speakerTitle.text = currentData[@"title"];
    
    cell.speakerImage.clipsToBounds = NO;
    cell.speakerImage.layer.cornerRadius = CGRectGetWidth(cell.speakerImage.frame)/2;
    cell.speakerImage.layer.masksToBounds = YES;
    cell.speakerImage.layer.borderWidth = 5.0f;
    cell.speakerImage.layer.borderColor = [UIColor grayColorThunder].CGColor;
    
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
