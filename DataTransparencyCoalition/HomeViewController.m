//
//  ViewController.m
//  DataTransparencyCoalition
//
//  Created by Weien Wang on 2/2/15.
//  Copyright (c) 2015 Data Transparency Coalition. All rights reserved.
//

#import "HomeViewController.h"
#import "UIColor+Custom.h"
#import "DTCUtil.h"
#import "Constants.h"
#import "ParseWebService.h"
#import "UIViewController+DTC.h"
#import "CustomHomeCell.h"
#import "PBWebViewController.h"
#import "PBSafariActivity.h"

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *mainTableView;
@property (strong, nonatomic) IBOutlet UIView *topContainer;
@property (strong, nonatomic) IBOutlet UIButton *logoButton;
@property (strong, nonatomic) IBOutlet UIView *middleContainer;
@property (strong, nonatomic) IBOutlet UIButton *conferenceTitle;
@property (strong, nonatomic) IBOutlet UIButton *conferenceDate;
@property (strong, nonatomic) IBOutlet UIButton *conferenceLocation;

@property (strong, nonatomic) NSDictionary *conferenceMetadata;
@property (strong, nonatomic) NSArray *homeData;
@property (strong, nonatomic) UIActivityIndicatorView* spinner;
@property (strong, nonatomic) PBWebViewController* pbwVC;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.mainTableView.backgroundColor = [UIColor orangeColorSun];
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.topContainer.backgroundColor = [UIColor whiteColor];
    self.middleContainer.backgroundColor = [UIColor orangeColorSun];
    
    self.conferenceTitle.titleLabel.font = [DTCUtil currentBoldFontWithSize:40];
    [self.conferenceTitle setTitleColor:[UIColor grayColorVeryDark] forState:UIControlStateNormal];
    self.conferenceTitle.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.conferenceTitle.titleLabel.textAlignment = NSTextAlignmentRight;
    
    self.conferenceDate.titleLabel.font = [DTCUtil currentBoldFontWithSize:15];
    [self.conferenceDate setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.conferenceDate.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.conferenceDate.titleLabel.textAlignment = NSTextAlignmentRight;//NSTextAlignmentCenter;
    
    self.conferenceLocation.titleLabel.font = [DTCUtil currentBoldFontWithSize:15];
    [self.conferenceLocation setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.conferenceLocation.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.conferenceLocation.titleLabel.textAlignment = NSTextAlignmentRight;//NSTextAlignmentCenter;
    
    self.pbwVC = [PBWebViewController new];
    PBSafariActivity *activity = [PBSafariActivity new];
    self.pbwVC.applicationActivities = @[activity];
    
    self.conferenceMetadata = [DTCUtil plistDataWithComponent:kPlistComponentForConferenceMetadata];
    
    self.homeData = [DTCUtil plistDataWithComponent:kPlistComponentForCurrentHomeData];
    if (!self.homeData) {
        self.spinner = [self startSpinner:self.spinner inView:self.view];
    }
    else {
        [self sortAndDisplayData];
    }
    
    dispatch_async(dispatch_queue_create("getHomeData", NULL), ^{
        NSArray* homeDataFromParse = [[ParseWebService sharedInstance] retrieveHomeDataForConference:[DTCUtil plistDataWithComponent:kPlistComponentForConferenceMetadata][@"conferenceId"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self stopSpinner:self.spinner];
            [DTCUtil saveDataToPlistWithComponent:kPlistComponentForCurrentHomeData andInfo:homeDataFromParse];
            self.homeData = homeDataFromParse;
            [self sortAndDisplayData];
        });
    });
}

- (void) sortAndDisplayData {
    self.homeData = [self.homeData sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"rank" ascending:YES]]];
    [self.mainTableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationItem.title = self.conferenceMetadata[@"hashtag"];
    [self.conferenceTitle setTitle:[self.conferenceMetadata[@"name"] uppercaseString] forState:UIControlStateNormal];
    [self.conferenceLocation setTitle:self.conferenceMetadata[@"location"] forState:UIControlStateNormal];
    
    NSDate* conferenceDate = self.conferenceMetadata[@"date"];
    NSDateFormatter* dateFormatter = [DTCUtil sharedDateFormatter];
    dateFormatter.dateFormat = @"MMMM dd";
    NSString* dateSuffix = [DTCUtil daySuffixForDate:conferenceDate];
    NSString* conferenceDateString = [NSString stringWithFormat:@"%@%@", [dateFormatter stringFromDate:conferenceDate], dateSuffix];
    [self.conferenceDate setTitle:conferenceDateString forState:UIControlStateNormal];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.homeData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    CustomHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.backgroundColor = [UIColor orangeColorSun];
    
    NSDictionary* currentData = self.homeData[indexPath.row];
    
    cell.itemTitle.backgroundColor = [UIColor whiteColor];
    cell.itemTitle.textColor = [UIColor grayColorVeryDark];
    cell.itemTitle.font = [DTCUtil currentBoldFontWithSize:15];
    cell.itemTitle.layer.shadowColor = [UIColor grayColorVeryDark].CGColor;
    cell.itemTitle.layer.shadowOffset = CGSizeMake(0.5, 2);
    cell.itemTitle.layer.shadowRadius = 1;
    cell.itemTitle.layer.shadowOpacity = 1;
    
    cell.itemTitle.text = [currentData[@"title"] uppercaseString];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSDictionary* currentData = self.homeData[indexPath.row];
    self.pbwVC.URL = [NSURL URLWithString:currentData[@"url"]];
    [self.navigationController pushViewController:self.pbwVC animated:YES];
}

- (IBAction)dtcLogoTapped:(id)sender {
    self.pbwVC.URL = [NSURL URLWithString:self.conferenceMetadata[@"coalitionURL"]];
    [self.navigationController pushViewController:self.pbwVC animated:YES];
}

- (IBAction)conferenceTitleTapped:(id)sender {
    self.pbwVC.URL = [NSURL URLWithString:self.conferenceMetadata[@"conferenceURL"]];
    [self.navigationController pushViewController:self.pbwVC animated:YES];
}

- (IBAction)conferenceLocationTapped:(id)sender {
    self.pbwVC.URL = [NSURL URLWithString:self.conferenceMetadata[@"mapURL"]];
    [self.navigationController pushViewController:self.pbwVC animated:YES];
}

@end
