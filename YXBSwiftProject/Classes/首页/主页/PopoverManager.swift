//
//  PopoverManager.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/10/20.
//  Copyright © 2023 ShengChang. All rights reserved.
//
//  悬浮窗

/**
 弹窗应该有以下几个接口
 
 
 public class func showPopover(WithContent contentView : PopoverBaseView ,
                        popoverBgAction action : Selector? = nil,
                        popoverBgTarget target : Any? = nil,
                        popoverSuperView : UIView? = nil
                        )

 
 */

import Foundation
import UIKit

class PopDownView : UIView {
    
}

class PopoverSheetView : PopoverBaseView {
    public var sheetSelectHandle : ((Int) -> ())?
}


@objc class PopoverManager : NSObject {
    
    
    // 根据剪切板，展示跳转弹窗
    @objc class func showJumpLive(_ content : String) {
        
        // 现在先没登录，直接不处理了。
        // 如果当前是登录页面
        // 如果没有登录，弹出登录
        
    }
    
    static var keyboardTopView : UIView?
    
    public static func getCurrentPopView() -> PopoverBaseView? {
        return PopoverManager.currentView
    }
    
 
    fileprivate static var popupBgView = UIView()
    
    fileprivate static var currentView : PopoverBaseView?

    fileprivate static var maskView = UIView()
    
    // 展示了多少个view
    fileprivate static var popoverViews : [PopoverBaseView] = [PopoverBaseView]()
    
    // 1、 展示在window上 ✅
    // 2、 如果传入了superview，就展示在superView上 ✅
    // 3、 是否添加背景view ✅
    // 4、 添加背景颜色 ✅
    // 5、 背景view是否拦截点击事件 ✅
    // 6、 背景点击事件 ✅
    // 6.1、点击背景，不处理 ✅
    // 6.2、 点击背景，直接关闭当前所有的视图链 ✅
    // 6.3、 点击背景，只关闭当前视图 ✅
    // 6.4、 点击背景，关闭当前视图，展示上一级视图 ✅
    // 7、  是否先隐藏当前弹窗  ✅
    // 8、  是否展示动画出现  ✅
    
    class func show(_ contentView : PopoverBaseView ,
                           contentSuperView : UIView? = nil ,
                           hasBackgroundView : Bool = true ,
                    backgroundViewColor : UIColor = .init(white: 0, alpha: 0.3) ,
                    backgroundViewFrame : CGRect? = nil,
                           backgroundViewUserInterface : Bool = true ,
                    backgroundViewTapStyle : PopoverBackGroundTapGestureRecognizer = .defaultClose ,
//                           backgroundViewTapSender : UITapGestureRecognizer? = nil ,
                           isHiddenLastView : Bool = false ,
                           isAnimation : Bool = true ){
        
        contentView.isHidden = false
        
        if let superView = (contentSuperView ?? UIApplication.shared.windows.first?.rootViewController?.view) {
            superView.addSubview(contentView)
            contentView.contentSuperView = contentSuperView
           
            
            if hasBackgroundView {
                let backgroundView = PopoverBaskMaskView(frame: backgroundViewFrame ?? superView.bounds)
                backgroundView.contentView = contentView
                contentView.tapBackgroundView = backgroundView
                backgroundView.backgroundColor = backgroundViewColor
                superView.insertSubview(backgroundView, belowSubview: contentView)
                
                if backgroundViewUserInterface {
                    let tagGesSelect = self.tapGesture(backgroundViewTapStyle)
                    backgroundView.tapGesStyle = backgroundViewTapStyle
                    backgroundView.isUserInteractionEnabled = true
                    backgroundView.addGestureRecognizer(tagGesSelect)
                }
            }
            
            if isHiddenLastView {
                self.popoverViews.last?.isHidden = true
                contentView.lastView = self.popoverViews.last
            }
            
            if isAnimation {
                contentView.transform = CGAffineTransform.init(translationX: 0, y: contentView.bounds.size.height)
                UIView.animate(withDuration: 0.2, delay: 0, options: .transitionCurlDown) {
                    contentView.alpha = 1
                    contentView.transform = CGAffineTransform.init(translationX: 0, y: -10)
                } completion: { finished in
                    UIView.animate(withDuration: 0.08, delay: 0, options: .curveEaseInOut, animations: {
                        contentView.transform = CGAffineTransform.identity
                    }, completion: nil)
                }
            }
            
            // 添加进管理views中
            self.popoverViews.append(contentView)
            
            
        } else { // 如果没有window，不处理
        }
    }
    
    @objc public enum PopoverBackGroundTapGestureRecognizer : Int {
        case defaultClose
        case closeAllPopoverChannel
        case closeAllPopover
        case showLastPopover
    }
    
    /// 返回点击背景事件的方法
    @objc class public func tapGesture(_ type : PopoverBackGroundTapGestureRecognizer) -> UITapGestureRecognizer {
        switch type {
        case .defaultClose:
            return UITapGestureRecognizer.init(target: self, action: #selector(clickBackgroundViewWithDefalut(_:)))
        case .closeAllPopoverChannel:
            return UITapGestureRecognizer.init(target: self, action: #selector(clickBackgroundViewWithCloseAllPopoverChannel(_:)))
        case .closeAllPopover:
            return UITapGestureRecognizer.init(target: self, action: #selector(clickBackgroundViewWithCloseAllPopover(_:)))
        case .showLastPopover:
            return UITapGestureRecognizer.init(target: self, action: #selector(clickBackgroundViewWithShowLastPopover(_:)))
        }
    }
    
    // MARK: - 移除当前的popoverView
    @objc class func removePopoverViewFromSuperView(_ popoverView : PopoverBaseView? ) {
        if self.popoverViews.count == 0 {
            return
        }
        
        self.popoverViews.removeLast()
        
        popoverView?.tapBackgroundView?.removeFromSuperview()
        popoverView?.removeFromSuperview()
        popoverView?.nextView = nil
        popoverView?.tapBackgroundView = nil
    }
    
    
    // MARK: - 具体的点击背景视图的方法
    // MARK: 点击背景
    @objc class func clickBackgroundViewWithDefalut( _ sender : UITapGestureRecognizer) {

    }
    
    // MARK: 点击背景，直接关闭当前所有的视图链
    @objc class func clickBackgroundViewWithCloseAllPopoverChannel( _ sender : UITapGestureRecognizer) {
        if let popoverView = (sender.view as? PopoverBaskMaskView)?.contentView {
            self.closeAllPopoverChannel(popoverView)
        }
    }
    
    @objc class func closeAllPopoverChannel( _ sender : PopoverBaseView){
        
        if let popoverView = sender.lastView {
            self.closeAllPopoverChannel(popoverView)
        }
        
        self.removePopoverViewFromSuperView(sender)
    }
    
    // MARK: 点击背景，关闭window下的所有弹窗
    @objc class func clickBackgroundViewWithCloseAllPopover( _ sender : UITapGestureRecognizer) {
        
        let _ = self.popoverViews.map { view in
            view.removeFromSuperview()
        }
        self.popoverViews.removeAll()
    }
    
    // MARK: 点击背景，关闭当前视图，展示上一级视图
    @objc class func clickBackgroundViewWithShowLastPopover( _ sender : UITapGestureRecognizer?) {
        if let popoverView = (sender?.view as? PopoverBaskMaskView)?.contentView {
            let lastView = popoverView.lastView
            self.removePopoverViewFromSuperView(popoverView)
            
            lastView?.isHidden = false
            
            if let superView = lastView?.contentSuperView {
                superView.addSubview(lastView!)
            }
        }
    }
    
    // MARK: 点击背景，关闭当前视图，展示上一级视图
    @objc class func clickBackgroundViewWithShowLastPopover( senderView : UIView? = nil) {
        if let popoverView = (senderView as? PopoverBaseView)?.tapBackgroundView?.contentView {
            let lastView = popoverView.lastView
            self.removePopoverViewFromSuperView(popoverView)
            
            lastView?.isHidden = false
            
            if let superView = lastView?.contentSuperView {
                superView.addSubview(lastView!)
            }
        }
    }

    
    @objc class func closePopover(toStyle style : PopoverBackGroundTapGestureRecognizer , fromPopoverView popoverView : PopoverBaseView) {
        switch style {
        case .defaultClose :
            debugPrint("")
        case .showLastPopover :
            let lastView = popoverView.lastView
            self.removePopoverViewFromSuperView(popoverView)
            
            if let superView = lastView?.contentSuperView {
                superView.addSubview(lastView!)
            }
            
        case .closeAllPopoverChannel :
            self.removePopoverViewFromSuperView(popoverView)
            
        case .closeAllPopover :
            let _ = self.popoverViews.map { view in
                view.removeFromSuperview()
            }
            self.popoverViews.removeAll()
            
        }
    }
    
    
    
    @objc class func clickBackgroundView( _ sender : UITapGestureRecognizer) {
        
    }
    
    @objc class func close(_ popoverView : PopoverBaseView) {
        if let tapGesView = popoverView.tapBackgroundView {
            
            self.closePopover(toStyle: tapGesView.tapGesStyle, fromPopoverView: popoverView)
        
        }
    }
    
    @objc class func closeView(_ popoverView : UIView) {
        self.clickMaskView(UIGestureRecognizer())
    }

    
    
    
    /** -------------  */
    
    
    
    
    
    
    
    @objc class func closeAlphHiddenPopover(){
        self.currentView?.alpha = 0;
        self.popupBgView.alpha = 0;
    }
    
    @objc class func showAlphPopover(){
        self.currentView?.alpha = 1;
        self.popupBgView.alpha = 1;
    }
    
    
   @objc class func closeAllPopover(){
       
       for item in self.popoverViews {
           
           if item.isKind(of: PopoverBaseView.self) {
               PopoverManager.close(item)
           }
           item.removeFromSuperview()
       }
       self.popoverViews.removeAll()
       self.maskView.removeFromSuperview()
       
       let maskList = UIApplication.shared.windows.first?.rootViewController?.view.subviews.filter({ item in
           return item.isKind(of: PopoverBaskMaskView.self) || item.isKind(of: PopoverMaskView.self)
       })
       for item in maskList ?? [] {
           item.removeFromSuperview()
       }
       
       
       
       
        self.currentView?.removeFromSuperview()
        self.currentView = nil
        for item in self.popupBgView.subviews {
            item.removeFromSuperview()
        }
        self.popupBgView.removeFromSuperview()
    }
    
    class func closePopoverView(_ view : PopoverBaseView) {
        
        if self.currentView == view , view.isMultiple == false {
            self.closeAllPopover()
        } else if view.isMultiple == true {
            self.backLastPopoverView()
        } else {
            view.removeFromSuperview()
        }
    }
    
    
    
    class func showPopover(WithPopBaseView contentView : PopoverBaseView ,
                           popoverBgAction action : Selector? = nil,
                           popoverBgTarget target : NSObjectProtocol? = nil,
                           popoverSuperView : UIView? = nil,
                           popoverBackgroundColor : UIColor? = nil,
                           canTapBackDismiss: Bool = true
                           ){
        
        self.popupBgView.backgroundColor = popoverBackgroundColor ?? .init(white: 0, alpha: 0.6)
        
        contentView.lastView = self.currentView
        self.currentView?.removeFromSuperview()
        
        self.popupBgView.addSubview(contentView)
        self.currentView = contentView

        
//        if contentView.mm_maxY != UIScreen.main.bounds.maxY ,
//           contentView.mm_maxY == (UIScreen.main.bounds.maxY - (UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0)){
//            // 给底部添加纯色
//            contentView.clipsToBounds = false
//            contentView.layer.masksToBounds = false
//            let addView = UIView()
//            addView.backgroundColor = contentView.backgroundColor
//            contentView.addSubview(addView)
//            addView.snp.makeConstraints {
//                $0.top.equalTo(contentView.snp.bottom)
//                $0.left.right.equalToSuperview()
//                $0.height.equalTo(UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0)
//            }
//        }
        
        
        // 还没有添加过pop
        if self.popupBgView.superview == nil {
                 
            self.popupBgView.insertSubview(maskView, at: 0)

            if popoverSuperView != nil {
                popoverSuperView?.addSubview(self.popupBgView)
            } else {
                UIApplication.shared.windows.first?.rootViewController?.view.addSubview(self.popupBgView)
            }
            self.maskView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            self.popupBgView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }

        }
        
        if canTapBackDismiss {
            self.maskView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(clickMaskView)))
        } else {
            if let tapGes = self.maskView.gestureRecognizers?.first {
                self.maskView.removeGestureRecognizer(tapGes)
            }
        }
        
        
        contentView.transform = CGAffineTransform.init(translationX: 0, y: 30)
        UIView.animate(withDuration: 0.2, delay: 0, options: .transitionCurlDown) {
            contentView.alpha = 1
            contentView.transform = CGAffineTransform.init(translationX: 0, y: -10)
        } completion: { finished in
            UIView.animate(withDuration: 0.08, delay: 0, options: .curveEaseInOut, animations: {
                contentView.transform = CGAffineTransform.identity
            }, completion: nil)
        }
    }
    
    
    // contentView 为 UIView的话，先关闭之前的所有
    class func showPopover(WithContent contentView : UIView ,
                           popoverBgAction action : Selector? = nil,
                           popoverBgTarget target : NSObjectProtocol? = nil,
                           popoverSuperView : UIView? = nil,
                           popoverBackgroundColor : UIColor? = nil
                           ){
        
        if contentView.isKind(of: PopoverBaseView.self),
        let popBaseView = contentView as? PopoverBaseView {
            self.showPopover(WithPopBaseView: popBaseView,
            popoverBgAction: action,
            popoverBgTarget: target,
            popoverSuperView: popoverSuperView,
            popoverBackgroundColor: popoverBackgroundColor)
            
            return
        }
//        if contentView == self.currentView {
//            return
//        }
//        PopoverManager.closeAllPopover()
        
        self.popupBgView.backgroundColor = popoverBackgroundColor ?? .init(white: 0, alpha: 0.6)


        self.popupBgView.addSubview(contentView)
        
        
        // 还没有添加过pop
        if self.popupBgView.superview == nil {
                 
            self.popupBgView.insertSubview(maskView, at: 0)

            UIApplication.shared.windows.first?.rootViewController?.view.addSubview(self.popupBgView)
            self.maskView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            
            self.popupBgView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            
            let oldFrame = contentView.frame
            var newFrame = oldFrame
            newFrame.origin.y = ScreenConst.height
            contentView.frame = newFrame

            UIView.animate(withDuration: TimeInterval(0.2)) {
                contentView.frame = oldFrame
            }
            
            
            
        }
        

        
        self.maskView.addGestureRecognizer(
            UITapGestureRecognizer
                .init(target: self,
                      action: #selector(clickMaskView))
        )

    }
    
    
    
    @objc public class func backLastPopoverView(){
        if let lastPop = self.currentView?.lastView {
            self.currentView?.removeFromSuperview()
            self.currentView = nil
            
            self.currentView = lastPop
            self.popupBgView.addSubview(lastPop)
        } else if let view = self.popoverViews.last {
            PopoverManager.clickBackgroundViewWithShowLastPopover(senderView: view)
        } else {
            self.closeAllPopover()
        }

    }

    
    @objc class func clickMaskView( _ ges : UIGestureRecognizer? = nil) {
        
        for item in self.popupBgView.subviews {
            item.removeFromSuperview()
        }
        self.popupBgView.removeFromSuperview()
        self.currentView = nil

    }
    
    
    static var sheetView : UIView = UIView()
    
    @objc class func showActionSheet(_ titles : [String],
                                     _ titlesTags : [Int]? = nil,
                                     _ hasCancel : Bool = true,
                                     selectHandle : @escaping (Int) -> ()){
        
//        self.sheetSelectHandle = selectHandle
       
        
        var height = 44 * titles.count

        
        let topHeight = 5
        height += topHeight
        if hasCancel {
            height += 5
            height += 44
        }
        
        let sheetView = PopoverSheetView(frame: CGRect(x: 0, y: ScreenConst.height - ScreenConst.bottomSpaceHeight - CGFloat(height), width: ScreenConst.width, height: CGFloat(height) + ScreenConst.bottomSpaceHeight))
        sheetView.backgroundColor = .init(hex: 0xFFFFFF)
        sheetView.sheetSelectHandle = selectHandle
        self.showPopover(WithContent: sheetView)
//        self.show(sheetView, backgroundViewTapStyle: .showLastPopover)
        
        for (index,item) in titles.enumerated() {
            let btn = self.createSheetBtn(item, tag: titlesTags?[index] ?? index)
            sheetView.addSubview(btn)
            
            btn.snp.makeConstraints {
                $0.top.equalToSuperview().offset(topHeight + index * 44)
                $0.left.right.equalToSuperview()
                $0.height.equalTo(44)
            }
        }
        
        if hasCancel {
            let btn = self.createSheetBtn("取消", tag: -1)
            sheetView.addSubview(btn)
            
            btn.snp.makeConstraints {
                $0.bottom.equalToSuperview().offset(-ScreenConst.bottomSpaceHeight)
                $0.left.right.equalToSuperview()
                $0.height.equalTo(44)
            }

            let lineView = UIView()
            lineView.backgroundColor = .init(hex: 0xF2F2F2)
            sheetView.addSubview(lineView)
            lineView.snp.makeConstraints {
                $0.bottom.equalTo(btn.snp.top)
                $0.left.right.equalToSuperview()
                $0.height.equalTo(1)
            }
        }
        
    }

    
    @objc class func clickSheetBtn(_ sender : UIButton) {
        if sender.tag == -1 {
            self.backLastPopoverView()
        } else {
            if let sheetView = self.currentView as? PopoverSheetView {
                sheetView.sheetSelectHandle?(sender.tag)
                return
            } else {
                
            }
        }
    }
}

extension PopoverManager {
    
    fileprivate class func createSheetBtn(_ title : String, tag : Int) -> UIButton {
        let btn = UIButton(type: .custom)
        btn.tag = tag
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(.init(hex: 0x222222), for: .normal)
        btn.titleLabel?.font = .init(name: "PingFangSC-Regular", size: 16)
        btn.addTarget(self, action: #selector(clickSheetBtn(_:)), for: .touchUpInside)
        btn.backgroundColor = .init(hex: 0xFFFFFF)
        return btn
    }
    
}
