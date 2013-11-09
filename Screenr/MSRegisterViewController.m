//
//  MSRegisterViewController.m
//  Screenr
//
//  Created by Michael Scaria on 11/9/13.
//  Copyright (c) 2013 MichaelScaria. All rights reserved.
//

#import "MSRegisterViewController.h"
#import "MSFetcher.h"

@interface MSRegisterViewController ()

@end

@implementation MSRegisterViewController

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
	titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 420, 110, 80)];
    titleLabel.center = CGPointMake(self.view.center.x, self.view.center.y + 20);
    titleLabel.text = @"Screenr";
    titleLabel.alpha = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"Roboto-Light" size:26];
    [_scrollView addSubview:titleLabel];
    _iconImageView.translatesAutoresizingMaskIntoConstraints = YES;
    [UIView animateWithDuration:.5 delay:1 options:UIViewAnimationOptionCurveLinear animations:^{
        _iconImageView.center = CGPointMake(_iconImageView.center.x, _iconImageView.center.y - 100);
    } completion:nil];

    
    swipeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 30)];
    swipeLabel.textAlignment = NSTextAlignmentCenter;
    swipeLabel.text = @"swipe to register";
    swipeLabel.font = [UIFont fontWithName:@"Roboto-Light" size:18];
    swipeLabel.alpha = 0;
    swipeLabel.center= CGPointMake(self.view.center.x, self.view.center.y + 70);
    swipeLabel.textColor = [UIColor colorWithRed:205.0/255.0 green:205.0/255.0 blue:205.0/255.0 alpha:1];
    [_scrollView addSubview:swipeLabel];
    [UIView animateWithDuration:.5 delay:1.5 options:UIViewAnimationOptionCurveLinear animations:^{
        titleLabel.alpha = 1;
        swipeLabel.alpha = 1;
    } completion:^(BOOL completed) {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(pulse) userInfo:nil repeats:YES];
        [timer fire];
    }];
    _scrollView.delegate = self;
    _scrollView.translatesAutoresizingMaskIntoConstraints = YES;
    _scrollView.contentSize = CGSizeMake(640, 568);
    
    UIColor *grayColor = [UIColor colorWithRed:205.0/255.0 green:205.0/255.0 blue:205.0/255.0 alpha:1];
    UILabel *phoneNumberRequest1 = [[UILabel alloc] initWithFrame:CGRectMake(320, 30, 320, 30)];
    phoneNumberRequest1.text = @"Let's get started, please";
    phoneNumberRequest1.textAlignment = NSTextAlignmentCenter;
    phoneNumberRequest1.font = [UIFont fontWithName:@"Roboto-Light" size:25];
    phoneNumberRequest1.textColor = grayColor;
    [_scrollView addSubview:phoneNumberRequest1];
    UILabel *phoneNumberRequest2 = [[UILabel alloc] initWithFrame:CGRectMake(320, 60, 320, 30)];
    phoneNumberRequest2.text = @"enter your number.";
    phoneNumberRequest2.textAlignment = NSTextAlignmentCenter;
    phoneNumberRequest2.font = [UIFont fontWithName:@"Roboto-Light" size:25];
    phoneNumberRequest2.textColor = grayColor;
    [_scrollView addSubview:phoneNumberRequest2];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(335, 100, 290, .5)];
    line.backgroundColor =grayColor;
    [_scrollView addSubview:line];
    
    phoneNumberPrefix = [[UILabel alloc] initWithFrame:CGRectMake(375, 120, 40, 30)];
    phoneNumberPrefix.text = @"+1";
    phoneNumberPrefix.font = [UIFont fontWithName:@"Roboto-Light" size:24];
    phoneNumberPrefix.textColor = grayColor;
    [_scrollView addSubview:phoneNumberPrefix];
    
    textField = [[UITextField alloc] initWithFrame:CGRectMake(410, 120, 200, 30)];
    textField.font = [UIFont fontWithName:@"Roboto-Light" size:24];
    textField.placeholder = @"(999) 999-9999";
    textField.delegate = self;
    textField.textColor = [UIColor blackColor];
    textField.keyboardType = UIKeyboardTypeNumberPad;
    [_scrollView addSubview:textField];
    
    
    verifyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    verifyButton.frame = CGRectMake(380, 180, 200, 60);
    [verifyButton setTitle:@"Verify" forState:UIControlStateNormal];
    [verifyButton setTitleColor:grayColor forState:UIControlStateDisabled];
    verifyButton.titleLabel.font = [UIFont fontWithName:@"Roboto-Light" size:23];
    verifyButton.backgroundColor = [UIColor colorWithRed:0 green:196/255.0 blue:178/255.0 alpha:1];
    verifyButton.layer.cornerRadius = 4;
    verifyButton.enabled = NO;
    [verifyButton addTarget:self action:@selector(verify:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:verifyButton];
    
//    UILabel *alreadyHaveVerifiyCode = [[UILabel alloc] initWithFrame:CGRectMake(380, 250, 200, 60)];
//    alreadyHaveVerifiyCode.textAlignment = NSTextAlignmentCenter;
//    alreadyHaveVerifiyCode.text = @"I already have my verification code.";
//    alreadyHaveVerifiyCode.textAlignment = NSTextAlignmentCenter;
//    alreadyHaveVerifiyCode.font = [UIFont fontWithName:@"Roboto-Light" size:17];
//    alreadyHaveVerifiyCode.textColor = grayColor;
    
    alreadyHaveVerifiyCode = [UIButton buttonWithType:UIButtonTypeCustom];
    alreadyHaveVerifiyCode.frame =CGRectMake(368, 230, 230, 60);
    alreadyHaveVerifiyCode.titleLabel.textAlignment = NSTextAlignmentCenter;
    [alreadyHaveVerifiyCode setTitleColor:grayColor forState:UIControlStateNormal];
    [alreadyHaveVerifiyCode setTitle:@"I have my verification code." forState:UIControlStateNormal];
    alreadyHaveVerifiyCode.backgroundColor = [UIColor clearColor];
    alreadyHaveVerifiyCode.titleLabel.font = [UIFont fontWithName:@"Roboto-Light" size:14];
    [alreadyHaveVerifiyCode addTarget:self action:@selector(hasCode:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:alreadyHaveVerifiyCode];
    
    verifyField = [[UITextField alloc] initWithFrame:CGRectMake(380, 275, 200, 30)];
    verifyField.font = [UIFont fontWithName:@"Roboto-Light" size:23];
    verifyField.textAlignment = NSTextAlignmentCenter;
    verifyField.placeholder = @"D09JF";
    verifyField.delegate = self;
    verifyField.textColor = [UIColor blackColor];
    verifyField.alpha = 0;
    verifyField.returnKeyType = UIReturnKeyGo;
    [_scrollView addSubview:verifyField];
    
    verifyLabel = [[UILabel alloc] initWithFrame:CGRectMake(320, 210, 320, 30)];
    verifyLabel.text = @"Enter your verification number.";
    verifyLabel.textAlignment = NSTextAlignmentCenter;
    verifyLabel.font = [UIFont fontWithName:@"Roboto-Light" size:15];
    verifyLabel.textColor = grayColor;
    verifyLabel.alpha = 0;
    [_scrollView addSubview:verifyLabel];
    
    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(320, 240, 320, 30);
    backButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [backButton setTitleColor:grayColor forState:UIControlStateNormal];
    [backButton setTitle:@"go back" forState:UIControlStateNormal];
    backButton.backgroundColor = [UIColor clearColor];
    backButton.titleLabel.font = [UIFont fontWithName:@"Roboto-Light" size:14];
    [backButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    backButton.alpha = 0;
    [_scrollView addSubview:backButton];
    
    textField.text = @"(972) 310-4741";
    verifyButton.enabled = YES;
    [_scrollView setContentOffset:CGPointMake(320, 0)];
}

- (void)goBack:(UIButton *)button {
    [UIView animateWithDuration:.5 animations:^{
        verifyButton.alpha = 1;
        alreadyHaveVerifiyCode.alpha = 1;
        verifyField.alpha = 0;
        verifyField.center = CGPointMake(verifyField.center.x, verifyField.center.y + 100);
        backButton.alpha = 0;
        verifyLabel.alpha = 0;
    }completion:^(BOOL isCompleted){
        [UIView animateWithDuration:.4 animations:^{
            if ([verifyField isFirstResponder]) [verifyField resignFirstResponder];
        }completion:nil];
    }];
}

- (void)hasCode:(UIButton *)button {
    [UIView animateWithDuration:.5 animations:^{
        verifyButton.alpha = 0;
        alreadyHaveVerifiyCode.alpha = 0;
        verifyField.alpha = 1;
        verifyField.center = CGPointMake(verifyField.center.x, verifyField.center.y - 100);
        backButton.alpha = 1;
    }completion:^(BOOL isCompleted){
        [UIView animateWithDuration:.4 animations:^{
            verifyLabel.alpha = 1;
            [verifyField becomeFirstResponder];
        }completion:nil];
    }];
}

- (void)verify:(UIButton *)button {
    NSString *phoneRegex = @"^((\\+)|(00))[0-9]{6,14}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    NSString *finalString = [[[[[NSString stringWithFormat:@"+%@", textField.text] stringByReplacingOccurrencesOfString:@"(" withString:@""]  stringByReplacingOccurrencesOfString:@")" withString:@""] stringByReplacingOccurrencesOfString:@"-" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"Final:%@", finalString);
    BOOL phoneValidates = [phoneTest evaluateWithObject:finalString];
    if (!phoneValidates || finalString.length < 11) {
        [UIView animateWithDuration:.9 delay:0 usingSpringWithDamping:0.1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
            phoneNumberPrefix.center = CGPointMake(phoneNumberPrefix.center.x + 5, phoneNumberPrefix.center.y);
            textField.center = CGPointMake(textField.center.x + 5, textField.center.y);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:.1 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
                phoneNumberPrefix.center = CGPointMake(phoneNumberPrefix.center.x - 5, phoneNumberPrefix.center.y);
                textField.center = CGPointMake(textField.center.x - 5, textField.center.y);
            } completion:nil];
            
        }];
    }
    else {
        verifyButton.enabled = NO;
        [[MSFetcher sharedInstance] verifyPhoneNumber:finalString success:^{
            ;
        }failure:nil];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([verifyField isFirstResponder]) {
        [verifyField resignFirstResponder];
    }
    else if ([textField isFirstResponder]){
        [textField resignFirstResponder];
    }
}

- (void)enteredVerification {
    UIView *overlay = [[UIView alloc] initWithFrame:self.view.bounds];
    overlay.backgroundColor = [UIColor colorWithWhite:.3 alpha:.5];
    UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    aiv.center = self.view.center;
    [overlay addSubview:aiv];
    [aiv startAnimating];
    overlay.alpha = 0;
    [UIView animateWithDuration:.5 animations:^{
        overlay.alpha = 1;
    }completion:nil];
    [[MSFetcher sharedInstance] confirmVerification:verifyField.text success:^{
        NSString *finalString = [[[[textField.text stringByReplacingOccurrencesOfString:@"(" withString:@""]  stringByReplacingOccurrencesOfString:@")" withString:@""] stringByReplacingOccurrencesOfString:@"-" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
        [[NSUserDefaults standardUserDefaults] setObject:finalString forKey:@"PhoneNumber"];
        [aiv stopAnimating];
        [UIView animateWithDuration:.5 animations:^{
            overlay.alpha = 0;
        }completion:^(BOOL completion) {
            [overlay removeFromSuperview];
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    } failure:^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Verification" message:@"Please try again" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }];
}

- (BOOL)textField:(UITextField *)aTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (aTextField == textField) {
        int length = [self getLength:textField.text];
        verifyButton.enabled = length > 0;
        
        if(length == 10)
        {
            if(range.length == 0)
            return NO;
        }
        
        if(length == 3)
        {
            NSString *num = [self formatNumber:textField.text];
            textField.text = [NSString stringWithFormat:@"(%@) ",num];
            if(range.length > 0)
            textField.text = [NSString stringWithFormat:@"%@",[num substringToIndex:3]];
        }
        else if(length == 6)
        {
            NSString *num = [self formatNumber:textField.text];
            //NSLog(@"%@",[num  substringToIndex:3]);
            //NSLog(@"%@",[num substringFromIndex:3]);
            textField.text = [NSString stringWithFormat:@"(%@) %@-",[num  substringToIndex:3],[num substringFromIndex:3]];
            if(range.length > 0)
            textField.text = [NSString stringWithFormat:@"(%@) %@",[num substringToIndex:3],[num substringFromIndex:3]];
        }
        
        return YES;
    }
    else {
        if ([string isEqualToString:@"\n"] && verifyField.text.length == 5) {
            [self enteredVerification];
        }
        if ([verifyField.text stringByReplacingCharactersInRange:range withString:string].length > 5) {
            return NO;
        }
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

-(void)colorizeLabelForAWhile:(UILabel *)label withUIColor:(UIColor *)tempColor animated:(BOOL)animated
{
    // We will:
    //      1) Duplicate the given label as a temporary UILabel with a new color.
    //      2) Add the temp label to the super view with alpha 0.0
    //      3) Animate the alpha to 1.0
    //      4) Wait for awhile.
    //      5) Animate back and remove the temporary label when we are done.
    
    // Duplicate the label and add it to the superview
    UILabel *tempLabel = [[UILabel alloc] init];
    tempLabel.textColor = tempColor;
    tempLabel.font = label.font;
    tempLabel.alpha = 0;
    tempLabel.textAlignment = label.textAlignment;
    tempLabel.text = label.text;
    [label.superview addSubview:tempLabel];
    tempLabel.frame = label.frame;
    
    // Reveal the temp label and hide the current label.
    if (animated) [UIView beginAnimations:nil context:nil];
    tempLabel.alpha = 1;
    label.alpha = 0;
    if (animated) [UIView commitAnimations];
    
    // Wait for while and change it back.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if (animated) {
            // Change it back animated
            [UIView animateWithDuration:0.5 animations:^{
                // Animate it back.
                label.alpha = 1;
                tempLabel.alpha = 0;
            } completion:^(BOOL finished){
                // Remove the tempLabel view when we are done.
                [tempLabel removeFromSuperview];
            }];
        } else {
            // Change it back at once and remove the tempLabel view.
            label.alpha = 1.0;
            [tempLabel removeFromSuperview];
        }
    });
}

- (void)pulse
{
    [self colorizeLabelForAWhile:swipeLabel withUIColor:[UIColor whiteColor] animated:YES];


}

@end
