//
//  MSDressSegmentVC.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/10/20.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import UIKit
import JXSegmentedView
import RxSwift
import RxCocoa

class MSDressSegmentVC: UIViewController {
    // 外界传入
    // 是否是我的背包,
    var isMyBeiBao: Bool = false
    
    let disposed = DisposeBag()
    var currentChooseModel: MSDressModel?
        
    // 标题模型
    private var titleModelArray: [MSDressType] = MSDressType.allCases
    private var titleArray: [String] = []
    
    let previewContentView = UIView()
    // 预览
    lazy var previewView: MSDressPreviewView = {
        let view = MSDressPreviewView()
        return view
    }()
    
    let segmentedView = JXSegmentedView()
    let segmentedDataSource = JXSegmentedTitleDataSource()
    
    let buyButton: UIButton = {
        let button = MyUIFactory.commonGradientButton(title: "立即购买", titleColor: .titleColor_white, titleFont: .titleFont_14, image: nil)
        button.cornerRadius = 18.fitScale()
        button.makeGradient([.gradientColor_redStart, .gradientColor_redEnd])
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.titleLabel?.text = "装扮中心"
//        self.naviImageView?.backgroundColor = .clear;
        self.view.backgroundColor = .backgroundColor_white
        self.setupUI()
        self.setupTools()
        self.setupData()
    }
    
    private func setupUI() {
        
        let backgroundIamgeView = UIImageView()
        backgroundIamgeView.image = UIImage(named: "wode_dress_background")
        backgroundIamgeView.contentMode = .scaleToFill
        self.view.insertSubview(backgroundIamgeView, at: 0)
        backgroundIamgeView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        let backgroundTopIamgeView = UIImageView()
        backgroundTopIamgeView.image = UIImage(named: "wode_dress_background_top")
        backgroundTopIamgeView.contentMode = .scaleToFill
//        self.view.addSubview(backgroundTopIamgeView)
        self.view.insertSubview(backgroundTopIamgeView, at: 1)
        backgroundTopIamgeView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(146.fitScale())
        }
        
        // - 标题
        segmentedView.delegate = self
        self.view.addSubview(self.segmentedView)
        self.segmentedView.snp.makeConstraints { make in
            make.top.equalTo(ScreenConst.navStatusBarHeight + 170.fitScale() + 15.fitScale())
            make.left.equalTo(0)
            make.right.equalTo(-0)
            make.height.equalTo(35)
        }
        
        //      - 初始化指示器indicator
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorWidth = 10
        indicator.indicatorHeight = 3
        indicator.indicatorColor = .indicatorColor_black
        indicator.indicatorPosition = .bottom
        segmentedView.indicators = [indicator]
        
        //  - 内容
        let listContainerView = JXSegmentedListContainerView(dataSource: self)
        self.view.addSubview(listContainerView)
        //关联listContainer
        segmentedView.listContainer = listContainerView
        listContainerView.snp.makeConstraints { make in
            make.top.equalTo(segmentedView.snp.bottom).offset(15)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-ScreenConst.bottomSpaceHeight - 50.fitScale())
        }
        
        self.view.addSubview(buyButton)
        buyButton.snp.makeConstraints { make in
            make.width.equalTo(122.fitScale())
            make.right.equalTo(-15.fitScale())
            make.height.equalTo(36.fitScale())
            make.bottom.equalToSuperview().offset(-ScreenConst.bottomSpaceHeight)
        }
        
        
        // 这个放到下面是为了省去播放特效的时候，特效可以展示在上层。
        self.view.addSubview(previewContentView)
        previewContentView.snp.makeConstraints { make in
            make.top.equalTo(ScreenConst.navStatusBarHeight + 10.fitScale())
            make.left.equalTo(15.fitScale())
            make.right.equalTo(-15.fitScale())
            make.height.equalTo(160.fitScale())
        }
                        
        let preViewImageView = UIImageView()
        preViewImageView.image = UIImage(named: "wode_dress_preview")
        previewContentView.addSubview(preViewImageView)
        preViewImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.addPreView()
    }
    
    private func setupTools() {
        buyButton.rx.tap
            .subscribe(onNext: { [weak self] event in
                debugPrint("点击了购买")
                guard let self = self else { return }
                self.configBuyAction()
            })
            .disposed(by: disposed)
    }
    
    private func setupData() {
        // 配置数据源相关配置属性
        segmentedDataSource.titles = []
        segmentedDataSource.titleSelectedFont = .titleFont_14
        segmentedDataSource.titleSelectedColor = .titleColor
        segmentedDataSource.titleNormalFont = .titleFont_14
        segmentedDataSource.titleNormalColor = .subTitleColor
        segmentedDataSource.isItemSpacingAverageEnabled = true
//        segmentedDataSource.itemSpacing = 24
        
        segmentedDataSource.isTitleColorGradientEnabled = true
        // 关联dataSource
        segmentedView.dataSource = self.segmentedDataSource
        segmentedView.defaultSelectedIndex = 0
        
        
        // 请求标题数据,刷新数据
        self.requestDressCategories()
    }
    
    // 请求标题数据
    private func requestDressCategories() {
        // 这个标题是本地写的，没有接口。
        self.titleArray = self.titleModelArray.map { type in
            type.title
        }
        self.segmentedDataSource.titles = self.titleArray
        self.segmentedView.reloadData()
    }
    
    
    // MARK: 点击购买按钮
    private func configBuyAction() {
        if self.currentChooseModel == nil {
//            self.showTipMessage("请先选择装扮")
            return
        }
        
        if let model = self.currentChooseModel,
           model.isZs == "1",
           isMyBeiBao == false {
//            self.showTipMessage("此装扮为\(model.vipLevel ?? "")贵族专属，暂不能购买")
            return
        }
        
        let vc = MSDressBuyVC()
        vc.model = self.currentChooseModel ?? MSDressModel()
        vc.modalPresentationStyle = .overFullScreen;
        self.navigationController?.present(vc, animated: false, completion: {
//            vc.view.superview?.backgroundColor = .clear
        })
    }
    
    deinit {
        debugPrint(self.className + " deinit 🍺")
    }

}

// MARK: -JXSegmentedViewDelegate 标签
extension MSDressSegmentVC: JXSegmentedViewDelegate {
    // 在滚动到下一页时要清空选中
    func segmentedView(_ segmentedView: JXSegmentedView, didScrollSelectedItemAt index: Int) {
        if let content = self.segmentedView.listContainer as? JXSegmentedListContainerView {
            content.validListDict.forEach { i, _ in
                if let vc = content.validListDict[i] as? MSDressCenterVC {
                    let array = Array(repeating: false, count: vc.viewModel.seletArray.value.count)
                    vc.viewModel.seletArray.accept(array)
                    vc.collectionView.reloadData()
                    self.currentChooseModel = nil
                }
            }
        }
        
        // 对预览进行重建,先删除再添加。 懒得改以前的逻辑了。
        self.removePreView()
        self.addPreView()
        
    }
}

// MARK: -JXSegmentedListContainerViewDataSource 分页的控制器
extension MSDressSegmentVC: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        return segmentedDataSource.titles.count
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        let titleModel = self.titleModelArray[index]
        let vc = MSDressCenterVC()
        vc.currentType = titleModel
        // 添加监听
        self.receiveTap(vc: vc)
        
        return vc
    }
    
    // MARK: 收到了点击了里面cell的回调
    private func receiveTap(vc: MSDressCenterVC) {
        vc.collectionView.rx.modelSelected(MSDressModel.self)
            .debug("12323112")
            .subscribe(onNext: { [weak self] model in
                debugPrint("首页收到的点击事件 ......")
                guard let self = self else { return }
                self.currentChooseModel = model
                self.showAnimation()
            })
            .disposed(by: disposed)
    }
}

// MARK: 对预览的操作
extension MSDressSegmentVC {
    private func addPreView() {
        let index = self.segmentedView.selectedIndex
        self.previewView.addTo(superView: previewContentView, type: self.titleModelArray[index])
    }
    
    private func removePreView() {
        self.previewView.removeForm(superView: previewContentView)
    }
    
    private func showHeader() {
        let index = self.segmentedView.selectedIndex
        self.previewView.showHeader(type: self.titleModelArray[index])
    }
    
    private func showAnimation() {
        let index = self.segmentedView.selectedIndex
        self.previewView.showAnimation(selectModel: self.currentChooseModel, type: self.titleModelArray[index])
    }
    
    private func stopAnimation() {
        self.previewView.stopAnimation()
    }
}
