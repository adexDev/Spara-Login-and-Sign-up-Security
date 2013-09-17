//
//  GGUserNameQuery.h
//  Security
//
//  Created by Dola's MAC on 10/09/2013.
//  Copyright (c) 2013 GivtGram. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GGUserNameQuery : NSObject

+(GGUserNameQuery *)sharedUserNameQuery;

-(BOOL)saveObject:(NSString *)object forKey:(NSString *) key;
-(NSString *)userNameForKey:(NSString *) key;
-(BOOL)isUsernameAvailable:(NSString *) key;
-(void)deleteUserNameForKey:(NSString *) key;

@end
