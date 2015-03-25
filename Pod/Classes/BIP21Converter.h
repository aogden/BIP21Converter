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

/**
 Create a URL for the provided BIT21Object using the BIP21 URI protocol
 @param object The BIT21Object to be converted to a URL
 @returns NSURL* A URL for the object
 */
+ (NSURL*) encodeObject:(BIP21Object*)object;

/**
 Create a URL for the provided bitcoin parameters using the BIP21 URI protocol
 @param address The bitcoin address
 @param amount The amount in BTC
 @param label The label for the payment
 @param message The message for the payment
 @param additionalParameter Any additional parameters you want conveyed in your URL
 @returns NSURL* A URL for the object
 */
+ (NSURL*) encodeAddress:(NSString*)address amount:(NSString*)amount label:(NSString*)label message:(NSString*)message additionalParameters:(NSDictionary*)params;

/**
 Create a BIP21Object decoded from the provided URL
 @param url A BIP21 compliant url
 @returns BIP21Object* an object containing the data from the URL
 */
+ (BIP21Object*) decodeURL:(NSURL*)url;

@end