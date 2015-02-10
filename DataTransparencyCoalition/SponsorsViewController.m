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

@interface SponsorsViewController() <UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UICollectionView *mainCollectionView;
@property (strong, nonatomic) IBOutlet UICollectionViewFlowLayout *customLayout;
@property (strong, nonatomic) UIActivityIndicatorView* spinner;
@property (strong, nonatomic) NSArray *sponsorsData;

@end

@implementation SponsorsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Sponsors";
    
    self.mainCollectionView.delegate = self;
    self.mainCollectionView.dataSource = self;
    self.mainCollectionView.backgroundColor = [UIColor grayColorVeryLight];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.sponsorsData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CustomSponsorTileCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    NSDictionary* currentData = self.sponsorsData[[indexPath row]];
    
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


@end
