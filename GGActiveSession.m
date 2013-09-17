//
//  GGActiveSession.m
//  Security
//
//  Created by Dola's MAC on 10/09/2013.
//  Copyright (c) 2013 GivtGram. All rights reserved.
//

#import "GGActiveSession.h"
#import "GGUserNameQuery.h"
#import "GGKeyChainWrapper.h"
#import "GGSignUpOperation.h"
#import "GGSecurityConstants.h"


@implementation GGActiveSession
@synthesize active = _active;


-(BOOL)isActive{
    
    GGUserNameQuery * username = [GGUserNameQuery sharedUserNameQuery];
    
    // Check if the user value for key is no empty
    
    if ([username isUsernameAvailable:USER_NAME]
        && [GGKeyChainWrapper keychainStringFromMatchingUsername:[username userNameForKey:USER_NAME]]
                                                  /**     && check database server if both username and
                                                         password is available 
                                                   
                                                   */ ) {
        
        NSLog(@" session active");
        
        return YES;
        
    }else{
        
        // clear all user information
        
        [self clearUserInformation];
        
        NSLog(@" session in-active ");
        return NO;
        
    }
}

-(void)clearUserInformation{
    
    // Delete all the user information when this method is being called
    
    GGUserNameQuery * deleteUsername = [GGUserNameQuery sharedUserNameQuery];
    [deleteUsername deleteUserNameForKey:USER_NAME];
    [GGKeyChainWrapper deleteItemFromKeychainWithIdentifier:[deleteUsername userNameForKey:USER_NAME]];
    
}

@end
