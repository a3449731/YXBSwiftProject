#source 'https://github.com/CocoaPods/Specs.git'
source 'https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git'

 platform :ios, '11.0'

target 'YXBSwiftProject' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_modular_headers!

  # Pods for YXBSwiftProject

pod 'XHLaunchAd', '~> 3.9.8' # 启动页 很完善
pod 'EAIntroView', '~> 2.12.0' # 引导页 很不错
pod 'CYLTabBarController', '~> 1.28.4'
#pod 'YTKNetwork', '~> 2.0.4' # 依赖AFNetworking3.0以上, 3.0中含有UIWebView,无法上架
pod 'YTKNetwork', '~> 3.0.5' # 依赖AFNetworking4.0以上
pod 'SDCycleScrollView', '~> 1.80' # 依赖SDWebImage 5.0以上
pod 'IGListKit', '~> 4.0.0'
pod 'QMUIKit'
pod 'Masonry', '~> 1.1.0'
pod 'MJRefresh','~> 3.1.12'
pod 'DZNEmptyDataSet', '~> 1.8.1'
pod 'Toast', '~> 3.1.0'
pod 'SVProgressHUD', '~> 2.1.2'
pod 'MBProgressHUD','~> 1.0.0'
pod 'TZImagePickerController', '~> 3.2.7'
#pod 'IDMPhotoBrowser', '~> 1.11.3' #依赖SDWebImage 与SDCycleScrollView冲突,先导入SDCycleScrollView
pod 'SGQRCode', '~> 3.0.1' # 扫码
pod 'FDFullscreenPopGesture', '~> 1.1'
pod 'PPNumberButton', '~> 0.8.0'
pod 'MZFormSheetPresentationController', '~> 2.4.3'
pod 'DateTools', '~> 2.0.0'
pod 'BGFMDB', '~> 2.0.9'
pod 'UICKeyChainStore', '~> 2.2.1' #钥匙串存储
pod 'YYModel', '~> 1.0.4'
pod 'YYText', '~> 1.0.7'
pod 'YYCategories', '~> 1.0.4'
pod 'RRSwipeCell', '~> 0.1.1'
pod 'HMSegmentedControl', '~> 1.5.3'
pod 'WMPageController', '~> 2.5.2'
pod 'JXCategoryView','~> 1.5.5'
pod 'JXPagingView/Pager', '~> 2.0.0.0'
pod 'XLForm', '~> 4.1.0'
pod 'IQKeyboardManager', '~> 6.5.4'
pod 'SocketRocket', '~> 0.5.1'

# 友盟
pod 'UMCommon'
pod 'UMDevice'
pod 'UMCCommonLog', :configurations => ['Debug'] # 仅debug模式下导入
# 可选集成
pod 'UMLink'   # 智能超链产品
pod 'UMABTest'  # 统计产品中ABTest功能

# 本地源码依赖库
def loaclPods
# 配置环境，测试下的
pod 'DBDebugToolkit', :configurations => ['Debug'], :path => './LocalPods/DBDebugToolkit'
pod 'SJBaseVideoPlayer', :path => './LocalPods/SJVideo/SJBaseVideoPlayer'
pod 'SJUIKit', :path => './LocalPods/SJVideo/SJUIKit'
pod 'SJVideoPlayer', :path => './LocalPods/SJVideo/SJVideoPlayer'
#pod 'SVGAPlayer', :path => './LocalPods/SVGAPlayer'

pod 'TXIMSDK_Plus_iOS', '~>6.6.3002' # 这个是线上版本
pod 'TUICore', :path => './LocalPods/TUIKit/TUICore'
pod 'TUIChat', :path => './LocalPods/TUIKit/TUIChat'
pod 'TUIContact', :path => './LocalPods/TUIKit/TUIContact'
pod 'TUIConversation', :path => './LocalPods/TUIKit/TUIConversation'
pod 'TUIGroup', :path => './LocalPods/TUIKit/TUIGroup'
pod 'TUIOfflinePush', :path => './LocalPods/TUIKit/TUIOfflinePush'
end
loaclPods()

loaclPods()

# 支付宝支付
 pod 'AlipaySDK-iOS'
 
 pod 'ReactiveObjC'

#pod 'Charts'

# swift库
def swiftFoundation

  pod 'RxSwift', '~> 6.6.0'
  pod 'RxCocoa'
  pod 'R.swift'
  #生物识别，指纹解锁、面部识别
  pod 'BiometricAuthentication'
  #加载框, Toast, TODO: 封装一层Toast调用
  pod 'Toast-Swift', '~> 5.0.1'
  #swift版Masonry
  pod 'SnapKit'
  pod 'SwifterSwift'
  pod 'Moya'
  pod 'HandyJSON'
  pod 'ObjectMapper'
  pod 'MJExtension'
  
end

swiftFoundation()

end
