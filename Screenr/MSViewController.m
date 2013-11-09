//
//  MSViewController.m
//  Screenr
//
//  Created by Michael Scaria on 11/9/13.
//  Copyright (c) 2013 MichaelScaria. All rights reserved.
//

#import "MSViewController.h"

@interface MSViewController ()

@end

@implementation MSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//	_headerView.layer.shadowOffset = CGSizeMake(1, 1);
//    _headerView.layer.shadowColor = [UIColor greenColor].CGColor;
    _headerView.layer.masksToBounds = NO;
    _headerView.layer.shadowOffset = CGSizeZero;
    _headerView.layer.shadowRadius = 5;
    _headerView.layer.shadowOpacity = 0.5;
    _titleButton.titleLabel.font = [UIFont fontWithName:@"Roboto" size:25];
    _numbersLabel.font = [UIFont fontWithName:@"Roboto" size:18];
    
}

- (void)presentRegisterView
{
    [self performSegueWithIdentifier:@"Register" sender:self];
}

@end
