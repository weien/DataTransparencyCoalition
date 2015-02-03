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

@interface ProgramViewController() <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *mainTableView;

@property (strong, nonatomic) NSArray *programData;

@end

@implementation ProgramViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 10)];
    sectionHeader.backgroundColor = [UIColor greenColor];
    
    return sectionHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}


@end
