//
//  GGKeyChainWrapper.h
//  Security
//
//  Created by Dola's MAC on 09/09/2013.
//  Copyright (c) 2013 GivtGram. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GGKeyChainWrapper : NSObject


+(NSString *) keychainStringFromMatchingUsername:(NSString *) username;
+(BOOL) createKeychainValue:(NSString *) password forUsername:(NSString *) username;
+(void) deleteItemFromKeychainWithIdentifier:(NSString *) username;
@end
