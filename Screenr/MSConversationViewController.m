//
//  MSConversationViewController.m
//  Screenr
//
//  Created by Michael Scaria on 11/9/13.
//  Copyright (c) 2013 MichaelScaria. All rights reserved.
//

#import "MSConversationViewController.h"

@interface MSConversationViewController ()

@end

@implementation MSConversationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _headerView.layer.masksToBounds = NO;
    _headerView.layer.shadowOffset = CGSizeZero;
    _headerView.layer.shadowRadius = 4;
    _headerView.layer.shadowOpacity = 0.4;
    _titleLabel.font = [UIFont fontWithName:@"Roboto" size:25];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
