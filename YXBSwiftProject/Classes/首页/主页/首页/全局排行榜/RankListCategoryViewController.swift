//
//  RankListCategoryViewController.swift
//  voice
//
//  Created by Mac on 2023/4/3.
//

import UIKit
import JXSegmentedView

@objc class RankListCategoryViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    let segmentedView = JXSegmentedView()
    let segmentedDataSource = JXSegmentedTitleDataSource()
    
    // 右上角问号
    private lazy var questionBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        btn.setImage(UIImage(named: "rank_question"), for: .normal)
        btn.addTarget(self, action: #selector(clickQuestionAction), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
//        nav.navigationBar.isHidden = true
        
        self.view.gradient(colors: [.gradientColor_redEnd, .gradientColor_redStart], direction: .vertical)
        
        self.setupUI()
        self.setupTools()
        self.setupData()
    }
    
    private func setupUI() {
        let backgroundIamgeView = UIImageView()
        backgroundIamgeView.image = UIImage(named: "mine_rank_background")
        self.view.addSubview(backgroundIamgeView)
        backgroundIamgeView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(483 * ScreenConst.ScreenRatio)
        }
        
        //  - 内容
        let listContainerView = JXSegmentedListContainerView(dataSource: self)
        listContainerView.scrollView.clipsToBounds = false
        self.view.addSubview(listContainerView)
        //关联listContainer
        segmentedView.listContainer = listContainerView
        listContainerView.snp.makeConstraints { make in
            make.top.equalTo(ScreenConst.navStatusBarHeight)
            make.left.right.bottom.equalToSuperview()
        }
        
        let navBgView = CustomNavigationView()
        navBgView.titleButton.isHidden = true
        self.view.addSubview(navBgView)
        navBgView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(ScreenConst.navStatusBarHeight)
        }

        // - 标题
        segmentedView.delegate = self
        navBgView.mainView.addSubview(self.segmentedView)
//        self.segmentedView.backgroundColor = .clear
        self.segmentedView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(65)
            make.right.equalTo(-65)
            make.height.equalTo(35)
        }
        
        //      - 初始化指示器indicator
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorWidth = 10
        indicator.indicatorHeight = 3
        indicator.indicatorColor = .white
        indicator.indicatorPosition = .bottom
        segmentedView.indicators = [indicator]
         
        
        navBgView.mainView.addSubview(questionBtn)
        questionBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.width.height.equalTo(32)
        }
    }
    
    private func setupTools() {
        
    }
    
    private func setupData() {
        // 配置数据源相关配置属性
        segmentedDataSource.titles = HomeRankTypeTag.allCases.map{$0.rawValue}
        segmentedDataSource.titleSelectedFont = UIFont.pingFang(fontSize: 18, style: .medium)
        segmentedDataSource.titleSelectedColor = .white
        segmentedDataSource.titleNormalFont = UIFont.pingFang(fontSize: 16, style: .medium)
        segmentedDataSource.titleNormalColor = .init(white: 1, alpha: 0.8)
        segmentedDataSource.isItemSpacingAverageEnabled = true
//        segmentedDataSource.itemSpacing = 24
        
        segmentedDataSource.isTitleColorGradientEnabled = true
        // 关联dataSource
        segmentedView.dataSource = self.segmentedDataSource
        segmentedView.defaultSelectedIndex = 0
    }
    
    // MARK: 事件
    // 点击问号
    @objc func clickQuestionAction() {
        // 弹窗
        let string = self.segmentedDataSource.titles[self.segmentedView.selectedIndex]
        let type = HomeRankTypeTag(rawValue: string)
        MBProgressHUD.showCustomTipTitle(type?.tipTitle, titleColr: type?.tipTitleColor ?? .clear, imageNamed: type?.tipImage, content: type?.tipContent)
    }
    
    deinit {
        debugPrint(self.className + " deinit 🍺")
    }
}

// MARK: -JXSegmentedViewDelegate 标签
extension RankListCategoryViewController: JXSegmentedViewDelegate {
    
}

// MARK: -JXSegmentedListContainerViewDataSource 分页的控制器
extension RankListCategoryViewController: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        return segmentedDataSource.titles.count
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        if index == 0 {
            let vc = RankListViewController()
            vc.currentPage = .rich
            return vc
        } else if index == 1 {
            let vc = RankListViewController()
            vc.currentPage = .live
            return vc
        } else {
            let vc = RankListViewController()
            vc.currentPage = .party
            return vc
        }
    }
}

// MARK: 自定义导航栏
fileprivate class CustomNavigationView: UIView {

    fileprivate lazy var safeAearView: UIView = {
        let view = UIView()
        return view
    }()
    fileprivate lazy var mainView: UIView = {
        let view = UIView()
        return view
    }()
    // 返回按钮
    fileprivate lazy var backButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "rank_back"), for: .normal)
        btn.addTarget(self, action: #selector(backAction(_:)), for: .touchUpInside)
        return btn
    }()
    // 标题
    fileprivate lazy var titleButton: YXBButton = {
        let btn = YXBButton(postion: .left, interitemSpace: 5)
        btn.titleLabel?.font = UIFont.pingFang(fontSize: 18, style: .semibold)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(safeAearView)
        safeAearView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(ScreenConst.statusBarHeight)
        }
        
        self.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(ScreenConst.navBarHeight)
        }
        
        mainView.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(32)
        }
        
        mainView.addSubview(titleButton)
        titleButton.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }

    @objc func backAction(_ sender: UIButton) {
        self.parentViewController?.navigationController?.popViewController(animated: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
