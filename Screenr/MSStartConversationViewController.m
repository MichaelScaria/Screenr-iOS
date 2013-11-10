//
//  MSStartConversationViewController.m
//  Screenr
//
//  Created by Michael Scaria on 11/9/13.
//  Copyright (c) 2013 MichaelScaria. All rights reserved.
//

#import "MSStartConversationViewController.h"
#import "MSFetcher.h"
@interface MSStartConversationViewController ()

@end

@implementation MSStartConversationViewController

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
    _sendButton.titleLabel.font = [UIFont fontWithName:@"Roboto" size:35];
    _cancelButton.titleLabel.font = _sendButton.titleLabel.font = [UIFont fontWithName:@"Roboto" size:16];
    _rulesLabel.font = _textView.font = [UIFont fontWithName:@"Roboto" size:13];
    _rulesLabel.textColor = [UIColor colorWithRed:205.0/255.0 green:205.0/255.0 blue:205.0/255.0 alpha:1];
    _textField.font = [UIFont fontWithName:@"Roboto-Light" size:25];
    _textView.backgroundColor = [UIColor clearColor];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)send:(id)sender {
    NSString *finalString = [[[[_textField.text stringByReplacingOccurrencesOfString:@"(" withString:@""]  stringByReplacingOccurrencesOfString:@")" withString:@""] stringByReplacingOccurrencesOfString:@"-" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    [[MSFetcher sharedInstance] startConversationFrom:_opNumber withMessage:_textView.text toNumber:finalString success:^(NSArray *c) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:nil];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}
@end
