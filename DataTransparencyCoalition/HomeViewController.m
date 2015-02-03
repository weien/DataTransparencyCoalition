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

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *mainTableView;
@property (strong, nonatomic) IBOutlet UIView *topContainer;
@property (strong, nonatomic) IBOutlet UIButton *logoButton;
@property (strong, nonatomic) IBOutlet UIView *middleContainer;
@property (strong, nonatomic) IBOutlet UIButton *conferenceTitle;
@property (strong, nonatomic) IBOutlet UIButton *conferenceDate;
@property (strong, nonatomic) IBOutlet UIButton *conferenceLocation;

@property (strong, nonatomic) NSDictionary *conferenceMetadata;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.mainTableView.backgroundColor = [UIColor orangeColorSun];
    
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
    
    self.conferenceMetadata = [DTCUtil plistDataWithComponent:kPlistComponentForConferenceMetadata];
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
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.backgroundColor = [UIColor orangeColorSun];
    return cell;
}

@end
