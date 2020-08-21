//
//  UIView+Utils.swift
//  iOSAppNext
//
//  Created by Jin Sun on 2020/1/20.
//  Copyright © 2020 -. All rights reserved.
//

import UIKit

extension UIView {
    
    @objc
    public func lockUserInteraction(_ duration: TimeInterval = 1.2) {
        isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) { 
            self.isUserInteractionEnabled = true
        }
    }
    
    // MARK: - geometry
    
    @objc
    public var bottomLeftPoint: CGPoint {
        get { return CGPoint(x: qmui_left, y: qmui_bottom) }
        set { frame.origin = CGPoint(x: newValue.x, y: newValue.y - qmui_height) }
    }
    
    @objc
    public var topRightPoint: CGPoint {
        get { return CGPoint(x: qmui_right, y: qmui_top) }
        set { frame.origin = CGPoint(x: newValue.x - qmui_width, y: newValue.y) }
    }
    
    @objc
    public var bottomRightPoint: CGPoint {
        get { return CGPoint(x: qmui_right, y: qmui_bottom) }
        set { frame.origin = CGPoint(x: newValue.x - qmui_width, y: newValue.y - qmui_height) }
    }
    
    @objc
    public func centerHorizontally() {
        guard let sp = superview else { return }
        qmui_left = (sp.qmui_width - qmui_width) / 2
    }
    
    @objc
    public func centerVertically() {
        guard let sp = superview else { return }
        qmui_top = (sp.qmui_height - qmui_height) / 2
    }
    
    @objc
    public func centerInSuperview() {
        guard let sp = superview else { return }
        center = CGPoint(x: sp.qmui_width / 2, y: sp.qmui_height / 2)
    }
    
    @objc
    public func sv_safeAreaInsets() -> UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.safeAreaInsets ?? UIEdgeInsets.zero
        } else {
            return UIEdgeInsets.make(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    //MARK: - Nib
    
    @objc
    public class func loadFromNib() -> Self? {
        return loadFromNib(named: nil)
    }
    
    @objc
    public class func loadFromNib(named nibname: String? = nil) -> Self? {
        return loadFromNib(named: nibname, bundle: .main)
    }
    
    @objc
    public class func loadFromNib(named nibname: String? = nil, bundle: Bundle = .main) -> Self? {
        let name = nibname ?? className
        return bundle.loadNibNamed(name, owner: nil, options: nil)?.first as? Self
    }
    
    //MARK: - Heriachey
    
    public func ancestorViewOf<T>(_ kind: T) -> UIView? where T: UIView {
        var parentView = superview
        while parentView != nil && (!(parentView!.isKind(of: T.self))) {
            parentView = parentView?.superview
        }
        return parentView
    }
    
    public func childrenViewOfKind<T>(_ kind: T) -> UIView? where T: UIView {
        for view in subviews {
            if view.isKind(of: T.self) {
                return view
            } else {
                if let subView = view.childrenViewOfKind(kind) {
                    return subView
                }
            }
        }
        return nil
    }
    
    // MARK: - animation
    @objc
    public func pulsateOnce() {
        let scaleUp = CABasicAnimation(keyPath: "transform")
        scaleUp.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        scaleUp.duration = 0.25
        scaleUp.repeatCount = 1
        scaleUp.autoreverses = true
        scaleUp.isRemovedOnCompletion = true
        scaleUp.toValue = transform.scaledBy(x: 1.2, y: 1.2)
        layer.add(scaleUp, forKey: "pulsate")
    }
    
    // MARK: - transition
    @objc
    public func transitToSubview(view: UIView, option: UIView.AnimationOptions, duration: CGFloat) {
        UIView.transition(with: view, duration: TimeInterval(duration), options: option, animations: {
            self.addSubview(view)
        }, completion: nil)
    }
    
    // MARK: - gradient
    private struct SJAssociatedKeys {
        static var gradientLayer = "kGradientLayerKey"
    }
    
    @objc
    public var gradientLayer: CAGradientLayer? {
        get {
            return objc_getAssociatedObject(self, &SJAssociatedKeys.gradientLayer) as? CAGradientLayer
        }
        set {
            objc_setAssociatedObject(self, &SJAssociatedKeys.gradientLayer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc
    public func setGradientBackground(startColor: UIColor, toColor: UIColor, startPoint:CGPoint = CGPoint(x: 0, y: 0.5), endPoint:CGPoint = CGPoint(x: 1, y: 0.5)) {
        if let gradient = self.gradientLayer, gradient.superlayer != nil {
            gradient.removeFromSuperlayer()
        }
        
        let gradient = CAGradientLayer()
        gradient.colors = [startColor.cgColor, toColor.cgColor]
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.locations = [0, 1.0]
        gradient.frame = bounds
        layer.insertSublayer(gradient, at: 0)
        gradientLayer = gradient
    }
    
    // MARK: - gesture
    
    @discardableResult @objc
    public func addTapRecognizer(target: Any?, action: Selector?) -> UITapGestureRecognizer {
        gestureRecognizers?.forEach({ gesture in
            if gesture.isKind(of: UITapGestureRecognizer.self) {
                self.removeGestureRecognizer(gesture)
            }
        })
        isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: target, action: action)
        addGestureRecognizer(tapRecognizer)
        return tapRecognizer
    }
    
    @discardableResult @objc
    public func addPanRecognizer(target: Any?, action: Selector?) -> UIPanGestureRecognizer {
        gestureRecognizers?.forEach({ gesture in
            if gesture.isKind(of: UIPanGestureRecognizer.self) {
                self.removeGestureRecognizer(gesture)
            }
        })
        isUserInteractionEnabled = true
        let gesture = UIPanGestureRecognizer(target: target, action: action)
        addGestureRecognizer(gesture)
        gesture.minimumNumberOfTouches = 1
        gesture.maximumNumberOfTouches = 1
        return gesture
    }
    
    @discardableResult
    public func addGestureRecognizer<T>(target: Any?, action: Selector?, config: ((T) -> Void)?) -> T where T: UIGestureRecognizer {
        gestureRecognizers?.forEach({ gesture in
            if gesture.isKind(of: T.self) {
                self.removeGestureRecognizer(gesture)
            }
        })
        isUserInteractionEnabled = true
        let gesture = T(target: target, action: action)
        addGestureRecognizer(gesture)
        config?(gesture)
        return gesture
    }
}

