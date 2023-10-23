//
//  UIView+YXB.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/9/28.
//  Copyright © 2023 ShengChang. All rights reserved.
//

// 四个角度圆角
import UIKit

// MARK: 四个角可设置不同圆角值，普通的设置圆角直接使用SwiferSwift中的
extension UIView {
    public struct RectCorner {
        var topLeft: CGFloat
        var topRight: CGFloat
        var bottomLeft: CGFloat
        var bottomRight: CGFloat
        // 创建四个角不同半径大小的圆角结构体
        init(topLeft: CGFloat = 0, topRight: CGFloat = 0, bottomLeft: CGFloat = 0, bottomRight: CGFloat = 0) {
            self.topLeft = topLeft
            self.topRight = topRight
            self.bottomLeft = bottomLeft
            self.bottomRight = bottomRight
        }
        // 创建四个角相同半径大小的圆角结构体
        init(all cornerRadius: CGFloat) {
            self.topLeft = cornerRadius
            self.topRight = cornerRadius
            self.bottomLeft = cornerRadius
            self.bottomRight = cornerRadius
        }
    }
    
    /// 为支持4个不同数值的圆角,必须先设置frame
    /// - Parameters:
    ///   - corners: RectCorner(topLeft: 8, topRight: 8, bottomLeft: 4, bottomRight: 8)
    ///   - frame: 可不写，不过在使用这个之前一定要先设置了frame
    /// @Discussion:
    ///     -示例： label.addCorner(RectCorner(topLeft: 8, topRight: 8, bottomLeft: 4, bottomRight: 8))
    public func addCorner(_ corners: RectCorner, frame: CGRect? = nil) {
        let rect: CGRect = frame ?? self.bounds
        // 绘制路径
        let path = CGMutablePath()
        let topLeftRadius = corners.topLeft
        let topLeftCenter = CGPoint(x: rect.minX + topLeftRadius, y: rect.minY + topLeftRadius)
        path.addArc(center: topLeftCenter, radius: topLeftRadius, startAngle: Double.pi, endAngle: Double.pi * 1.5, clockwise: false)
        let topRightRadius = corners.topRight
        let topRightCenter = CGPoint(x: rect.maxX - topRightRadius, y: rect.minY + topRightRadius)
        path.addArc(center: topRightCenter, radius: topRightRadius, startAngle: Double.pi * 1.5, endAngle: Double.pi * 2, clockwise: false)
        let bottomRightRadius = max(corners.bottomRight, 0)
        let bottomRightCenter = CGPoint(x: rect.maxX - bottomRightRadius, y: rect.maxY - bottomRightRadius)
        path.addArc(center: bottomRightCenter, radius: bottomRightRadius, startAngle: 0, endAngle: Double.pi * 0.5, clockwise: false)
        let bottomLeftRadius = max(corners.bottomLeft, 0)
        let bottomLeftCenter = CGPoint(x: rect.minX + bottomLeftRadius, y: rect.maxY - bottomLeftRadius)
        path.addArc(center: bottomLeftCenter, radius: bottomLeftRadius, startAngle: Double.pi * 0.5, endAngle: Double.pi, clockwise: false)
        path.closeSubpath()
        // 给layer添加遮罩
        let layer = CAShapeLayer()
        layer.path = path
        self.layer.mask = layer
    }
}

// MARK: 四个圆角，支持约束。
extension UIView {
    /// Set the corner radius of UIView only at the given corner.
    /// Currently doesn't support `frame` property changes.
    /// If you change the frame, you have to call this function again.
    ///
    /// - Parameters:
    ///   - corners: Corners to apply radius.
    ///   - radius: Radius value.
    func cornerRadius(corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11, *) {
            var cornerMask: CACornerMask = []
            if corners.contains(.allCorners) {
                cornerMask = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
            } else {
                if corners.contains(.bottomLeft) {
                    cornerMask.update(with: .layerMinXMaxYCorner)
                }
                if corners.contains(.bottomRight) {
                    cornerMask.update(with: .layerMaxXMaxYCorner)
                }
                if corners.contains(.topLeft) {
                    cornerMask.update(with: .layerMinXMinYCorner)
                }
                if corners.contains(.topRight) {
                    cornerMask.update(with: .layerMaxXMinYCorner)
                }
            }
            
            layer.cornerRadius = radius
            layer.masksToBounds = true
            layer.maskedCorners = cornerMask
        } else {
            let rectShape = CAShapeLayer()
            rectShape.bounds = frame
            rectShape.position = center
            rectShape.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
            layer.mask = rectShape
        }
    }
}


// MARK: 渐变
extension UIView {
    /// Direction of the linear gradient.
    enum UIViewGradientDirection {
        /// Linear gradient vertical.
        case vertical
        /// Linear gradient horizontal.
        case horizontal
        /// Linear gradient from left top to right down.
        case diagonalLeftTopToRightDown
        /// Linear gradient from left down to right top.
        case diagonalLeftDownToRightTop
        /// Linear gradient from right top to left down.
        case diagonalRightTopToLeftDown
        ///  Linear gradient from right down to left top.
        case diagonalRightDownToLeftTop
        /// Custom gradient direction.
        case custom(startPoint: CGPoint, endPoint: CGPoint)
    }
    
    /// Create a linear gradient.
    ///
    /// - Parameters:
    ///   - colors: Array of UIColor instances.
    ///   - direction: Direction of the gradient.
    /// - Returns: Returns the created CAGradientLayer.
    @discardableResult
    func gradient(colors: [UIColor], direction: UIViewGradientDirection) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        
        var mutableColors: [Any] = colors
        for index in 0 ..< colors.count {
            let currentColor: UIColor = colors[index]
            mutableColors[index] = currentColor.cgColor
        }
        gradient.colors = mutableColors
        
        switch direction {
        case .vertical:
            gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradient.endPoint = CGPoint(x: 0.5, y: 1.0)

        case .horizontal:
            gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.5)

        case .diagonalLeftTopToRightDown:
            gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradient.endPoint = CGPoint(x: 1.0, y: 1.0)

        case .diagonalLeftDownToRightTop:
            gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.0)

        case .diagonalRightTopToLeftDown:
            gradient.startPoint = CGPoint(x: 1.0, y: 0.0)
            gradient.endPoint = CGPoint(x: 0.0, y: 1.0)

        case .diagonalRightDownToLeftTop:
            gradient.startPoint = CGPoint(x: 1.0, y: 1.0)
            gradient.endPoint = CGPoint(x: 0.0, y: 0.0)

        case let .custom(startPoint, endPoint):
            gradient.startPoint = startPoint
            gradient.endPoint = endPoint
        }
        layer.insertSublayer(gradient, at: 0)
        
        return gradient
    }
}
