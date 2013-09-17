//
//  GGSignUpOperation.m
//  Security
//
//  Created by Dola's MAC on 10/09/2013.
//  Copyright (c) 2013 GivtGram. All rights reserved.
//

#import "GGSignUpOperation.h"
#import "GGUserNameQuery.h"
#import "GGKeyChainWrapper.h"

@implementation GGSignUpOperation
@synthesize emailAddress = _emailAddress;
@synthesize username = _username;
@synthesize password = _password;



-(void)saveUserDetails{
    
    // Firstly Save to the server database :
    
    
    /** if user details is saved successfuly ,
        then you can go on saving the both username
        and password to userdefault and keychainItem.
     */
}

@end
