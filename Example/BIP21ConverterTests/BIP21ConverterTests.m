//
//  BIP21Tests.m
//  BIP21Tests
//
//  Created by Andrew Ogden on 3/24/15.
//  Copyright (c) 2015 aogden. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "BIP21Converter.h"

@interface BIP21Tests : XCTestCase

@end

@implementation BIP21Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testEncodeAddress {
    NSURL* url = [BIP21Converter encodeAddress:@"1TzRiCG2Kj7NNjEQzZx5Jiqf3WSgpAkMf" amount:nil label:nil message:nil additionalParameters:nil];
    XCTAssert([[url absoluteString] isEqualToString:@"bitcoin:1TzRiCG2Kj7NNjEQzZx5Jiqf3WSgpAkMf"], @"Pass");
}

- (void)testEncodeAddressAndAmount {
    NSURL* url = [BIP21Converter encodeAddress:@"1TzRiCG2Kj7NNjEQzZx5Jiqf3WSgpAkMf" amount:@"10" label:nil message:nil additionalParameters:nil];
    XCTAssert([[url absoluteString] isEqualToString:@"bitcoin:1TzRiCG2Kj7NNjEQzZx5Jiqf3WSgpAkMf?amount=10"], @"Pass");
}

- (void)testEncodeAddressAndAmountAndLabel {
    NSURL* url = [BIP21Converter encodeAddress:@"1TzRiCG2Kj7NNjEQzZx5Jiqf3WSgpAkMf" amount:@"10" label:@"Donation" message:nil additionalParameters:nil];
    XCTAssert([[url absoluteString] isEqualToString:@"bitcoin:1TzRiCG2Kj7NNjEQzZx5Jiqf3WSgpAkMf?amount=10&label=Donation"], @"Pass");
}

- (void)testEncodeAddressAndAmountAndLabelAndMessage {
    NSURL* url = [BIP21Converter encodeAddress:@"1TzRiCG2Kj7NNjEQzZx5Jiqf3WSgpAkMf"
                                        amount:@"10"
                                         label:@"Donation"
                                       message:@"Thanks!"
                          additionalParameters:nil];
    XCTAssert([[url absoluteString] isEqualToString:@"bitcoin:1TzRiCG2Kj7NNjEQzZx5Jiqf3WSgpAkMf?amount=10&label=Donation&message=Thanks!"], @"Pass");
}

- (void)testEncodeAddressAndAmountAndLabelAndMessageWithEncoding {
    NSURL* url = [BIP21Converter encodeAddress:@"1TzRiCG2Kj7NNjEQzZx5Jiqf3WSgpAkMf"
                                        amount:@"10"
                                         label:@"Donation"
                                       message:@"Thanks for the help!"
                          additionalParameters:nil];
    XCTAssert([[url absoluteString] isEqualToString:@"bitcoin:1TzRiCG2Kj7NNjEQzZx5Jiqf3WSgpAkMf?amount=10&label=Donation&message=Thanks%20for%20the%20help!"], @"Pass");
}

- (void)testEncodeObjectWithAddress {
    BIP21Object* obj = [BIP21Object objectWithAddress:@"1TzRiCG2Kj7NNjEQzZx5Jiqf3WSgpAkMf"];
    NSURL* url = [BIP21Converter encodeObject:obj];
    XCTAssert([[url absoluteString] isEqualToString:@"bitcoin:1TzRiCG2Kj7NNjEQzZx5Jiqf3WSgpAkMf"], @"Pass");
}

- (void)testEncodeObjectWithEverything {
    BIP21Object* obj = [BIP21Object objectWithAddress:@"1TzRiCG2Kj7NNjEQzZx5Jiqf3WSgpAkMf"];
    obj.amount = @"10";
    obj.label = @"Donation";
    obj.message = @"Thanks for the help!";
    NSURL* url = [BIP21Converter encodeObject:obj];
    XCTAssert([[url absoluteString] isEqualToString:@"bitcoin:1TzRiCG2Kj7NNjEQzZx5Jiqf3WSgpAkMf?amount=10&label=Donation&message=Thanks%20for%20the%20help!"], @"Pass");
}

- (void)testEncodeObjectWithAdditionalArguments {
    BIP21Object* obj = [BIP21Object objectWithAddress:@"1TzRiCG2Kj7NNjEQzZx5Jiqf3WSgpAkMf"];
    obj.amount = @"10";
    obj.label = @"Donation";
    obj.message = @"Thanks for the help!";
    obj.additionalParameters = @{@"color":@"Grey"};
    NSURL* url = [BIP21Converter encodeObject:obj];
    XCTAssert([[url absoluteString] isEqualToString:@"bitcoin:1TzRiCG2Kj7NNjEQzZx5Jiqf3WSgpAkMf?amount=10&label=Donation&message=Thanks%20for%20the%20help!&color=Grey"], @"Pass");
}

- (void)testEncodeObjectWithSeveralAdditionalArguments {
    BIP21Object* obj = [BIP21Object objectWithAddress:@"1TzRiCG2Kj7NNjEQzZx5Jiqf3WSgpAkMf"];
    obj.amount = @"10";
    obj.label = @"Donation";
    obj.message = @"Thanks for the help!";
    obj.additionalParameters = @{@"color":@"Grey",@"merchant":@"https://bitcoin.org"};
    NSURL* url = [BIP21Converter encodeObject:obj];
    XCTAssert([[url absoluteString] isEqualToString:@"bitcoin:1TzRiCG2Kj7NNjEQzZx5Jiqf3WSgpAkMf?amount=10&label=Donation&message=Thanks%20for%20the%20help!&color=Grey&merchant=https://bitcoin.org"], @"Pass");
}

- (void)testEncodeObjectWithNilObject {
    NSURL* url = [BIP21Converter encodeObject:nil];
    XCTAssert(url == nil, @"Pass");
}

- (void)testDecodeUrlWithAddress {
    NSURL* url = [NSURL URLWithString:@"bitcoin:1TzRiCG2Kj7NNjEQzZx5Jiqf3WSgpAkMf"];
    BIP21Object* obj = [BIP21Converter decodeURL:url];
    XCTAssert(obj != nil, @"Valid object");
    XCTAssert([obj.address isEqualToString:@"1TzRiCG2Kj7NNjEQzZx5Jiqf3WSgpAkMf"], @"Valid address");
}

- (void)testDecodeAddressAndAmount {
    NSURL* url = [NSURL URLWithString:@"bitcoin:1TzRiCG2Kj7NNjEQzZx5Jiqf3WSgpAkMf?amount=10"];
    BIP21Object* obj = [BIP21Converter decodeURL:url];
    XCTAssert(obj != nil, @"Valid object");
    XCTAssert([obj.address isEqualToString:@"1TzRiCG2Kj7NNjEQzZx5Jiqf3WSgpAkMf"], @"Valid address");
    XCTAssert([obj.amount isEqualToString:@"10"], @"Valid amount");
}

- (void)testDecodeAddressAndAmountAndLabel {
    NSURL* url = [NSURL URLWithString:@"bitcoin:1TzRiCG2Kj7NNjEQzZx5Jiqf3WSgpAkMf?amount=10&label=Donation"];
    BIP21Object* obj = [BIP21Converter decodeURL:url];
    XCTAssert(obj != nil, @"Valid object");
    XCTAssert([obj.address isEqualToString:@"1TzRiCG2Kj7NNjEQzZx5Jiqf3WSgpAkMf"], @"Valid address");
    XCTAssert([obj.amount isEqualToString:@"10"], @"Valid amount");
    XCTAssert([obj.label isEqualToString:@"Donation"], @"Valid label");
}

- (void)testDecodeAddressAndAmountAndLabelAndMessage {
    NSURL* url = [NSURL URLWithString:@"bitcoin:1TzRiCG2Kj7NNjEQzZx5Jiqf3WSgpAkMf?amount=10&label=Donation&message=Thanks!"];
    BIP21Object* obj = [BIP21Converter decodeURL:url];
    XCTAssert(obj != nil, @"Valid object");
    XCTAssert([obj.address isEqualToString:@"1TzRiCG2Kj7NNjEQzZx5Jiqf3WSgpAkMf"], @"Valid address");
    XCTAssert([obj.amount isEqualToString:@"10"], @"Valid amount");
    XCTAssert([obj.label isEqualToString:@"Donation"], @"Valid label");
    XCTAssert([obj.message isEqualToString:@"Thanks!"], @"Valid message");
}

- (void)testDecodeAddressAndAmountAndLabelAndEncodedMessage {
    NSURL* url = [NSURL URLWithString:@"bitcoin:1TzRiCG2Kj7NNjEQzZx5Jiqf3WSgpAkMf?amount=10&label=Donation&message=Thanks%20for%20the%20help!"];
    BIP21Object* obj = [BIP21Converter decodeURL:url];
    XCTAssert(obj != nil, @"Valid object");
    XCTAssert([obj.address isEqualToString:@"1TzRiCG2Kj7NNjEQzZx5Jiqf3WSgpAkMf"], @"Valid address");
    XCTAssert([obj.amount isEqualToString:@"10"], @"Valid amount");
    XCTAssert([obj.label isEqualToString:@"Donation"], @"Valid label");
    XCTAssert([obj.message isEqualToString:@"Thanks for the help!"], @"Valid message");
}

- (void)testDecodeAddressWithAdditionalParameters {
    NSURL* url = [NSURL URLWithString:@"bitcoin:1TzRiCG2Kj7NNjEQzZx5Jiqf3WSgpAkMf?amount=10&label=Donation&message=Thanks%20for%20the%20help!&color=Grey"];
    BIP21Object* obj = [BIP21Converter decodeURL:url];
    XCTAssert(obj != nil, @"Valid object");
    XCTAssert([obj.address isEqualToString:@"1TzRiCG2Kj7NNjEQzZx5Jiqf3WSgpAkMf"], @"Valid address");
    XCTAssert([obj.amount isEqualToString:@"10"], @"Valid amount");
    XCTAssert([obj.label isEqualToString:@"Donation"], @"Valid label");
    XCTAssert([obj.message isEqualToString:@"Thanks for the help!"], @"Valid message");
    XCTAssert([obj.additionalParameters count] == 1, @"Valid number of additional parameters");
    XCTAssert([[obj.additionalParameters valueForKey:@"color"] isEqualToString:@"Grey"], @"Valid additional parameter");
}

- (void)testDecodeAddressWithSeveralAdditionalParameters {
    NSURL* url = [NSURL URLWithString:@"bitcoin:1TzRiCG2Kj7NNjEQzZx5Jiqf3WSgpAkMf?amount=10&label=Donation&message=Thanks%20for%20the%20help!&color=Grey&merchant=https://bitcoin.org"];
    BIP21Object* obj = [BIP21Converter decodeURL:url];
    XCTAssert(obj != nil, @"Valid object");
    XCTAssert([obj.address isEqualToString:@"1TzRiCG2Kj7NNjEQzZx5Jiqf3WSgpAkMf"], @"Valid address");
    XCTAssert([obj.amount isEqualToString:@"10"], @"Valid amount");
    XCTAssert([obj.label isEqualToString:@"Donation"], @"Valid label");
    XCTAssert([obj.message isEqualToString:@"Thanks for the help!"], @"Valid message");
    XCTAssert([obj.additionalParameters count] == 2, @"Valid number of additional parameters");
    XCTAssert([[obj.additionalParameters valueForKey:@"color"] isEqualToString:@"Grey"], @"Valid additional parameter");
    XCTAssert([[obj.additionalParameters valueForKey:@"merchant"] isEqualToString:@"https://bitcoin.org"], @"Valid additional parameter");
}
@end
