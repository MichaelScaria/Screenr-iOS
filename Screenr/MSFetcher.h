//
//  MSFetcher.h
//  Screenr
//
//  Created by Michael Scaria on 11/9/13.
//  Copyright (c) 2013 MichaelScaria. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSFetcher : NSObject
+ (MSFetcher *)sharedInstance;
- (void)verifyPhoneNumber:(NSString *)number success:(void (^)(void))success failure:(void (^)(void))failure;
@end
