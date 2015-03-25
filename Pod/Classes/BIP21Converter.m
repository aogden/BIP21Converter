//
//  BIP21Converter.m
//  BIP21Converter
//
//  Created by Andrew Ogden on 3/24/15.
//  Copyright (c) 2015 Andrew Ogden. All rights reserved.
//

#import "BIP21Converter.h"

@implementation BIP21Object

+ (instancetype) objectWithAddress:(NSString *)address
{
    return [[self alloc] initWithAddress:address];
}

- (id) initWithAddress:(NSString *)address
{
    if(self = [super init])
    {
        _address = address;
    }
    return self;
}

@end

NSString* const SCHEME = @"bitcoin";
NSString* const AMOUNT_KEY = @"amount";
NSString* const LABEL_KEY = @"label";
NSString* const MESSAGE_KEY = @"message";

@implementation BIP21Converter

+ (NSURL*) encodeAddress:(NSString*)address amount:(NSString*)amount label:(NSString*)label message:(NSString*)message additionalParameters:(NSDictionary *)params
{
    NSURLComponents *components = [NSURLComponents componentsWithString:[NSString stringWithFormat:@"%@:",SCHEME]];
    
    NSMutableArray* queryItems = [NSMutableArray array];
    if(amount)
    {
        [queryItems addObject:[NSURLQueryItem queryItemWithName:AMOUNT_KEY value:amount]];
    }
    if(label)
    {
        [queryItems addObject:[NSURLQueryItem queryItemWithName:LABEL_KEY value:label]];
    }
    if(message)
    {
        [queryItems addObject:[NSURLQueryItem queryItemWithName:MESSAGE_KEY value:message]];
    }
    if(params)
    {
        for (NSString* key in params.allKeys)
        {
            [queryItems addObject:[NSURLQueryItem queryItemWithName:key value:[params objectForKey:key]]];
        }
    }
    components.path = address;
    components.queryItems = queryItems.count > 0 ? queryItems : nil;
    
    return [components URL];
}

+ (NSURL*) encodeObject:(BIP21Object*)object
{
    if(object)
    {
        return [self encodeAddress:object.address amount:object.amount label:object.label message:object.message additionalParameters:object.additionalParameters];
    }
    
    return nil;
}

+ (BIP21Object*) decodeURL:(NSURL*)url;
{
    if(url)
    {
        BIP21Object* object = [[BIP21Object alloc] init];
        
        NSURLComponents* components = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:YES];
        NSMutableDictionary* additionalParameters = [NSMutableDictionary dictionary];
        for (NSURLQueryItem* queryItem in components.queryItems) {
            if([queryItem.name isEqualToString:AMOUNT_KEY])
            {
                object.amount = queryItem.value;
            }
            else if([queryItem.name isEqualToString:LABEL_KEY])
            {
                object.label = queryItem.value;
            }
            else if([queryItem.name isEqualToString:MESSAGE_KEY])
            {
                object.message = queryItem.value;
            }
            else
            {
                [additionalParameters setObject:queryItem.value forKey:queryItem.name];
            }
        }
        object.additionalParameters = additionalParameters;
        
        object.address = components.path;
        
        return object;
    }
    
    return nil;
}

@end