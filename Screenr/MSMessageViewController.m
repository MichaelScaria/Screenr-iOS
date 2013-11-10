//
//  MSMessageViewController.m
//  Screenr
//
//  Created by Michael Scaria on 11/9/13.
//  Copyright (c) 2013 MichaelScaria. All rights reserved.
//

#import "MSMessageViewController.h"
#import "MSFetcher.h"
#import "MSLabel.h"
@interface MSMessageViewController ()

@end

@implementation MSMessageViewController

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
    _cancelButton.titleLabel.font = [UIFont fontWithName:@"Roboto" size:16];
    _messages = [[NSArray alloc] init];
    _textField.font = [UIFont fontWithName:@"Roboto" size:13];
    _sendButton.titleLabel.font = [UIFont fontWithName:@"Roboto" size:13];
    _sendButton.backgroundColor = [UIColor colorWithRed:0 green:196/255.0 blue:178/255.0 alpha:1];
    [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _sendButton.layer.cornerRadius = 4;
    [_textField becomeFirstResponder];
}

- (void)setMyNumber:(NSString *)myNumber {
    if (myNumber != _myNumber) {
        _myNumber = myNumber;
        _titleLabel.text = myNumber;
    }
}

- (void)setConversationID:(NSString *)conversationID {
    if (conversationID != _conversationID) {
        _conversationID = conversationID;
        [[MSFetcher sharedInstance] messagesForConversation:conversationID success:^(NSArray *messages) {
            _messages = messages;
            [self setUpMessages];
        } failure:nil];
    }
}

- (void)setUpMessages {
    int yOffset = 10;
    CGSize s;
    for (NSDictionary *d in _messages) {
        s = [d[@"message"] sizeWithFont:[UIFont fontWithName:@"Roboto" size:12] constrainedToSize:CGSizeMake(120, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
        MSLabel *label = [[MSLabel alloc] init];
        label.text =d[@"message"];
        label.layer.cornerRadius = 5;
        label.font = [UIFont fontWithName:@"Roboto" size:12];
        if ([d[@"number"][@"number"] isEqualToString:_myNumber]) {
            //my message
            label.frame = CGRectMake(180, yOffset, 130, s.height + 10);
            label.backgroundColor = [UIColor colorWithRed:0 green:196/255.0 blue:178/255.0 alpha:1];
            label.textAlignment = NSTextAlignmentRight;

        }
        else {
            //other's mesage
            label.frame = CGRectMake(10, yOffset, 130, s.height + 10);
            label.backgroundColor = [UIColor whiteColor];
            label.textAlignment = NSTextAlignmentLeft;
        }
        yOffset += s.height;
        [_scrollView addSubview:label];
        NSLog(@"HIEGHT:%f", s.height);
        NSLog(@"%@", d[@"number"]);
    }
    _scrollView.contentSize = CGSizeMake(320, yOffset + s.height);
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)send:(id)sender {
    [[MSFetcher sharedInstance] sendMessage:_textField.text InConversation:_conversationID withNumber:_myNumber toNumber:_opNumber success:^(NSArray *completion) {
        ;
    } failure:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    _sendButton.enabled = [textField.text stringByReplacingCharactersInRange:range withString:string].length > 10;
    if ([textField.text stringByReplacingCharactersInRange:range withString:string].length > 150) {
        return NO;
    }
    return YES;
}
@end
