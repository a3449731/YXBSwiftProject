#source 'https://github.com/CocoaPods/Specs.git'
source 'https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git'

 platform :ios, '11.0'

target 'YXBSwiftProject' do
  # Comment the next line if you don't want to use dynamic frameworks
#  use_modular_headers!
  use_frameworks!
  # Pods for YXBSwiftProject

pod 'XHLaunchAd', '~> 3.9.8' # 启动页 很完善
pod 'EAIntroView', '~> 2.12.0' # 引导页 很不错
pod 'CYLTabBarController', '~> 1.28.4'
#pod 'YTKNetwork', '~> 2.0.4' # 依赖AFNetworking3.0以上, 3.0中含有UIWebView,无法上架
pod 'YTKNetwork', '~> 3.0.5' # 依赖AFNetworking4.0以上
pod 'SDCycleScrollView', '~> 1.80' # 依赖SDWebImage 5.0以上
pod 'IGListKit', '~> 4.0.0'
pod 'QMUIKit', '~> 4.1.3'
pod 'Masonry', '~> 1.1.0'
pod 'MJRefresh','~> 3.1.12'
pod 'DZNEmptyDataSet', '~> 1.8.1'
#pod 'Toast', '~> 3.1.0' # 声网的本地框架中将 toast的源码拖进去了。
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


# 支付宝支付
pod 'AlipaySDK-iOS'
 
pod 'Charts', :modular_headers => true # 选择静态库 还是动态库


# 声网，本地支持库，，内含依赖：
def AgoraFoundation
  #Installing AFNetworking 4.0.1
  #Installing AgoraLog (0.0.1)
  #Installing AgoraReplay (0.0.1)
  #Installing AgoraReplayUI (0.0.1)
  #Installing AgoraRtcEngine_iOS (2.9.0.107)  # 互动视频
  #Installing AgoraRtm_iOS (1.4.1) # 云信令
  #Installing AgoraWhiteBoard (0.0.1)
  #Installing AliyunOSSiOS (2.10.8)
  #Installing CocoaLumberjack (3.6.1)
  #Installing EduSDK (0.0.1)
  #Installing Whiteboard (2.9.14)  #白板
  #Installing dsBridge (3.0.6)
  pod 'AgoraLog', :path => 'Modules/AgoraLog/AgoraLog.podspec'
  pod 'EduSDK', :path => 'Modules/EduSDK/EduSDK.podspec'
  pod 'AgoraWhiteBoard', :path => 'Modules/AgoraWhiteBoard/AgoraWhiteBoard.podspec'
  pod 'AgoraReplay', :path => 'Modules/AgoraReplay/AgoraReplay.podspec'
  pod 'AgoraReplayUI', :path => 'Modules/AgoraReplayUI/AgoraReplayUI.podspec'
end

# swift库
def swiftFoundation

  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'R.swift'
  #生物识别，指纹解锁、面部识别
  pod 'BiometricAuthentication'
  #加载框, Toast, TODO: 封装一层Toast调用
  pod 'Toast-Swift', '~> 5.0.1'
  #swift版Masonry
  pod 'SnapKit'
  
end

swiftFoundation()

AgoraFoundation()

end
