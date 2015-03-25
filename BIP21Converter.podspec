Pod::Spec.new do |s|
  s.name             = "BIP21Converter"
  s.version          = "0.1.0"
  s.summary          = "Encoding/Decoding library for the Bitcoin BIP 0021 URI scheme"
  s.description      = <<-DESC
                        This library provides an interface to encode and decode
                        URLs according to the BIP 0021 scheme defined at 
                        https://en.bitcoin.it/wiki/BIP_0021
                       DESC
  s.homepage         = "https://github.com/aogden/BIP21Converter"
  s.license          = 'MIT'
  s.author           = { "Andrew Ogden" => "andrew@andrewogden.com" }
  s.source           = { :git => "https://github.com/aogden/BIP21Converter.git", :tag => s.version.to_s }

  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'

  s.public_header_files = 'Pod/Classes/**/*.h'
end