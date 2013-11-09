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
- (void)confirmVerification:(NSString *)verification success:(void (^)(void))success failure:(void (^)(void))failure;
- (void)searchNumbersWithAreaCode:(NSString *)areaCode success:(void (^)(NSArray *))success failure:(void (^)(void))failure;
- (void)searchNumbersWithInitial:(NSString *)initial success:(void (^)(NSArray *))success failure:(void (^)(void))failure;
- (void)searchNumbersWithState:(NSString *)state success:(void (^)(NSArray *))success failure:(void (^)(void))failure;
- (void)buyNumber:(NSDictionary *)number success:(void (^)(void))success failure:(void (^)(void))failure;

- (void)getInboxForPhoneNumber:(NSString *)number success:(void (^)(NSArray *))success failure:(void (^)(void))failure;
- (void)messagesForConversation:(NSString *)conversationID success:(void (^)(NSArray *))success failure:(void (^)(void))failure;
- (void)sendMessageInConversation:(NSString *)conversationID withNumber:(NSString *)number  success:(void (^)(NSArray *))success failure:(void (^)(void))failure;
@end
