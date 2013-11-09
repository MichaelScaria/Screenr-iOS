//
//  MSFetcher.m
//  Screenr
//
//  Created by Michael Scaria on 11/9/13.
//  Copyright (c) 2013 MichaelScaria. All rights reserved.
//

#import "MSFetcher.h"

#import "AFNetworking.h"
#import "JSONKit.h"
//#define kRootURL @"http://Michaels-MacBook-Pro.local:3000/api"
#define kRootURL @"http://0.0.0.0:3000"

@implementation MSFetcher
+ (MSFetcher *)sharedInstance
{
    static MSFetcher *sharedInstance = nil;
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        sharedInstance = [[MSFetcher alloc] init];
    });
    
    return sharedInstance;
}

- (void)verifyPhoneNumber:(NSString *)number success:(void (^)(void))success failure:(void (^)(void))failure {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/api/signup", kRootURL]]];
    [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    [request setHTTPBody:[[NSString stringWithFormat:@"signup_number=%@", number] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPMethod:@"POST"];
    NSError *error = nil; NSURLResponse *response = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (error) {
        NSLog(@"Error:%@", error.localizedDescription);
        if (failure) failure();
    }
    else {
        NSDictionary *result = [[JSONDecoder decoder] objectWithData:data];
        [result enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if ([key isEqualToString:@"error"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your phone number is invalid." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alert show];
            }
            else if ([obj isEqualToString:@"sent"]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sent" message:@"Check your messages for your verification code." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alert show];
            }
            else if ([obj isEqualToString:@"resent"]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Resent" message:@"Check your messages for your verification code." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alert show];
            }
        }];
    }
}
@end
