//
//  HonourRankWeekSegmentVC.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/10/27.
//  Copyright © 2023 ShengChang. All rights reserved.
//


import UIKit
import JXSegmentedView

@objc class HonourRankWeekSegmentVC: UIViewController {
    
    // 给api接口用的,外界传入
    var currentPage: HonourRankTypeTag!
    
    let segmentedView = JXSegmentedView()
    let segmentedDataSource = JXSegmentedTitleDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.setupUI()
        self.setupTools()
        self.setupData()
    }
    
    private func setupUI() {
        
        //  - 内容
        let listContainerView = JXSegmentedListContainerView(dataSource: self)
        self.view.addSubview(listContainerView)
        //关联listContainer
        segmentedView.listContainer = listContainerView
        
        //      - 初始化指示器indicator
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorWidth = 15
        indicator.indicatorHeight = 4
        indicator.indicatorColor = UIColor(hex: 0xFF4D73)!
        indicator.indicatorPosition = .bottom
        segmentedView.indicators = [indicator]
//        indicator.indicatorWidth = 15
//        indicator.indicatorHeight = 4
//        indicator.indicatorPosition = .bottom
//        indicator.gradientColors = [UIColor(hex: 0xFF4D73)!.cgColor, UIColor(hex: 0xFF879F)!.cgColor]
//        segmentedView.indicators = [indicator]
        
        // - 标题
        // 代理
        segmentedView.delegate = self
        self.view.addSubview(self.segmentedView)
        
        listContainerView.snp.makeConstraints { make in
            make.top.equalTo(segmentedView.snp.bottom).offset(1)
            make.left.right.bottom.equalToSuperview()
        }
        
        self.segmentedView.snp.makeConstraints { make in
            make.top.equalTo(10.fitScale())
            make.left.equalTo(70)
            make.right.equalTo(-70)
            make.height.equalTo(38)
        }
    }
    
    private func setupTools() {
        
    }
    
    private func setupData() {
        // 配置数据源相关配置属性
        segmentedDataSource.titles = HonourRankType.allCases.map{$0.rawValue}
        segmentedDataSource.titleSelectedFont = UIFont.pingFang(fontSize: 16, style: .semibold)
        segmentedDataSource.titleSelectedColor = UIColor(hex: 0xFFFFFF)!
        segmentedDataSource.titleNormalFont = UIFont.pingFang(fontSize: 14, style: .medium)
        segmentedDataSource.titleNormalColor = UIColor(hex: 0xFFFFFF, transparency: 0.8)!
        segmentedDataSource.isItemSpacingAverageEnabled = true
//        segmentedDataSource.itemSpacing = 0
//        segmentedDataSource.itemWidth = 103.fitScale()
        
        segmentedDataSource.isTitleColorGradientEnabled = true
        // 关联dataSource
        segmentedView.dataSource = self.segmentedDataSource
        segmentedView.defaultSelectedIndex = 0
        
//        segmentedView.
    }
    
    
    deinit {
        debugPrint(self.className + " deinit 🍺")
    }
}

// MARK: -JXSegmentedViewDelegate 标签
extension HonourRankWeekSegmentVC: JXSegmentedViewDelegate {
    
}

// MARK: -JXSegmentedListContainerViewDataSource 分页的控制器
extension HonourRankWeekSegmentVC: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        return segmentedDataSource.titles.count
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        if index == 0 {
            let vc = HonourRankVC()
            vc.currentPage = self.currentPage
            vc.currentChooseType = .day
            return vc
        } else if index == 1 {
            let vc = HonourRankVC()
            vc.currentPage = self.currentPage
            vc.currentChooseType = .weak
            return vc
        } else {
            let vc = HonourRankVC()
            vc.currentPage = self.currentPage
            vc.currentChooseType = .month
            return vc
        }
    }
}

// MARK: JXSegmentedListContainerViewListDelegate
extension HonourRankWeekSegmentVC : JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return self.view
    }
    
    func listDidAppear() {
        // 刷新头部数据
//        self.headerVc.loadRecommentRoomDate()
    }
}
