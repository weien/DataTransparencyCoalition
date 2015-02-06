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

@interface SpeakersViewController() <UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UICollectionView *mainCollectionView;
@property (strong, nonatomic) UIActivityIndicatorView* spinner;
@property (strong, nonatomic) NSArray *speakerData;

@end

@implementation SpeakersViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainCollectionView.delegate = self;
    self.mainCollectionView.dataSource = self;
    self.mainCollectionView.backgroundColor = [UIColor grayColorVeryLight];

    //for individual speaker pages, use textview so we can get free URL detection
    
    self.speakerData = [DTCUtil plistDataWithComponent:kPlistComponentForCurrentSpeakersData];
    if (!self.speakerData) {
        self.spinner = [self startSpinner:self.spinner inView:self.view];
    }
    
    dispatch_async(dispatch_queue_create("getSpeakersData", NULL), ^{
//        NSArray* programDataFromParse = [[ParseWebService sharedInstance] retrieveProgramDataForConference:[DTCUtil plistDataWithComponent:kPlistComponentForConferenceMetadata][@"conferenceId"]];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self stopSpinner:self.spinner];
//            [DTCUtil saveDataToPlistWithComponent:kPlistComponentForCurrentProgramData andInfo:programDataFromParse];
//            
//            [self.mainCollectionView reloadData];
//        });
    });
    
}
@end
