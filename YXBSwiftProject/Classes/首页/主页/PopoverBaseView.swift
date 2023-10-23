//
//  PopoverBaseView.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/10/20.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import UIKit

protocol LiveRoomMainViewControllerPopoverDelegate : AnyObject {
    
}

class PopoverBaskMaskView : UIView {
    var contentView : PopoverBaseView!
    var tapGesStyle : PopoverManager.PopoverBackGroundTapGestureRecognizer = .defaultClose
}

class PopoverBaseView : UIView {
    
    public func inserBlurView() {
        //首先创建一个模糊效果
        let  blurEffect =  UIBlurEffect (style: .dark )
        //接着创建一个承载模糊效果的视图
        let  blurView = UIVisualEffectView (effect: blurEffect)
        //设置模糊视图的大小（全屏）
        blurView.frame = self.bounds
        
        //创建并添加vibrancy视图
        let vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        vibrancyView.frame = self.bounds
        blurView.contentView.addSubview(vibrancyView)
        
        self.insertSubview(blurView, at: 0)
    }

    weak var popoverDelegate : LiveRoomMainViewControllerPopoverDelegate?
    
    var showKeyboardTop : Bool = false
    
    var lastView : PopoverBaseView?
    var nextView : PopoverBaseView?

    // 展示多个的pop
    var isMultiple : Bool = false
    
    // 响应背景事件的view
    var tapBackgroundView : PopoverBaskMaskView? = nil
    
    /// 当前view展示的父视图
    var contentSuperView : UIView? = nil
    
    /// 存在退出的动画
    var hasExitAnimation : Bool = false
    
    /// 提前加载的一些数据
    public func lazyLoad(){}
    
}



class PopoverMaskView: UIView ,UIGestureRecognizerDelegate {
    var contentView : UIView

    
    init(ContentView contentView : UIView) {
        
        self.contentView = contentView
        
        super.init(frame: .zero)
        
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(clickMaskView(_:)))
        tapGes.delegate = self
        self.addGestureRecognizer(tapGes)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func clickMaskView(_ sender : UIGestureRecognizer){
        self.removeFromSuperview()
    }
 
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        return !(self.contentView.point(inside: touch.location(in: self.contentView), with: nil))
    }
    
}
