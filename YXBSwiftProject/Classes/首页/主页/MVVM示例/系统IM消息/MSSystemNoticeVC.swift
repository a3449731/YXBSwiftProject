//
//  MSSystemNoticeVC.swift
//  CUYuYinFang
//
//  Created by 蓝鳍互娱 on 2023/10/11.
//  Copyright © 2023 lixinkeji. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import MJRefresh


@objc class MSSystemNoticeVC: UIViewController {
    //负责对象销毁
    private var disposeBag = DisposeBag()
    private let viewModel: MSSystemNoticeViewModel = MSSystemNoticeViewModel()
    
    lazy private var tableview: UITableView = {
        let tableview = UITableView(frame: .zero, style: .plain)
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupTool()
        self.setupData()
        self.bindData()
    }
    
    private func setupUI() {
        self.creatTableView()
    }
    
    private func setupTool() {
        self.creatMJRefresh()
        
    }
    
    private func setupData() {
        // 获取数据，MVVM的双向绑定
        self.refreshData()
    }
    
    private func bindData() {
        
    }
    
    // MARK: - UITableView
    private func creatTableView() {
        view.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.bindTableViewData()
        self.bindTableViewSelect()
    }
    
    // MARK: tableview数据源
    private func bindTableViewData() {
        viewModel.modelArray
            .bind(to: tableview.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { index, model, cell in
                cell.textLabel?.text = model.content
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: tableview点击事件
    private func bindTableViewSelect() {
        tableview.rx.modelSelected(MSSystemNoticeModel.self)
            .subscribe(onNext: { model in
                
            })
            .disposed(by: disposeBag)
    }

    // MARK: - MJRefresh
    private func creatMJRefresh() {
        tableview.mj_header = YXBGifRefreshHeader(refreshingTarget: self, refreshingAction: #selector(refreshData))
        tableview.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(loadMoreData))
        // 双向绑定
        bindHasMoreData()
    }
    
    @objc private func refreshData() {
        viewModel.fetchData { [weak self] in
            self?.tableview.mj_header?.endRefreshing()
            self?.tableview.mj_footer?.endRefreshing()
        }
    }
    
    @objc private func loadMoreData() {
        viewModel.fetchNextPageData { [weak self] in
            self?.tableview.mj_header?.endRefreshing()
            self?.tableview.mj_footer?.endRefreshing()
        }
    }
    
    // 控制是否有下一页
    private func bindHasMoreData() {
        viewModel.hasMoreData
            .skip(1)
            .debug()
            .subscribe(onNext: {[weak self] hasMore in
                if hasMore {
                    self?.tableview.mj_footer.resetNoMoreData()
                } else {
                    self?.tableview.mj_footer.endRefreshingWithNoMoreData()
                }
            })
            .disposed(by: disposeBag)
    }
    
    
    deinit {
        debugPrint(self.className + " deinit 🍺")
    }
}
