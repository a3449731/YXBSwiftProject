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


@objc class MSSystemNoticeVC: UIViewController {
    //负责对象销毁
    var disposeBag = DisposeBag()
    let viewModel: MSSystemNoticeViewModel = MSSystemNoticeViewModel()
    
    lazy var tableview: UITableView = {
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
    
    func setupUI() {
        self.creatTableView()
        self.configLayout()
    }
    
    func setupTool() {
        
    }
    
    func setupData() {
        // 获取数据，MVVM的双向绑定
        viewModel.fetchData {}
    }
    
    func bindData() {
        // MARK: tableview数据源
        viewModel.modelArray
            .bind(to: tableview.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { index, model, cell in
                cell.textLabel?.text = model.content
            }
            .disposed(by: disposeBag)
        
        // MARK: tableview点击事件
        tableview.rx.modelSelected(MSSystemNoticeModel.self)
            .subscribe(onNext: { model in
                
            })
            .disposed(by: disposeBag)
    }
    
    func creatTableView() {
        view.addSubview(tableview)
    }
    
    func configLayout() {
        tableview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    deinit {
        debugPrint(self.className + " deinit 🍺")
    }
}
