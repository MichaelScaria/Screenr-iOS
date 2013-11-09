//
//  MSViewController.m
//  Screenr
//
//  Created by Michael Scaria on 11/9/13.
//  Copyright (c) 2013 MichaelScaria. All rights reserved.
//

#import "MSViewController.h"
#import "MSFetcher.h"

#import "MSConversationViewController.h"

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
    _headerView.layer.shadowRadius = 4;
    _headerView.layer.shadowOpacity = 0.4;
    _titleButton.titleLabel.font = [UIFont fontWithName:@"Roboto" size:25];
    _numbersLabel.font = [UIFont fontWithName:@"Roboto" size:17];
    _numbers = [[NSMutableArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[MSFetcher sharedInstance] getInboxForPhoneNumber:[[NSUserDefaults standardUserDefaults] objectForKey:@"PhoneNumber"] success:^(NSArray *numbers) {
        _numbers = [numbers mutableCopy];
        [_tableView reloadData];
    } failure:nil];
}
- (void)presentRegisterView
{
    [self performSegueWithIdentifier:@"Register" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"Conversation"]) {
        MSConversationViewController *vc = (MSConversationViewController *)segue.destinationViewController;
        NSIndexPath *path = (NSIndexPath *)sender;
        NSDictionary *d = _numbers[path.row];
        vc.number = d[@"number"];
        vc.conversations = d[@"conversations"];
    }
}

#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _numbers.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NumberCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NumberCell"];
    }
    NSDictionary *d = _numbers[indexPath.row];
    UILabel *numberLabel = (UILabel *)[cell viewWithTag:1];
    UILabel *regionLabel = (UILabel *)[cell viewWithTag:2];
    UILabel *zipcodeLabel = (UILabel *)[cell viewWithTag:3];
    numberLabel.font = [UIFont fontWithName:@"Roboto" size:16];
    regionLabel.font = zipcodeLabel.font = [UIFont fontWithName:@"Roboto" size:14];
    regionLabel.textColor = zipcodeLabel.textColor = [UIColor darkGrayColor];
    NSString *numberString = [d[@"number"] substringFromIndex:2];
    numberLabel.text = [NSString stringWithFormat:@"(%@) %@",[numberString  substringToIndex:3],[numberString substringFromIndex:3]];
    regionLabel.text = d[@"region"];
    zipcodeLabel.text = d[@"postal_code"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *d = _numbers[indexPath.row];
    [self performSegueWithIdentifier:@"Conversation" sender:indexPath];
}

@end
