//
//  MSConversationViewController.h
//  Screenr
//
//  Created by Michael Scaria on 11/9/13.
//  Copyright (c) 2013 MichaelScaria. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSConversationViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSString *opNumber;
}
@property (nonatomic, strong) NSMutableArray *conversations;
@property (nonatomic, strong) NSString *number;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) IBOutlet UIButton *sendButton;
- (IBAction)cancel:(id)sender;
- (IBAction)send:(id)sender;
@end
