//
//  SponsorsViewController.m
//  DataTransparencyCoalition
//
//  Created by Weien Wang on 2/3/15.
//  Copyright (c) 2015 Data Transparency Coalition. All rights reserved.
//

#import "SponsorsViewController.h"
#import "UIColor+Custom.h"
#import "DTCUtil.h"
#import "Constants.h"
#import "ParseWebService.h"
#import "UIViewController+DTC.h"
#import "UIImageView+WebCache.h"
#import "CustomSponsorTileCell.h"
#import "SponsorSection.h"
#import "CustomSponsorHeaderView.h"

@interface SponsorsViewController() <UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UICollectionView *mainCollectionView;
@property (strong, nonatomic) IBOutlet UICollectionViewFlowLayout *customLayout;
@property (strong, nonatomic) UIActivityIndicatorView* spinner;
@property (strong, nonatomic) NSArray *sponsorsData;
@property (strong, nonatomic) NSArray *sectionData;

@end

@implementation SponsorsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Sponsors";
    
    self.mainCollectionView.delegate = self;
    self.mainCollectionView.dataSource = self;
    self.mainCollectionView.backgroundColor = [UIColor whiteColor];
    
    self.customLayout.minimumInteritemSpacing = 10;
    self.customLayout.minimumLineSpacing = 10;
    self.customLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    
    self.sponsorsData = [DTCUtil plistDataWithComponent:kPlistComponentForCurrentSponsorsData];
    if (!self.sponsorsData) {
        self.spinner = [self startSpinner:self.spinner inView:self.view];
    }
    else {
        [self sortAndDisplayData];
    }
    
    dispatch_async(dispatch_queue_create("getSponsorsData", NULL), ^{
        NSArray* sponsorsDataFromParse = [[ParseWebService sharedInstance] retrieveSponsorsDataForConference:[DTCUtil plistDataWithComponent:kPlistComponentForConferenceMetadata][@"conferenceId"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self stopSpinner:self.spinner];
            [DTCUtil saveDataToPlistWithComponent:kPlistComponentForCurrentSponsorsData andInfo:sponsorsDataFromParse];
            self.sponsorsData = sponsorsDataFromParse;
            [self sortAndDisplayData];
        });
    });
}

- (void) sortAndDisplayData {
    NSArray* allCategories = [self.sponsorsData valueForKey:@"category"];
    NSArray* uniqueCategories = [[NSSet setWithArray:allCategories] allObjects];
    
    NSMutableArray* categoriesToDisplay = [NSMutableArray array];
    for (NSString* categoryName in uniqueCategories) {
        NSArray* matchingItems = [self.sponsorsData filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(category == %@)", categoryName]];
        NSArray* sortedMatchingItems = [matchingItems sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
        
        SponsorSection* section = [SponsorSection new];
        section.sectionName = [sortedMatchingItems firstObject][@"category"];
        section.sectionRank = [[sortedMatchingItems firstObject][@"categoryRank"] integerValue];
        section.sectionItems = sortedMatchingItems;
        
        [categoriesToDisplay addObject:section];
    }
    
    categoriesToDisplay = [[categoriesToDisplay sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"sectionRank" ascending:YES]]] mutableCopy];
    self.sectionData = categoriesToDisplay;
    [self.mainCollectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sectionData.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    SponsorSection* currentSection = self.sectionData[section];
    return currentSection.sectionItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CustomSponsorTileCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    SponsorSection* currentSection = self.sectionData[indexPath.section];
    NSDictionary* currentData = currentSection.sectionItems[indexPath.row];
    
    cell.sponsorImage.image = nil;
    NSString* sponsorURL = currentData[@"picture"];

    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:sponsorURL] options:SDWebImageRetryFailed
                                                   progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                   }
                                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                                      cell.sponsorImage.image = image;
                                                  }];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    SponsorSection* currentSection = self.sectionData[indexPath.section];
    
    UICollectionReusableView* reusableView = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        CustomSponsorHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CustomSectionHeader" forIndexPath:indexPath];
        headerView.categoryTitle.text = currentSection.sectionName;
        
        headerView.categoryTitle.backgroundColor = [UIColor grayColorVeryLight];
        headerView.categoryTitle.textColor = [UIColor grayColorVeryDark];
        headerView.categoryTitle.font = [DTCUtil currentBoldFontWithSize:18];
        
        reusableView = headerView;
    }
    
    return reusableView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    SponsorSection* currentSection = self.sectionData[indexPath.section];
    
    CGSize tileSize = CGSizeMake(CGRectGetWidth(self.view.frame)-20, 60);
    
    if (currentSection.sectionItems.count > 1) {
        tileSize = CGSizeMake(CGRectGetWidth(self.view.frame)/2-20, 40);
    }

    return tileSize;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SponsorSection* currentSection = self.sectionData[indexPath.section];
    NSDictionary* currentData = currentSection.sectionItems[indexPath.row];

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:currentData[@"url"]]];
}

@end
