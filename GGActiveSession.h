//
//  GGActiveSession.h
//  Security
//
//  Created by Dola's MAC on 10/09/2013.
//  Copyright (c) 2013 GivtGram. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GGActiveSession : NSObject

@property (nonatomic, getter = isActive, readonly ) BOOL active;

-(void)clearUserInformation;
@end
