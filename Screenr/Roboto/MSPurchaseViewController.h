//
//  MSPurchaseViewController.h
//  Screenr
//
//  Created by Michael Scaria on 11/9/13.
//  Copyright (c) 2013 MichaelScaria. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSPurchaseViewController : UIViewController <UITextFieldDelegate, UIScrollViewDelegate, UIAlertViewDelegate> {
    NSDictionary *nameAbbreviations;
    NSIndexPath *selectedPath;
}
@property (strong, nonatomic) IBOutlet UIButton *purchaseLabel;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel *areaCodeLabel;
@property (strong, nonatomic) IBOutlet UILabel *plusOneLabel;
@property (strong, nonatomic) IBOutlet UITextField *areaCodeTextField;
@property (strong, nonatomic) IBOutlet UILabel *numberThatBeginsWithLabel;
@property (strong, nonatomic) IBOutlet UILabel *pickAStateLabel;
@property (strong, nonatomic) IBOutlet UILabel *secondPlusOneLabel;
@property (strong, nonatomic) IBOutlet UITextField *startsWithField;
@property (strong, nonatomic) IBOutlet UILabel *starsLabel;
@property (strong, nonatomic) IBOutlet UITextField *stateField;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *numbers;

- (IBAction)cancel:(id)sender;
@end
