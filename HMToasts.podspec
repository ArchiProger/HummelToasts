Pod::Spec.new do |spec|
  spec.name          = 'HMToasts'
  spec.version       = '1.0.0'
  spec.license       = 'MIT'
  spec.homepage      = 'https://github.com/ArchiProger/HMToasts'
  spec.authors       = { 'Arthur Danilov' => 'danilov985@icloud.com' }
  spec.summary       = 'A simple solution for implementing beautiful Toasts that Apple does not implement in any way'
  spec.source        = { :git => 'https://github.com/ArchiProger/HMToasts.git', :tag => spec.version.to_s }
  spec.swift_version = '5.0'

  spec.ios.deployment_target  = '15.0'

  spec.source_files  = 'HMToasts/**/*.swift'

  spec.ios.framework  = 'SwiftUI'
  spec.platform = :ios, '15.0'

  # spec.dependency 'SomeOtherPod'
end