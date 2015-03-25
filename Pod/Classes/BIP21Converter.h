//
//  BIP21Converter.h
//  BIP21Converter
//
//  Created by Andrew Ogden on 3/24/15.
//  Copyright (c) 2015 Andrew Ogden. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BIP21Object : NSObject

@property (nonatomic,strong) NSString* address;
@property (nonatomic,strong) NSString* amount;
@property (nonatomic,strong) NSString* label;
@property (nonatomic,strong) NSString* message;
@property (nonatomic,strong) NSDictionary* additionalParameters;

+ (instancetype) objectWithAddress:(NSString*)address;

- (id) initWithAddress:(NSString*)address;

@end

/**
 URI Encoder/Decoder for the BIP21 protocol at https://en.bitcoin.it/wiki/BIP_0021
 */
@interface BIP21Converter : NSObject

+ (NSURL*) encodeObject:(BIP21Object*)object;

+ (NSURL*) encodeAddress:(NSString*)address amount:(NSString*)amount label:(NSString*)label message:(NSString*)message additionalParameters:(NSDictionary*)params;

+ (BIP21Object*) decodeURL:(NSURL*)url;

@end