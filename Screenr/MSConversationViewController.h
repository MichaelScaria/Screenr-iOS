//
//  MSConversationViewController.h
//  Screenr
//
//  Created by Michael Scaria on 11/9/13.
//  Copyright (c) 2013 MichaelScaria. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSConversationViewController : UIViewController
@property (nonatomic, strong) NSMutableArray *conversations;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@end
