//
//  GGUserNameQuery.m
//  Security
//
//  Created by Dola's MAC on 10/09/2013.
//  Copyright (c) 2013 GivtGram. All rights reserved.
//

#import "GGUserNameQuery.h"

@interface GGUserNameQuery (){
    
    NSUserDefaults * defaults;
}

@end

@implementation GGUserNameQuery

-(id)init{
    
    self = [super init];
    
    if (self) {
        
        defaults = [NSUserDefaults standardUserDefaults];
    }
    
    return self;
}

+(id)allocWithZone:(NSZone *)zone {
    
    return [self sharedUserNameQuery];
}


+(GGUserNameQuery *)sharedUserNameQuery{
    
    static GGUserNameQuery * userNameQuery = nil;
    
    if (!userNameQuery) {
        
        userNameQuery = [[super allocWithZone:nil] init];
    }
    
    return userNameQuery;
}



-(BOOL)saveObject:(NSString *)object forKey:(NSString *)key{
    
    BOOL success = NO;
    
    // check to see if you not saving twice
    
    if (object != [self userNameForKey:key]) {
        
        [defaults setObject:object forKey:key];
        success = [defaults synchronize];
        
    }    
    
    if (success) {
        
        return success;
        
    }else{
        
        return success;
    }
}

-(NSString *)userNameForKey:(NSString *)key{
    
    return  [defaults objectForKey:key];
}

-(BOOL)isUsernameAvailable:(NSString *)key{
    
    if ([defaults objectForKey:key]) {
        
        return YES;
        
    }else{
        
        return NO;
    }
    
}


-(void)deleteUserNameForKey:(NSString *)key{
    
    [defaults removeObjectForKey:key];
}



@end
