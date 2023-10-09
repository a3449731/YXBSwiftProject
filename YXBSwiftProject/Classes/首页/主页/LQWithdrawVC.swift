//
//  LQWithdrawVC.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/9/27.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import UIKit
import RxSwift

@objc class LQWithdrawVC: UIViewController {
    let disposeBag = DisposeBag()
    
    lazy var viewModel: LQWithdrawViewModel = LQWithdrawViewModel()
    
    lazy var lqView: LQLabelTextFieldView = {
        let lqView = LQLabelTextFieldView()
        lqView.borderWidth = 1
        return lqView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupTool()
        self.setupData()
        self.bindData()
        
    }
    
    func setupUI() {
        view.backgroundColor = .gray
        view.addSubview(lqView)
        
        lqView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalTo(0)
            make.height.equalTo(280)
        }
    }
    
    func setupTool() {
        
    }
        
    func setupData() {
        viewModel.fetchData { [weak self] in
            guard let self = self else {return}
            print("viewModel获取到数据", self.viewModel, self.viewModel.model)
        }
    }
    
    // 数据绑定
    func bindData() {
        viewModel.hasZiliao
            .asDriver()
            .map{ ($0 == 0) }
            .drive(lqView.rx.isHidden)
            .disposed(by: disposeBag)
        
//        viewModel.hasZiliao
//            .subscribe { [weak self] show in
//                if show == 1 {
//                    self?.lqView.isHidden = false
//                }
//                if show == 0 {
//                    self?.lqView.isHidden = true
//                }
//            }
//            .disposed(by: disposeBag)
    }
}
