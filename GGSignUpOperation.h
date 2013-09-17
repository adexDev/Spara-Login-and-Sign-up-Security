//
//  GGSignUpOperation.h
//  Security
//
//  Created by Dola's MAC on 10/09/2013.
//  Copyright (c) 2013 GivtGram. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GGSignUpOperation : NSObject

@property (strong, nonatomic) NSString * emailAddress;
@property (strong, nonatomic) NSString * username;
@property (strong, nonatomic) NSString * password;

-(void)saveUserDetails;

@end
