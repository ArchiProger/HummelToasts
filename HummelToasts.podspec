Pod::Spec.new do |spec|
  spec.name          = 'HummelToasts'
  spec.version       = '1.0.1'
  spec.license       = 'MIT'
  spec.homepage      = 'https://github.com/ArchiProger/HummelToasts'
  spec.authors       = { 'Arthur Danilov' => 'danilov985@icloud.com' }
  spec.summary       = 'A simple solution for implementing beautiful Toasts that Apple does not implement in any way'
  spec.source        = { :git => 'https://github.com/ArchiProger/HummelToasts.git', :tag => spec.version.to_s }
  spec.swift_version = '5.0'
  
  spec.ios.deployment_target  = '15.0'

  spec.source_files  = 'Hummel Toasts/**/*.swift'

  spec.ios.framework  = 'SwiftUI'
  spec.platform = :ios, '15.0'
end