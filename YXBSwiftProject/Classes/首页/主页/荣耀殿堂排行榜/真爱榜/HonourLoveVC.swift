//
//  HonourLoveVC.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/10/27.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import UIKit
import JXSegmentedView
import MJRefresh

class HonourLoveVC: UIViewController {
    let viewModel = HonourLoveViewModel()
        
    // 给api接口用的,外界传入
    var currentPage: HonourRankTypeTag!
    
    // 当前选的哪个榜单，默认选日榜
    var currentChooseType: HonourRankType = .day {
        didSet {
            // 刷新数据
//            self.requestRankListData()
        }
    }
    
    // 排行榜数据
    private var modelArray: [HonourLoveModel] = [] {
        didSet {
            // 刷新表头
            self.tableHeader.setupWithModels(model: self.modelArray.first ?? HonourLoveModel())
            // 刷新cell
            self.tableview.reloadData()
        }
    }
    
    private lazy var tableHeader: HonourLoveHeaderView = {
        let header = HonourLoveHeaderView(frame: CGRectZero)
        return header
    }()
        
    private lazy var tableview: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(HonourLoveCell.self, forCellReuseIdentifier: "HonourLoveCell")
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
//        switch self.currentPage {
//        case .rich: backgroundIamgeView.image = UIImage(named: "rank_background_1")
//        case .live: backgroundIamgeView.image = UIImage(named: "rank_background_2")
//        case .party: backgroundIamgeView.image = UIImage(named: "rank_background_3")
//        case .none:
//            break
//        }
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
   
    }
 
    
    private func setupData() {
        self.refreshData()
    }
    
    private func creatSegmentButton() {
        let backgroundView = UIView()
        backgroundView.cornerRadius = 14
//        switch self.currentPage {
//        case .rich: backgroundView.backgroundColor = UIColor(hex: 0xFFF3E4)
//        case .live: backgroundView.backgroundColor = UIColor(hex: 0xF2F7FF)
//        case .party: backgroundView.backgroundColor = UIColor(hex: 0xFEF2F8)
//        case .none:
//            break
//        }
        self.view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.left.equalTo(95)
            make.right.equalTo(-95)
            make.height.equalTo(28)
        }
    }
    
    private func creatTableView() {
        // 头试图
        self.tableHeader.frame = CGRectMake(0, 0, ScreenConst.width, 169.fitScale() + 90)
        tableview.tableHeaderView = self.tableHeader
        self.tableHeader.delegate = self
        tableview.contentInset = UIEdgeInsets(top: 10 * ScreenConst.ScreenRatio, left: 0, bottom: 30, right: 0)
        self.view.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
        }
    }
    
    // MARK: 网络请求
    
    @objc private func refreshData() {
        self.viewModel.fetchData { [weak self] in
            self?.modelArray = self?.viewModel.modelArray ?? []
            debugPrint("1212")
        }
    }
    
    deinit {
        debugPrint(self.className + " deinit 🍺")
    }
}

// MARK: -UITableViewDelegate, UITableViewDataSource
extension HonourLoveVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.modelArray.count > 1 {
            return self.modelArray.count - 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HonourLoveCell", for: indexPath) as! HonourLoveCell
//        if indexPath.row == self.modelArray.count - 3 - 1 {
////            cell.bgView.cornerRadius(corners: [.bottomLeft, .bottomRight], radius: 20)
////            cell.bgView.roundCorners([.bottomLeft, .bottomRight], radius: 20)
//        } else {
//            cell.bgView.roundCorners([.topLeft, .topRight], radius: 0)
//        }
        if indexPath.row % 2 == 0 {
            cell.bgView.backgroundColor = UIColor(hex: 0xFDF0FC)
        } else {
            cell.bgView.backgroundColor = UIColor(hex: 0xFAE3F8)
        }
        let model = self.modelArray[indexPath.row + 1]
        cell.setupWithModel(model: model, index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = self.modelArray[indexPath.row + 1]
//        self.jumpToVC(model: model)
    }
    
    private func jumpToVC(model: HonourRankModel) {
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

extension HonourLoveVC: RankListHeaderDelegate {
    func rankListHeaderDidSelect(index: Int) {
        if index == 0 && self.modelArray.first != nil {
            let firstModel = self.modelArray[0]
//            self.jumpToVC(model: firstModel)
            
        }
        if index == 1 && self.modelArray.count > 1 {
            let secondModel = self.modelArray[1]
//            self.jumpToVC(model: secondModel)
        }
        
        if index == 2 && self.modelArray.count > 2 {
            let thirdModel = self.modelArray[2]
//            self.jumpToVC(model: thirdModel)
        }
    }
}

// MARK: JXSegmentedListContainerViewListDelegate
extension HonourLoveVC : JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return self.view
    }
    
    func listDidAppear() {
        // 刷新头部数据
//        self.headerVc.loadRecommentRoomDate()
    }
}
