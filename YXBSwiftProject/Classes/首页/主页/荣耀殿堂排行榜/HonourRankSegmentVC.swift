//
//  HonourRankSegmentVC.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/10/27.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import UIKit
import JXSegmentedView

@objc class HonourRankSegmentVC: UIViewController {
    
    let segmentedView = JXSegmentedView()
    let segmentedDataSource = JXSegmentedTitleDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.setupUI()
        self.setupTools()
        self.setupData()
    }
    
    private func setupUI() {
        let backgroundIamgeView = UIImageView()
        backgroundIamgeView.image = UIImage(named: "honour_background")
        self.view.addSubview(backgroundIamgeView)
        
        let topTipImageView = MyUIFactory.commonImageView(name: "honour_top_tip", placeholderImage: nil)
        self.view.addSubview(topTipImageView)
        
        let backButton = MyUIFactory.commonButton(title: nil, titleColor: nil, titleFont: nil, image: UIImage(named: "honour_back"))
        view.addSubview(backButton)
        backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        
        //  - 内容
        let listContainerView = JXSegmentedListContainerView(dataSource: self)
        self.view.addSubview(listContainerView)
        //关联listContainer
        segmentedView.listContainer = listContainerView
        
        //      - 初始化指示器indicator
        let indicator = JXSegmentedIndicatorImageView()
        indicator.indicatorWidth = 103
        indicator.indicatorHeight = 34
        indicator.image = UIImage.init(named: "honour_indicator")
        indicator.indicatorPosition = .center
        segmentedView.indicators = [indicator]
        
        // - 标题
        // 弄个渐变背景色
        segmentedView.frame = CGRectMake(28, 0, ScreenConst.width - 28 - 28, 38)
        segmentedView.gradient(colors: [UIColor(hex: 0xCE7EE5)!, UIColor(hex: 0xF0E5FF)!], direction: .vertical)
        segmentedView.cornerRadius = 19
        // 代理
        segmentedView.delegate = self
        self.view.addSubview(self.segmentedView)
                
        
        backgroundIamgeView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(ScreenConst.width * 2.36)
        }
        
        topTipImageView.snp.makeConstraints { make in
            make.top.equalTo(36.fitScale())
            make.centerX.equalToSuperview()
            make.width.equalTo(283.fitScale())
            make.height.equalTo(109.fitScale())
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(50.fitScale())
            make.left.equalTo(20.fitScale())
            make.width.height.equalTo(26.fitScale());
        }
        
        listContainerView.snp.makeConstraints { make in
            make.top.equalTo(self.segmentedView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        self.segmentedView.snp.makeConstraints { make in
            make.top.equalTo(159.fitScale())
            make.left.equalTo(28)
            make.right.equalTo(-28)
            make.height.equalTo(38)
        }
    }
    
    private func setupTools() {
        
    }
    
    private func setupData() {
        // 配置数据源相关配置属性
        segmentedDataSource.titles = HonourRankTypeTag.allCases.map{$0.rawValue}
        segmentedDataSource.titleSelectedFont = UIFont.pingFang(fontSize: 16, style: .semibold)
        segmentedDataSource.titleSelectedColor = UIColor(hex: 0x8365E5)!
        segmentedDataSource.titleNormalFont = UIFont.pingFang(fontSize: 16, style: .medium)
        segmentedDataSource.titleNormalColor = .white
        segmentedDataSource.isItemSpacingAverageEnabled = true
        segmentedDataSource.itemSpacing = 0
        segmentedDataSource.itemWidth = 103.fitScale()
        
        segmentedDataSource.isTitleColorGradientEnabled = true
        // 关联dataSource
        segmentedView.dataSource = self.segmentedDataSource
        segmentedView.defaultSelectedIndex = 0
        
//        segmentedView.
    }
    
    // MARK: 事件
    // 点击问号
    @objc func clickQuestionAction() {
        // 弹窗
//        let string = self.segmentedDataSource.titles[self.segmentedView.selectedIndex]
//        let type = HomeRankTypeTag(rawValue: string)
//        MBProgressHUD.showCustomTipTitle(type?.tipTitle, titleColr: type?.tipTitleColor ?? .clear, imageNamed: type?.tipImage, content: type?.tipContent)
    }
    
    @objc private func backButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    deinit {
        debugPrint(self.className + " deinit 🍺")
    }
}

// MARK: -JXSegmentedViewDelegate 标签
extension HonourRankSegmentVC: JXSegmentedViewDelegate {
    
}

// MARK: -JXSegmentedListContainerViewDataSource 分页的控制器
extension HonourRankSegmentVC: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        return segmentedDataSource.titles.count
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        if index == 0 {
            let vc = HonourLoveVC()
            vc.currentPage = .love
            return vc
        } else if index == 1 {
            let vc = HonourRankWeekSegmentVC()
            vc.currentPage = .contribute
            return vc
        } else {
            let vc = HonourRankWeekSegmentVC()
            vc.currentPage = .charm
            return vc
        }
    }
}
