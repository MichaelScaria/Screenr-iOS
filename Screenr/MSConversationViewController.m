//
//  MSConversationViewController.m
//  Screenr
//
//  Created by Michael Scaria on 11/9/13.
//  Copyright (c) 2013 MichaelScaria. All rights reserved.
//

#import "MSConversationViewController.h"
#import "MSMessageViewController.h"

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
    _cancelButton.titleLabel.font = _sendButton.titleLabel.font = [UIFont fontWithName:@"Roboto" size:16];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"Message"]) {
        MSMessageViewController *vc = (MSMessageViewController *)segue.destinationViewController;
        NSIndexPath *path = (NSIndexPath *)sender;
        NSDictionary *d = _conversations[path.row];
        vc.myNumber = _number;
        vc.conversationID = d[@"id"];
        vc.opNumber = opNumber;
    }
}

#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _conversations.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConversationCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ConversationCell"];
    }
    NSDictionary *d = _conversations[indexPath.row];
    UILabel *numberLabel = (UILabel *)[cell viewWithTag:1];
    UILabel *regionLabel = (UILabel *)[cell viewWithTag:2];
    UILabel *zipcodeLabel = (UILabel *)[cell viewWithTag:3];
    numberLabel.font = [UIFont fontWithName:@"Roboto" size:16];
    regionLabel.font = zipcodeLabel.font = [UIFont fontWithName:@"Roboto" size:14];
    regionLabel.textColor = zipcodeLabel.textColor = [UIColor darkGrayColor];
    if ([d[@"first_number"] isEqualToString:_number]) {
        //assign second
        NSString *numberString = [d[@"second_number"] substringFromIndex:2];
        opNumber = numberString;
        numberLabel.text = [NSString stringWithFormat:@"(%@) %@",[numberString  substringToIndex:3],[numberString substringFromIndex:3]];
        regionLabel.text = d[@"second_region"] != [NSNull null] ? d[@"second_region"] : @"TX";
        zipcodeLabel.text = d[@"second_postal_code"] != [NSNull null] ? d[@"first_postal_code"] : @"75102";
    }
    else {
        //assgin first
        NSString *numberString = [d[@"first_number"] substringFromIndex:2];
        opNumber = numberString;
        numberLabel.text = [NSString stringWithFormat:@"(%@) %@",[numberString  substringToIndex:3],[numberString substringFromIndex:3]];
        regionLabel.text = [d objectForKey:@"first_region"] != [NSNull null] ? d[@"first_region"] : @"TX";
        zipcodeLabel.text = [d objectForKey:@"first_postal_code"] != [NSNull null] ? d[@"first_postal_code"] : @"75102";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"Message" sender:indexPath];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)send:(id)sender {
    [self performSegueWithIdentifier:@"Send" sender:self];
}
@end
