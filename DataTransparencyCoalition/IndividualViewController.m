//
//  IndividualViewController.m
//  DataTransparencyCoalition
//
//  Created by Weien Wang on 2/6/15.
//  Copyright (c) 2015 Data Transparency Coalition. All rights reserved.
//

#import "IndividualViewController.h"
#import "UIColor+Custom.h"
#import "DTCUtil.h"
#import "UIImageView+WebCache.h"
#import "PBWebViewController.h"
#import "PBSafariActivity.h"
//#import <ParseUI/ParseUI.h>

#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)


@interface IndividualViewController() <UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UITextView *mainTextView;
@property (strong, nonatomic) IBOutlet UIImageView *mainImageView;
@property (strong, nonatomic) PBWebViewController* pbwVC;

@end

@implementation IndividualViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainTextView.backgroundColor = [UIColor grayColorVeryLight];
    
    self.mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 140, 140)];
    [self.mainTextView addSubview:self.mainImageView];
    
    //thanks http://stackoverflow.com/a/20033752/2284713
    UIBezierPath * imgRect = [UIBezierPath bezierPathWithRect:self.mainImageView.frame];
    self.mainTextView.textContainer.exclusionPaths = @[imgRect];

    self.mainTextView.editable = NO;
    self.mainTextView.dataDetectorTypes = UIDataDetectorTypeLink;
    self.mainTextView.textColor = [UIColor grayColorVeryDark];
    self.mainTextView.font = [DTCUtil currentMainFontWithSize:14];
    
    self.mainImageView.layer.cornerRadius = CGRectGetWidth(self.mainImageView.frame)/2;
    self.mainImageView.layer.masksToBounds = YES;
    self.mainImageView.layer.borderWidth = 5.0f;
    self.mainImageView.layer.borderColor = [UIColor grayColorThunder].CGColor;
    
    self.mainTextView.delegate = self;
    self.pbwVC = [PBWebViewController new];
    PBSafariActivity *activity = [PBSafariActivity new];
    self.pbwVC.applicationActivities = @[activity];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    self.title = [NSString stringWithFormat:@"%@ %@", self.speakerData.firstName, self.speakerData.lastName];
    
    self.mainTextView.text = nil; //necessary because of weird datadetector issue
    self.mainTextView.text = self.speakerData.bio;
    
    if (self.speakerImage) {
        self.mainImageView.image = self.speakerImage;
    }
    else {
        self.mainImageView.image = nil;
//        self.mainImageView.file = self.speakerData.picture;
//        [self.mainImageView loadInBackground];
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:self.speakerData.picture] options:SDWebImageRetryFailed
                                                       progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                       }
                                                      completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                                          self.mainImageView.image = image;
                                                      }];
    }
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    self.pbwVC.URL = URL;
    [self.navigationController pushViewController:self.pbwVC animated:YES];
    
    return NO;
}

@end
