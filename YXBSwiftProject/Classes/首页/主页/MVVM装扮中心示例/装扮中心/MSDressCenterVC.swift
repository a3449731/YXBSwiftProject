//
//  MSDressCenterVC.swift
//  CUYuYinFang
//
//  Created by 蓝鳍互娱 on 2023/10/19.
//  Copyright © 2023 lixinkeji. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import JXSegmentedView

@objc class MSDressCenterVC: UIViewController {
    
    // 外界传入
    // 类型，用于接口请求
    var currentType: MSDressType!
    
    lazy var collectionView: UICollectionView = {
        let layout  = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12.fitScale()
        layout.minimumInteritemSpacing = 9.fitScale()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15.fitScale(), bottom: 0, right: 15.fitScale())
        layout.itemSize = CGSize(width: 108.fitScale(), height: 129.fitScale())
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.register(MSDressCell.self, forCellWithReuseIdentifier: "MSDressCell")
        return collectionView
    }()
    
    let disposed = DisposeBag()
    let viewModel: MSDressViewModel = MSDressViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupTool()
        self.setupData()
    }
    
    private func setupUI() {
        self.creatcollectionView()
    }
    
    private func setupTool() {
        
        
    }
    
    private func setupData() {
        viewModel.fetchData(type: currentType) {
            
        }
    }
    
    // MARK: collectionView
    private func creatcollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // MARK: collectionView数据源
        viewModel.modelArray
            .bind(to: collectionView.rx.items(cellIdentifier: "MSDressCell", cellType: MSDressCell.self)) { [weak self] index, model, cell in
                guard let self = self else { return }
                cell.setup(model: model)
                cell.configChoose(isSelected: self.viewModel.seletArray.value[index])
            }
            .disposed(by: disposed)
        
        // MARK: collectionView点击事件
        collectionView.rx.itemSelected
            .debug()
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else {return}
                /*
                // 取反, 可多选
                var seletArray = self.viewModel.seletArray.value
                seletArray[indexPath.row] = !seletArray[indexPath.row]
                */
                //  取反，单选。
                let seletArray = self.viewModel.seletArray.value.enumerated().map{ index, _  in
                    return index == indexPath.row
                }
                self.viewModel.seletArray.accept(seletArray)
                self.collectionView.reloadData()
            })
            .disposed(by: disposed)
    }
    
    deinit {
        debugPrint(self.className + " deinit 🍺")
    }
}

extension MSDressCenterVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
}

// MARK: JXSegmentedListContainerViewListDelegate
extension MSDressCenterVC: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return self.view
    }
}
