//
//  ProgramViewController.m
//  DataTransparencyCoalition
//
//  Created by Weien Wang on 2/3/15.
//  Copyright (c) 2015 Data Transparency Coalition. All rights reserved.
//

#import "ProgramViewController.h"
#import "UIColor+Custom.h"
#import "DTCUtil.h"
#import "Constants.h"
#import "ParseWebService.h"
#import "UIViewController+DTC.h"
#import "ProgramSection.h"

@interface ProgramViewController() <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *mainTableView;

@property (strong, nonatomic) UIActivityIndicatorView* spinner;
@property (strong, nonatomic) NSArray *programData;
@property (strong, nonatomic) NSArray *sectionData;

@end

@implementation ProgramViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.programData = [DTCUtil plistDataWithComponent:kPlistComponentForCurrentProgramData];
    if (!self.programData) {
        self.spinner = [self startSpinner:self.spinner inView:self.view];
    }
    dispatch_async(dispatch_queue_create("getProgramData", NULL), ^{
        NSArray* programDataFromParse = [[ParseWebService sharedInstance] retrieveProgramDataForConference:[DTCUtil plistDataWithComponent:kPlistComponentForConferenceMetadata][@"conferenceId"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self stopSpinner:self.spinner];
            [DTCUtil saveDataToPlistWithComponent:kPlistComponentForCurrentProgramData andInfo:programDataFromParse];
            //self.programData = programDataFromParse;
            
            NSArray* allEventNames = [programDataFromParse valueForKey:@"eventName"];
            NSArray* uniqueEventNames = [[NSSet setWithArray:allEventNames] allObjects];
            
            NSMutableArray* sectionsToDisplay = [NSMutableArray array];
            for (NSString* eventName in uniqueEventNames) {
                NSArray* matchingItems = [programDataFromParse filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(eventName == %@)", eventName]];
                NSArray* sortedMatchingItems = [matchingItems sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"speakerName" ascending:YES]]];
                NSArray* peopleInSection = [NSArray array];
                
                NSArray* normalSpeakers = [sortedMatchingItems filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(isSponsor == nil && isSupport == nil)"]];
                NSArray* supportSpeakers = [sortedMatchingItems filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(isSupport == YES)"]];
                NSArray* sponsorSpeakers = [sortedMatchingItems filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(isSponsor == YES)"]];
                
                peopleInSection = [normalSpeakers arrayByAddingObjectsFromArray:supportSpeakers];
                
                ProgramSection* section = [ProgramSection new];
                section.sectionItems = peopleInSection;
                section.sectionTime = [peopleInSection firstObject][@"time"];
                section.sectionName = eventName;
                section.sectionSponsor = [sponsorSpeakers firstObject][@"speakerName"];
                
                [sectionsToDisplay addObject:section];
            }
            sectionsToDisplay = [[sectionsToDisplay sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"sectionTime" ascending:YES]]] mutableCopy];
            
            self.sectionData = sectionsToDisplay;
            [self.mainTableView reloadData];
        });
    });
    

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ProgramSection* currentSection = self.sectionData[section];
    return currentSection.sectionItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    ProgramSection* currentSection = self.sectionData[indexPath.section];
    NSDictionary* currentSpeaker = currentSection.sectionItems[indexPath.row];
    
    cell.textLabel.text = currentSpeaker[@"speakerName"];

    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ProgramSection* currentSection = self.sectionData[section];
    
    UILabel *sectionHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    sectionHeader.backgroundColor = [UIColor greenColor];
    sectionHeader.text = currentSection.sectionName;
    
    return sectionHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

@end
