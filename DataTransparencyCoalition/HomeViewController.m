//
//  ViewController.m
//  DataTransparencyCoalition
//
//  Created by Weien Wang on 2/2/15.
//  Copyright (c) 2015 Data Transparency Coalition. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()
@property (strong, nonatomic) IBOutlet UITableView *mainTableView;
@property (strong, nonatomic) IBOutlet UIButton *logoButton;
@property (strong, nonatomic) IBOutlet UIView *headerContainer;
@property (strong, nonatomic) IBOutlet UIButton *conferenceTitle;
@property (strong, nonatomic) IBOutlet UIButton *conferenceDate;
@property (strong, nonatomic) IBOutlet UIButton *conferenceLocation;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
