//
//  RankListViewController.swift
//  voice
//
//  Created by Mac on 2023/4/2.
//

import UIKit
import JXSegmentedView

class RankListViewController: UIViewController {
    
    let viewModel = RoomListViewModel()
    
    // 给api接口用的,外界传入
    var currentPage: HomeRankTypeTag!
    
    private var chooseArray: [RankType] = [.day, .weak, .month]
    // 当前选的哪个榜单，默认选日榜
    private var currentChooseType: RankType = .day {
        didSet {
            let buttons = self.hStack.arrangedSubviews as! [UIButton]
            for btn in buttons {
                if currentChooseType == self.chooseArray[btn.tag] {
                    btn.isSelected = true
                    switch self.currentPage {
                    case .rich: btn.backgroundColor = UIColor(hex: 0xFDAB6F)
                    case .live: btn.backgroundColor = UIColor(hex: 0xA0B6FF)
                    case .party: btn.backgroundColor = UIColor(hex: 0xFD7FD8)
                    case .none:
                        break
                    }
                    btn.titleLabel?.font = UIFont.pingFang(fontSize: 14, style: .semibold)
                } else {
                    btn.isSelected = false
                    btn.backgroundColor = .clear
                    btn.titleLabel?.font = UIFont.pingFang(fontSize: 14, style: .medium)
                }
            }
            
            // 刷新数据
            self.requestRankListData()
        }
    }
    
    // 排行榜数据
    private var modelArray: [HomeRankModel] = [] {
        didSet {
            // 刷新表头
            self.tableHeader.setupWithModels(models: modelArray)
            // 刷新cell
            self.tableview.reloadData()
        }
    }
    
    
    // 容器：容纳日榜，周榜，月榜按钮的容器
    private lazy var hStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 1
        return stackView
    }()
    
    private lazy var tableHeader: RankListHeader = {
        let header = RankListHeader(frame: CGRectZero, page: self.currentPage)
        header.clipsToBounds = true
        return header
    }()
        
    private lazy var tableview: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(RankListCell.self, forCellReuseIdentifier: "RankListCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        nav.navigationBar.isHidden = true
        self.view.backgroundColor = .clear
        self.view.clipsToBounds = false
        setupUI()
        setupTools()
        setupData()
    }
    
    private func setupUI() {
        let backgroundIamgeView = UIImageView()
        switch self.currentPage {
        case .rich: backgroundIamgeView.image = UIImage(named: "rank_background_1")
        case .live: backgroundIamgeView.image = UIImage(named: "rank_background_2")
        case .party: backgroundIamgeView.image = UIImage(named: "rank_background_3")
        case .none:
            break
        }
        self.view.addSubview(backgroundIamgeView)
        backgroundIamgeView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-ScreenConst.navStatusBarHeight)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
//            make.height.equalTo(483 * ScreenConst.ScreenRatio)
        }
        
        self.creatTableView()
        self.creatSegmentButton()
    }
    
    private func setupTools() {
        self.tableview.mj_header = YXBGifRefreshHeader(refreshingTarget: self, refreshingAction: #selector(refreshData))
    }
    
    @objc private func refreshData() {
        self.requestRankListData()
    }
    
    private func setupData() {
        self.currentChooseType = .day
        self.requestRankListData()
    }
    
    private func creatSegmentButton() {
        let backgroundView = UIView()
        backgroundView.cornerRadius = 14
        switch self.currentPage {
        case .rich: backgroundView.backgroundColor = UIColor(hex: 0xFFF3E4)
        case .live: backgroundView.backgroundColor = UIColor(hex: 0xF2F7FF)
        case .party: backgroundView.backgroundColor = UIColor(hex: 0xFEF2F8)
        case .none:
            break
        }
        self.view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.left.equalTo(95)
            make.right.equalTo(-95)
            make.height.equalTo(28)
        }
        
        for (index, item) in chooseArray.enumerated() {
            let button = UIButton(type: .custom)
//            button.borderColor = .white
            button.cornerRadius = 13
//            button.borderWidth = 1
//            button.border(color: .white, radius: 15.5, width: 1)
            button.titleLabel?.font = UIFont.pingFang(fontSize: 14, style: .medium)
            
            switch self.currentPage {
            case .rich:
                button.setTitleColor(UIColor(hex: 0xC96B09), for: .normal)
            case .live:
                button.setTitleColor(UIColor(hex: 0xA0B6FF), for: .normal)
            case .party:
                button.setTitleColor(UIColor(hex: 0xFD7FD8), for: .normal)
            case .none:
                break
            }
            button.setTitleColor(UIColor(hex: 0xFFFFFF), for: .selected)
            button.setTitle(item.rawValue, for: .normal)
            button.tag = index // 加个标签区分点击事件
            self.hStack.addArrangedSubview(button)
            button.addTarget(self, action: #selector(chooseTypeAction(_:)), for: .touchUpInside)
        }
        
        backgroundView.addSubview(self.hStack)
        self.hStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(1)
        }
    }
    
    private func creatTableView() {
        // 头试图
        self.tableHeader.frame = CGRectMake(0, 0, ScreenConst.width, 285)
        tableview.tableHeaderView = self.tableHeader
        self.tableHeader.delegate = self
        tableview.contentInset = UIEdgeInsets(top: 10 * ScreenConst.ScreenRatio, left: 0, bottom: 0, right: 0)
        self.view.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
    }
    
    // MARK: 网络请求
    private func requestRankListData() {
                                
        self.viewModel.fetchData(type: self.currentPage, timeType: self.currentChooseType.timeType) {
            self.modelArray = self.viewModel.modelArray
            self.tableview.mj_header?.endRefreshing()
        }
        
//        NetworkManager.instance.funcForGetPageRankList(type: PageRankModel(), typeTag: self.currentPage!.rawValue, wayTag: wayTag) { [weak self] model in
//            self?.modelArray = model.rankingVos ?? []
//        }
    }

    // MARK: 事件
    // 选择了某个排行榜事件
    @objc func chooseTypeAction(_ sender: UIButton) {
        if self.currentChooseType != self.chooseArray[sender.tag] {
            self.currentChooseType = self.chooseArray[sender.tag]
        }
    }
    
    deinit {
        debugPrint(self.className + " deinit 🍺")
    }
}

// MARK: -UITableViewDelegate, UITableViewDataSource
extension RankListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.modelArray.count > 3 {
            return self.modelArray.count - 3
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RankListCell", for: indexPath) as! RankListCell
        if indexPath.row == 0 {
            cell.roundCorners([.topLeft, .topRight], radius: 20)
        } else {
            cell.roundCorners([.topLeft, .topRight], radius: 0)
        }
        cell.backgroundColor = UIColor(rgb: 0xFFFFFF, alpha: 0.7)
        let model = self.modelArray[indexPath.row + 3]
        cell.setupWithModel(model: model, index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = self.modelArray[indexPath.row + 3]
        self.jumpToVC(model: model)
    }
    
    private func jumpToVC(model: HomeRankModel) {
        // 去个人资料
//        if let userId = model.roomauthorid  {
//            let vc = MSUserDetailMainVC()
//            vc.uid = userId
//            vc.hidesBottomBarWhenPushed = true
//            self.navigationController?.pushViewController(vc, animated: true)
//        } else if let houseNo = model.houseNo {
//            // 去直播间
//            self.setupMakeJoinRoom(["id": houseNo])
//        }
    }
}

extension RankListViewController: RankListHeaderDelegate {
    func rankListHeaderDidSelect(index: Int) {
        if index == 0 && self.modelArray.first != nil {
            let firstModel = self.modelArray[0]
            self.jumpToVC(model: firstModel)
            
        }
        if index == 1 && self.modelArray.count > 1 {
            let secondModel = self.modelArray[1]
            self.jumpToVC(model: secondModel)
        }
        
        if index == 2 && self.modelArray.count > 2 {
            let thirdModel = self.modelArray[2]
            self.jumpToVC(model: thirdModel)
        }
    }
}

// MARK: JXSegmentedListContainerViewListDelegate
extension RankListViewController : JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return self.view
    }
    
    func listDidAppear() {
        // 刷新头部数据
//        self.headerVc.loadRecommentRoomDate()
    }
}
