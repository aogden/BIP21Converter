# BIP21Converter

[![Version](https://img.shields.io/cocoapods/v/BIP21Converter.svg?style=flat)](http://cocoadocs.org/docsets/BIP21Converter)
[![License](https://img.shields.io/cocoapods/l/BIP21Converter.svg?style=flat)](http://cocoadocs.org/docsets/BIP21Converter)
[![Platform](https://img.shields.io/cocoapods/p/BIP21Converter.svg?style=flat)](http://cocoadocs.org/docsets/BIP21Converter)

BIP21Converter is a small class that handles encoding and decoding bitcoin URIs according to the scheme at https://en.bitcoin.it/wiki/BIP_0021

## Installation

BIP21Converter is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "BIP21Converter"

## Samples

A sample encoding of just an address could look like

```
NSURL* url = [BIP21Converter encodeAddress:@"1TzRiCG2Kj7NNjEQzZx5Jiqf3WSgpAkMf" amount:nil label:nil message:nil additionalParameters:nil];
```

which produces URI ```bitcoin:1TzRiCG2Kj7NNjEQzZx5Jiqf3WSgpAkMf```

---

Alternatively you can use the `BIP21Object` to encode like

```
BIP21Object* obj = [BIP21Object objectWithAddress:@"1TzRiCG2Kj7NNjEQzZx5Jiqf3WSgpAkMf"];
obj.amount = @"10";
obj.label = @"Donation";
obj.message = @"Thanks for the help!";
NSURL* url = [BIP21Converter encodeObject:obj];
```

which produces URI ```bitcoin:1TzRiCG2Kj7NNjEQzZx5Jiqf3WSgpAkMf?amount=10&label=Donation&message=Thanks%20for%20the%20help!```

---

URL decoding produces a `BIP21Object` as an output

```
NSURL* url = [NSURL URLWithString:@"bitcoin:1TzRiCG2Kj7NNjEQzZx5Jiqf3WSgpAkMf?amount=10&label=Donation"];
BIP21Object* obj = [BIP21Converter decodeURL:url];
```

## Author

Andrew Ogden

andrew@andrewogden.com

## License

BIP21Converter is available under the MIT license. See the LICENSE file for more info.