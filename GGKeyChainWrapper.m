//
//  GGKeyChainWrapper.m
//  Security
//
//  Created by Dola's MAC on 09/09/2013.
//  Copyright (c) 2013 GivtGram. All rights reserved.
//

#import "GGKeyChainWrapper.h"
#import <Security/Security.h>
#import <CommonCrypto/CommonHMAC.h>

@interface GGKeyChainWrapper ()

+(NSMutableDictionary *)setupSearchDirectoryForUsername:(NSString *) username;
+(NSData *)searchKeychainCopyMatchingUsername:(NSString *) username;

+(BOOL) updateKeychainValue:(NSString *) password forUsername:(NSString *) username;

@end


@implementation GGKeyChainWrapper

+(NSMutableDictionary *)setupSearchDirectoryForUsername:(NSString *) username {
    
    NSMutableDictionary * setupDictionary = [NSMutableDictionary dictionary];
    
    // Password Specification for this type of keychain
    [setupDictionary  setObject:(__bridge id) kSecClassGenericPassword forKey:(__bridge id) kSecClass];
    
    // The keychain accessor
    [setupDictionary setObject:@"GivtGram" forKey:(__bridge id) kSecAttrService];
    
    // Identify the account that will be accessing the keychain
    NSData * encodeUsername = [username dataUsingEncoding:NSUTF8StringEncoding];
    [setupDictionary setObject:encodeUsername forKey:(__bridge id) kSecAttrGeneric];
    [setupDictionary setObject:encodeUsername forKey:(__bridge id) kSecAttrAccount];
    
    return setupDictionary;
}



+(NSData *)searchKeychainCopyMatchingUsername:(NSString *) username{
    
    NSMutableDictionary * searchDictionary = [self setupSearchDirectoryForUsername:username];
    
    [searchDictionary setObject:(__bridge id) kSecMatchLimitOne forKey:(__bridge id) kSecMatchLimit];
    [searchDictionary setObject:(__bridge id) kCFBooleanTrue forKey:(__bridge id) kSecReturnData];
    
    
    NSData * result = nil;
    CFTypeRef foundDictionary = NULL;
    
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef) searchDictionary, &foundDictionary);
    
    
    if (status == noErr) {
        
        result = (__bridge_transfer NSData *) foundDictionary;
    }else{
        
        result = nil;       
    }
    
    return result;
}


+(NSString *) keychainStringFromMatchingUsername:(NSString *) username {
    
    NSData * valueData = [self searchKeychainCopyMatchingUsername:username];
    
    if (valueData) {
        
       return  [[NSString alloc] initWithData:valueData encoding:NSUTF8StringEncoding];
        
    }else{
        
        return nil;
    }
}



+(BOOL) createKeychainValue:(NSString *) password forUsername:(NSString *) username {
    
    NSMutableDictionary * dictionary = [self setupSearchDirectoryForUsername:username];
    NSData *valueData = [password dataUsingEncoding:NSUTF8StringEncoding];
    [dictionary setObject:valueData forKey:(__bridge id) kSecValueData];
    
    // Protect the keychain so that it only valid when the device is unlocked.
    
    [dictionary setObject:(__bridge id) kSecAttrAccessibleWhenUnlocked forKey:(__bridge id) kSecAttrAccessible];
    
    // Add
    
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef) dictionary, NULL);
    
    if (status == errSecSuccess) {
        
        return YES;
        
    }else if (status == errSecDuplicateItem){
        
        
        return [self updateKeychainValue:password forUsername:username];
        
    }else{
        
        return NO;
    }
    
}


+(BOOL) updateKeychainValue:(NSString *) password forUsername:(NSString *) username {
    
    NSMutableDictionary * searchDictionary = [self setupSearchDirectoryForUsername:username];
    NSMutableDictionary * updateDictionary = [NSMutableDictionary dictionary];
    NSData * valueData = [password dataUsingEncoding:NSUTF8StringEncoding];
    [updateDictionary setObject:valueData forKey:(__bridge id) kSecValueData];
    
    
    // Update
    
    OSStatus status = SecItemUpdate((__bridge CFDictionaryRef) updateDictionary,
                                    (__bridge CFDictionaryRef)searchDictionary);
    
    if (status == errSecSuccess) {
        
        return YES;
    }else{
        
        return NO;
    }
}


+(void) deleteItemFromKeychainWithIdentifier:(NSString *) username {
    
    NSMutableDictionary * searchDictionary = [self setupSearchDirectoryForUsername:username];
    CFDictionaryRef dictionary = (__bridge  CFDictionaryRef) searchDictionary;
    
    
    // Delete
    SecItemDelete(dictionary);
}






















@end
