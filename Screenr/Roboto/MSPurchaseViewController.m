//
//  MSPurchaseViewController.m
//  Screenr
//
//  Created by Michael Scaria on 11/9/13.
//  Copyright (c) 2013 MichaelScaria. All rights reserved.
//

#import "MSPurchaseViewController.h"
#import "MSFetcher.h"

@interface MSPurchaseViewController ()

@end

@implementation MSPurchaseViewController

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self textFieldCheck];
}

- (void)textFieldCheck {
    if ([_areaCodeTextField isFirstResponder]) {
        [_areaCodeTextField resignFirstResponder];
    }
    else if ([_startsWithField isFirstResponder]) {
        [_startsWithField resignFirstResponder];
    }
    else if ([_stateField isFirstResponder]) {
        [_stateField resignFirstResponder];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	_headerView.layer.masksToBounds = NO;
    _headerView.layer.shadowOffset = CGSizeZero;
    _headerView.layer.shadowRadius = 4;
    _headerView.layer.shadowOpacity = 0.4;
    _purchaseLabel.titleLabel.font = [UIFont fontWithName:@"Roboto" size:25];
    _cancelButton.titleLabel.font = [UIFont fontWithName:@"Roboto" size:16];
    _areaCodeLabel.font = _plusOneLabel.font = _areaCodeTextField.font = _secondPlusOneLabel.font =  _pickAStateLabel.font = _numberThatBeginsWithLabel.font = _startsWithField.font = _stateField.font = _starsLabel.font = [UIFont fontWithName:@"Roboto" size:23];
    _scrollView.contentSize = CGSizeMake(960, 76);
    
    _numbers = [[NSMutableArray alloc] init];
    
    nameAbbreviations = [NSDictionary dictionaryWithObjectsAndKeys:
                         @"AL",@"alabama",
                         @"AK",@"alaska",
                         @"AZ",@"arizona",
                         @"AR",@"arkansas",
                         @"CA",@"california",
                         @"CO",@"colorado",
                         @"CT",@"connecticut",
                         @"DE",@"delaware",
                         @"DC",@"district of columbia",
                         @"FL",@"florida",
                         @"GA",@"georgia",
                         @"HI",@"hawaii",
                         @"ID",@"idaho",
                         @"IL",@"illinois",
                         @"IN",@"indiana",
                         @"IA",@"iowa",
                         @"KS",@"kansas",
                         @"KY",@"kentucky",
                         @"LA",@"louisiana",
                         @"ME",@"maine",
                         @"MD",@"maryland",
                         @"MA",@"massachusetts",
                         @"MI",@"michigan",
                         @"MN",@"minnesota",
                         @"MS",@"mississippi",
                         @"MO",@"missouri",
                         @"MT",@"montana",
                         @"NE",@"nebraska",
                         @"NV",@"nevada",
                         @"NH",@"new hampshire",
                         @"NJ",@"new jersey",
                         @"NM",@"new mexico",
                         @"NY",@"new york",
                         @"NC",@"north carolina",
                         @"ND",@"north dakota",
                         @"OH",@"ohio",
                         @"OK",@"oklahoma",
                         @"OR",@"oregon",
                         @"PA",@"pennsylvania",
                         @"RI",@"rhode island",
                         @"SC",@"south carolina",
                         @"SD",@"south dakota",
                         @"TN",@"tennessee",
                         @"TX",@"texas",
                         @"UT",@"utah",
                         @"VT",@"vermont",
                         @"VA",@"virginia",
                         @"WA",@"washington",
                         @"WV",@"west virginia",
                         @"WI",@"wisonsin",
                         @"WY",@"wyoming",
                         nil];
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (_areaCodeTextField == textField) {
        int length = [self getLength:textField.text];
        

        
        if(length == 3)
        {
            
            NSString *num = [self formatNumber:textField.text];
            textField.text = [NSString stringWithFormat:@"(%@)",num];
            if(range.length > 0)
            textField.text = [NSString stringWithFormat:@"%@",[num substringToIndex:3]];
            [[MSFetcher sharedInstance] searchNumbersWithAreaCode:num success:^(NSArray *numbers) {
                _numbers = [numbers mutableCopy];
                [self textFieldCheck];
                [_tableView reloadData];
            } failure:nil];
        }
        
        if(length == 3)
        {
            if(range.length == 0)
            return NO;
        }
        
        return YES;
    }
    else if (_startsWithField == textField){
        int length = [self getLength:textField.text];
        
        
        if(length == 3)
        {
            NSString *num = [self formatNumber:textField.text];
            textField.text = [NSString stringWithFormat:@"(%@) ",num];
            if(range.length > 0)
            textField.text = [NSString stringWithFormat:@"%@",[num substringToIndex:3]];
            [[MSFetcher sharedInstance] searchNumbersWithInitial:num success:^(NSArray *numbers) {
                _numbers = [numbers mutableCopy];
                [self textFieldCheck];
                [_tableView reloadData];
            } failure:nil];
        }
        if(length == 5)
        {
            if(range.length == 0)
            return NO;
        }
        
        return YES;
    }
    else if (_stateField == textField){
        if ([_stateField.text stringByReplacingCharactersInRange:range withString:string].length > 2) {
            [[MSFetcher sharedInstance] searchNumbersWithState:_stateField.text success:^(NSArray *numbers) {
                _numbers = [numbers mutableCopy];
                [self textFieldCheck];
                [_tableView reloadData];
            } failure:nil];
            return NO;
        }
        
        return YES;
    }
    return YES;
}

-(NSString*)formatNumber:(NSString*)mobileNumber
{
    
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    
    int length = [mobileNumber length];
    if(length > 10)
    {
        mobileNumber = [mobileNumber substringFromIndex: length-10];
        NSLog(@"%@", mobileNumber);
        
    }
    
    
    return mobileNumber;
}


-(int)getLength:(NSString*)mobileNumber
{
    
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    int length = [mobileNumber length];
    
    return length;
    
    
}



- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    selectedPath = indexPath;
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *d = _numbers[indexPath.row];
    NSString *numberString = [d[@"number"] substringFromIndex:2];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirm Purchase?" message:[NSString stringWithFormat:@"Are you sure you want to screen with %@?", numberString] delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alert show];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != alertView.cancelButtonIndex) {
        NSDictionary *d = _numbers[selectedPath.row];
        [[MSFetcher sharedInstance] buyNumber:d success:^ {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Number Purchased!" message:@"Use this number to screen your messages." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//            [alert show];
            [self dismissViewControllerAnimated:YES completion:nil];
        } failure:nil];
    }
}
@end
