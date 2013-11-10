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
#define kRootURL @"http://screenr.herokuapp.com"
//#define kRootURL @"http://0.0.0.0:3000"

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

- (void)confirmVerification:(NSString *)verification success:(void (^)(void))success failure:(void (^)(void))failure {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/api/verify", kRootURL]]];
    [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    [request setHTTPBody:[[NSString stringWithFormat:@"validation_code=%@", verification] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPMethod:@"POST"];

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = (NSData *)responseObject;
        NSDictionary *result = [[JSONDecoder decoder] objectWithData:data];
        if ([[result objectForKey:@"final"] isEqualToString:@"success"]){
            if (success) success();
        }
        else if (failure) failure();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (failure) failure();
    }];
    [operation start];
}

- (void)searchNumbersWithAreaCode:(NSString *)areaCode success:(void (^)(NSArray *))success failure:(void (^)(void))failure {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/api/area_code", kRootURL]]];
    [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    [request setHTTPBody:[[NSString stringWithFormat:@"area_code=%@", areaCode] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPMethod:@"POST"];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = (NSData *)responseObject;
        NSArray *numbers = [[JSONDecoder decoder] objectWithData:data];
        if (numbers && numbers.count > 0){
            if (success) success(numbers[0]);
        }
        else if (failure) failure();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (failure) failure();
    }];
    [operation start];
    
}
- (void)searchNumbersWithInitial:(NSString *)initial success:(void (^)(NSArray *))success failure:(void (^)(void))failure {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/api/initial", kRootURL]]];
    [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    [request setHTTPBody:[[NSString stringWithFormat:@"initial=%@", initial] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPMethod:@"POST"];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = (NSData *)responseObject;
        NSArray *numbers = [[JSONDecoder decoder] objectWithData:data];
        if (numbers && numbers.count > 0){
            NSLog(@"numbers:%@", numbers[0]);
            if (success) success(numbers[0]);
        }
        else if (failure) failure();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (failure) failure();
    }];
    [operation start];
    
}
- (void)searchNumbersWithState:(NSString *)state success:(void (^)(NSArray *))success failure:(void (^)(void))failure{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/api/state", kRootURL]]];
    [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    [request setHTTPBody:[[NSString stringWithFormat:@"state=%@", state] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPMethod:@"POST"];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = (NSData *)responseObject;
        NSArray *numbers = [[JSONDecoder decoder] objectWithData:data];
        if (numbers && numbers.count > 0){
            if (success) success(numbers[0]);
        }
        else if (failure) failure();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (failure) failure();
    }];
    [operation start];
    
}

- (void)buyNumber:(NSDictionary *)d success:(void (^)(void))success failure:(void (^)(void))failure {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/api/purchase", kRootURL]]];
    [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    [request setHTTPBody:[[NSString stringWithFormat:@"phone_number=%@&purchase=%@&region=%@&postal_code=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"PhoneNumber"], [d[@"number"] stringByReplacingOccurrencesOfString:@"+" withString:@""], d[@"region"], d[@"postal_code"]] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPMethod:@"POST"];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = (NSData *)responseObject;
        NSDictionary *d = [[JSONDecoder decoder] objectWithData:data];
        if ([d[@"final"] isEqualToString:@"success"]) {
            success();
        }
        else {
            if ( failure) {
                failure();
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (failure) failure();
    }];
    [operation start];
}

- (void)getInboxForPhoneNumber:(NSString *)number success:(void (^)(NSArray *))success failure:(void (^)(void))failure {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/api/inbox", kRootURL]]];
    [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    [request setHTTPBody:[[NSString stringWithFormat:@"phone_number=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"PhoneNumber"]] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPMethod:@"POST"];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = (NSData *)responseObject;
        NSArray *results = [[JSONDecoder decoder] objectWithData:data];
        success(results[0]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (failure) failure();
    }];
    [operation start];
}

- (void)messagesForConversation:(NSString *)conversationID success:(void (^)(NSArray *))success failure:(void (^)(void))failure {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/api/messages", kRootURL]]];
    [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    [request setHTTPBody:[[NSString stringWithFormat:@"conversation_id=%@",conversationID] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPMethod:@"POST"];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = (NSData *)responseObject;
        NSArray *results = [[JSONDecoder decoder] objectWithData:data];
        success(results);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (failure) failure();
    }];
    [operation start];
    
}

- (void)sendMessage:(NSString *)message InConversation:(NSString *)conversationID withNumber:(NSString *)number toNumber:(NSString *)aNumber success:(void (^)(NSArray *))success failure:(void (^)(void))failure {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/api/send", kRootURL]]];
    [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    [request setHTTPBody:[[NSString stringWithFormat:@"conversation_id=%@&number=%@&a_number=%@&message=%@",conversationID, number, aNumber, message] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPMethod:@"POST"];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = (NSData *)responseObject;
        NSArray *results = [[JSONDecoder decoder] objectWithData:data];
        success(results);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (failure) failure();
    }];
    [operation start];
}

- (void)startConversationFrom:(NSString *)number withMessage:(NSString *)message toNumber:(NSString *)nextNumber success:(void (^)(NSArray *))success failure:(void (^)(void))failure {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/api/start", kRootURL]]];
    [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    [request setHTTPBody:[[NSString stringWithFormat:@"number=%@&message=%@&next_number=%@",number, message, nextNumber] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPMethod:@"POST"];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = (NSData *)responseObject;
        NSArray *results = [[JSONDecoder decoder] objectWithData:data];
        success(results);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (failure) failure();
    }];
    [operation start];
}
@end
