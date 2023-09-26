Pod::Spec.new do |spec|
  spec.name         = 'TUIOfflinePush'
  spec.version      = '6.6.3002'
  spec.platform     = :ios
  spec.ios.deployment_target = '9.0'
  spec.license      = { :type => 'Proprietary',
      :text => <<-LICENSE
        copyright 2017 tencent Ltd. All rights reserved.
        LICENSE
       }
  spec.homepage     = 'https://cloud.tencent.com/document/product/269/3794'
  spec.documentation_url = 'https://cloud.tencent.com/document/product/269/9147'
  spec.authors      = 'tencent video cloud'
  spec.summary      = 'TUIOfflinePush'
  
  spec.requires_arc = true

  spec.source = { :path => './' }
  spec.source_files = 'TUIOfflinePush/**/*.{h,m,mm,c}'
  
  spec.resource = [
  'Resources/*.bundle'
  ]
  spec.dependency 'TUICore'
  
#  spec.default_subspec = 'APNS'
  
#  spec.subspec 'VoIP' do |ss|
#    ss.dependency 'TUIOfflinePush/APNS'
#    ss.source_files = 'VoIP/**/*'
#    ss.frameworks = 'CallKit'
#  end
  
#  spec.subspec 'APNS' do |ss|
#    ss.dependency 'APNS'
#    ss.source_files = 'APNS/**/*'
#  end
  
#  spec.subspec 'TPNS' do |ss|
#    ss.dependency 'TUIOfflinePush/Base'
#    ss.dependency 'TPNS-iOS'
#    ss.source_files = 'TPNS/**/*'
#  end
  
#  spec.subspec 'Base' do |ss|
#    ss.dependency 'TUICore'
#    ss.source_files = 'TUIOfflinePush/Base/**/*'
#  end
  
end
