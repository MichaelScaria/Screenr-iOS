//
//  MSRegisterViewController.h
//  Screenr
//
//  Created by Michael Scaria on 11/9/13.
//  Copyright (c) 2013 MichaelScaria. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSRegisterViewController : UIViewController <UIScrollViewDelegate, UITextFieldDelegate> {
    UILabel *titleLabel;
    UILabel *swipeLabel;
    UIButton *verifyButton;
    UILabel *phoneNumberPrefix;
    UITextField *textField;
    UIButton *alreadyHaveVerifiyCode;
    UITextField *verifyField;
    UILabel *verifyLabel;
}

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;
@end
