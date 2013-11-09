//
//  MSViewController.h
//  Screenr
//
//  Created by Michael Scaria on 11/9/13.
//  Copyright (c) 2013 MichaelScaria. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *titleButton;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UILabel *numbersLabel;
- (void)presentRegisterView;
@end
