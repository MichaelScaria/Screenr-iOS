//
//  MSMessageViewController.h
//  Screenr
//
//  Created by Michael Scaria on 11/9/13.
//  Copyright (c) 2013 MichaelScaria. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSMessageViewController : UIViewController <UITextFieldDelegate> {
    
}
@property (nonatomic, strong) NSString *conversationID;
@property (nonatomic, strong) NSString *opNumber;
@property (nonatomic, strong) NSString *myNumber;
@property (nonatomic, strong) NSArray *messages;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UIButton *sendButton;

- (IBAction)cancel:(id)sender;
- (IBAction)send:(id)sender;
@end
