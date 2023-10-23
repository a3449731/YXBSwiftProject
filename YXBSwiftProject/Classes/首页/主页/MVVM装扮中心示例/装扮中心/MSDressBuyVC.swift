//
//  MSDressBuyVC.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/10/20.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MSDressBuyVC: UIViewController {
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.frame = CGRect(x: 0, y: 0, width: ScreenConst.width, height: ScreenConst.height)
    }
    
    // 外界传入
    var model: MSDressModel!
    let disposed = DisposeBag()
    let viewModel: MSDressBuyViewModel = MSDressBuyViewModel()
    
    lazy var collectionView: UICollectionView = {
        let layout  = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 14.fitScale()
        layout.minimumInteritemSpacing = 14.fitScale()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15.fitScale(), bottom: 0, right: 15.fitScale())
        layout.itemSize = CGSize(width: 105.fitScale(), height: 86.fitScale())
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.register(MSDressBuyCell.self, forCellWithReuseIdentifier: "MSDressBuyCell")
        return collectionView
    }()
    
    let moneyButton: YXBButton = {
        let button = MyUIFactory.commonImageTextButton(title: "", titleColor: .titleColor, titleFont: .titleFont_14, image: UIImage(named: "CUYuYinFang_shangcheng_图层 27"), space: 2)
        return button
    }()
    
    let buyButton: UIButton = {
        let button = MyUIFactory.commonGradientButton(title: "立即购买", titleColor: .titleColor_white, titleFont: .titleFont_14, image: nil)
        button.cornerRadius = 18.fitScale()
        button.makeGradient([.gradientColor_redStart, .gradientColor_redEnd])
        return button
    }()
    
    let closeButton: UIButton = {
        let button = MyUIFactory.commonButton(title: "关闭", titleColor: .titleColor, titleFont: .titleFont_16, image: nil)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(rgb: 0x000000, alpha: 0.3)
        setupUI()
        setupTool()
        setupData()
    }
    
    private func setupUI() {
        let bgView = UIView()
        bgView.backgroundColor = .backgroundColor_white
        bgView.cornerRadius(corners: [.topLeft, .topRight], radius: 20)
        view.addSubview(bgView)
        let titleLabel = MyUIFactory.commonLabel(text: "购买特效", textColor: .titleColor, font: .titleFont_16.bold)
        bgView.addSubview(titleLabel)
        bgView.addSubview(collectionView)
        bgView.addSubview(moneyButton)
        let chargeButton = MyUIFactory.commonImageTextButton(title: "充值", titleColor: .titleColor_pink, titleFont: .titleFont_14, image: UIImage(named: "wode_dress_accrow"), postion: .right, space: 5)
        bgView.addSubview(chargeButton)
        chargeButton.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.chargeAction()
        })
        bgView.addSubview(buyButton)
        bgView.addSubview(closeButton)
        
        bgView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(300.fitScale())
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-100)
        }
        
        moneyButton.snp.makeConstraints { make in
            make.left.equalTo(20.fitScale())
            make.bottom.equalTo(-44.fitScale())
            make.height.equalTo(20)
        }
        
        chargeButton.snp.makeConstraints { make in
            make.left.equalTo(moneyButton.snp.right).offset(15.fitScale())
            make.bottom.equalTo(-44.fitScale())
            make.height.equalTo(20)
        }
        
        buyButton.snp.makeConstraints { make in
            make.width.equalTo(122.fitScale())
            make.right.equalTo(-15.fitScale())
            make.height.equalTo(36.fitScale())
            make.bottom.equalTo(-32.fitScale())
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(20)
        }
        
    }
        
    private func setupTool() {
        configColletionView()
        
        closeButton.rx.tap.subscribe(onNext: {
            self.dismiss(animated: true)
        }).disposed(by: disposed)
        
        buyButton.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.buyAction()
        }).disposed(by: disposed)
    }
    
    private func setupData() {
        viewModel.fetchData(model: self.model) {
            
        }
    }
    
    private func configColletionView() {
        // MARK: collectionView数据源
        viewModel.modelArray
            .debug("购买特效")
            .bind(to: collectionView.rx.items(cellIdentifier: "MSDressBuyCell", cellType: MSDressBuyCell.self)) { index, model, cell in
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
    
    // MARK: 点击购买按钮
    private func buyAction() {
        if let zbId = self.model.id,
           let index = self.viewModel.seletArray.value.firstIndex(of: true),
           let subId = self.viewModel.modelArray.value[index].id  {
            viewModel.requestBuyDress(zbId: zbId, subId: subId) { [weak self] in
                self?.dismiss(animated: true)
            }
        } else {
            
        }
    }
    
    // MARK: 点击充值
    private func chargeAction() {
        self.dismiss(animated: false) {
//            let vc = MSChongZhiVC()
//            getCuttentVisibleViewController().navigationController?.pushViewController(vc)
        }
    }
    
    deinit {
        debugPrint(self.className + " deinit 🍺")
    }
}

extension MSDressBuyVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
}




