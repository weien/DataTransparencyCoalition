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
#import "CustomProgramCell.h"

#define kProgramSectionHeight 50

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
    self.mainTableView.rowHeight = UITableViewAutomaticDimension;
    self.mainTableView.backgroundColor = [UIColor grayColorVeryLight];
    
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
                NSMutableArray* peopleInSection = [NSMutableArray array];
                
                NSArray* normalSpeakers = [sortedMatchingItems filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(isSponsor == nil && isSupport == nil)"]];
                NSArray* supportSpeakers = [sortedMatchingItems filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(isSupport == YES)"]];
                NSArray* sponsorSpeakers = [sortedMatchingItems filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(isSponsor == YES)"]];

                peopleInSection = [[normalSpeakers arrayByAddingObjectsFromArray:supportSpeakers] mutableCopy]; //combine, with normal speakers first
                
                ProgramSection* section = [ProgramSection new];
                section.sectionTime = [peopleInSection firstObject][@"time"];
                section.sectionName = eventName;
                section.sectionSponsor = [sponsorSpeakers firstObject][@"speakerName"];
                //remove any empty speakers (e.g. no speaker for "Registration")
                [peopleInSection removeObjectsInArray:[peopleInSection filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(speakerName == nil)"]]];
                section.sectionItems = peopleInSection;
                
                [sectionsToDisplay addObject:section];
            }
            sectionsToDisplay = [[sectionsToDisplay sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"sectionTime" ascending:YES]]] mutableCopy];
            
            self.sectionData = sectionsToDisplay;
            [self.mainTableView reloadData];
        });
    });
}

//thanks https://gist.github.com/maicki/8d7b1cfb31733df51406
- (void)viewDidLayoutSubviews {
    self.mainTableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
    if ([self.mainTableView respondsToSelector:@selector(layoutMargins)]) {
        self.mainTableView.layoutMargins = UIEdgeInsetsMake(0, 10, 0, 0);
    }
}


#pragma mark - cells
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ProgramSection* currentSection = self.sectionData[section];
    return currentSection.sectionItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    CustomProgramCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    ProgramSection* currentSection = self.sectionData[indexPath.section];
    NSDictionary* currentSpeaker = currentSection.sectionItems[indexPath.row];
    
    cell.mainLabel.attributedText = [self attributedStringForCellWithData:currentSpeaker];
//    cell.layer.borderColor = [UIColor purpleColor].CGColor;
//    cell.layer.borderWidth = 1;
    
    //thanks https://gist.github.com/maicki/8d7b1cfb31733df51406
    cell.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
    if ([cell respondsToSelector:@selector(layoutMargins)]) {
        cell.layoutMargins = UIEdgeInsetsMake(0, 10, 0, 0);
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProgramSection* currentSection = self.sectionData[indexPath.section];
    NSDictionary* currentSpeaker = currentSection.sectionItems[indexPath.row];
    
    CGRect paragraphRect = [[self attributedStringForCellWithData:currentSpeaker] boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.view.frame)-20, CGFLOAT_MAX)
                                 options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                 context:nil];
    return CGRectGetHeight(paragraphRect)+20+1; //+1 to avoid rounding errors
}

- (NSAttributedString*) attributedStringForCellWithData:(NSDictionary*)cellData {
    NSString* speakerName = cellData[@"speakerName"];
    NSString* speakerTitles = cellData[@"speakerTitles"];
    
    NSString* speakerText = [NSString stringWithFormat:@"%@, %@", speakerName, speakerTitles];
    NSMutableAttributedString* attributedString = [[NSMutableAttributedString alloc] initWithString:speakerText];
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    //    style.lineSpacing = 0;
    style.headIndent = 10;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, [speakerText length])];
    
    int fontSize = 14;
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor grayColorVeryDark] range:NSMakeRange(0, [speakerText length])];
    [attributedString addAttribute:NSFontAttributeName value:[DTCUtil currentMainFontWithSize:fontSize] range:NSMakeRange(0, [speakerText length])];
    [attributedString addAttribute:NSFontAttributeName value:[DTCUtil currentBoldFontWithSize:fontSize] range:[speakerText rangeOfString:speakerName]];
    [attributedString addAttribute:NSFontAttributeName value:[DTCUtil currentMainFontWithSize:fontSize] range:[speakerText rangeOfString:speakerTitles]];
    
    return attributedString;
}

#pragma mark - sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionData.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ProgramSection* currentSection = self.sectionData[section];
    NSDateFormatter* dateFormatter = [DTCUtil sharedDateFormatter];
    dateFormatter.dateFormat = @"h:mm a";
    NSString* sectionDateString = [dateFormatter stringFromDate:currentSection.sectionTime];
    NSString* sponsorText = @"";

    if (currentSection.sectionSponsor) {
        sponsorText = [NSString stringWithFormat:@" sponsored by %@", currentSection.sectionSponsor];
    }
    
    NSString* sectionText = [NSString stringWithFormat:@"%@ %@%@", sectionDateString, currentSection.sectionName, sponsorText];
    NSMutableAttributedString* sectionAttributedString = [[NSMutableAttributedString alloc] initWithString:sectionText];
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
//    style.lineSpacing = 0;
    style.headIndent = 10;
    [sectionAttributedString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, [sectionText length])];

    int sectionHeaderFontSize = 14;
    [sectionAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor grayColorVeryDark] range:NSMakeRange(0, [sectionText length])];
    [sectionAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColorSun] range:[sectionText rangeOfString:sectionDateString]];
    [sectionAttributedString addAttribute:NSFontAttributeName value:[DTCUtil currentBoldFontWithSize:sectionHeaderFontSize] range:[sectionText rangeOfString:sectionDateString]];
    [sectionAttributedString addAttribute:NSFontAttributeName value:[DTCUtil currentBoldFontWithSize:sectionHeaderFontSize] range:[sectionText rangeOfString:currentSection.sectionName]];
    [sectionAttributedString addAttribute:NSFontAttributeName value:[DTCUtil currentItalicFontWithSize:sectionHeaderFontSize] range:[sectionText rangeOfString:sponsorText]];
    
    
    //TODO: http://stackoverflow.com/a/15399767/2284713 for dynamic sizing of these headers
    UIView* sectionHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), kProgramSectionHeight)];
    sectionHeader.backgroundColor = [UIColor grayColorVeryLight];
    
    UILabel *sectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, CGRectGetWidth(sectionHeader.frame)-20, CGRectGetHeight(sectionHeader.frame))];
    sectionLabel.attributedText = sectionAttributedString;
    sectionLabel.numberOfLines = 0;
    sectionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [sectionHeader addSubview:sectionLabel];
    
    return sectionHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kProgramSectionHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
