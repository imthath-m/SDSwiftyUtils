

Pod::Spec.new do |spec|
 
  spec.name         = "SwiftUtils"
  spec.version      = "0.1.0"
  spec.summary      = "Commonly used utilities, extensions and custom protocols for Swift."

  spec.description  = <<-DESC
  This CocoaPod contains extensions different for primitive types such as Date, String and protocols such as Encodable, Decodable, Equatable. Custom protocols such as Distinguishable and Imitable are also added. 
                   DESC

  spec.homepage     = "https://gitlab.com/imthath_m/skydevpodspecs.git"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "Imthath M" => "imthath.m@icloud.com" }
  spec.social_media_url   = "https://twitter.com/imthath_m"
  spec.source       = { :git => "https://github.com/imthath-m/SwiftUtils.git", :tag => "#{spec.version}" }
  spec.swift_version = "4.2"
  spec.osx.deployment_target = "10.12"
  spec.ios.deployment_target = "9.0"
  spec.source_files  = "UtilitiesExample/Utils/*.swift"


end
