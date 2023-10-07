//
//  UIView+Gradient.swift
//  flyingfish
//
//  Created by chyu on 2020/8/25.
//  Copyright © 2020 syc. All rights reserved.
//

import UIKit

// MARK: 渐变,有两种方式，还有一种在UIView+YXB里
enum GradientDirection {
    case fromLeftToRight, fromTopToBottom, fromLTopToRBottom, fromRTopToLBottom, special(CGPoint, CGPoint)

    var startPoint: CGPoint {
        switch self {
        case .fromLeftToRight, .fromTopToBottom, .fromLTopToRBottom:
            return CGPoint(x: 0, y: 0)
        case .fromRTopToLBottom:
            return CGPoint(x: 1, y: 0)
        case .special(let sPoint, _):
            return sPoint
        }
    }

    var endPoint: CGPoint {
        switch self {
        case .fromLeftToRight: return CGPoint(x: 1, y: 0)
        case .fromTopToBottom: return CGPoint(x: 0, y: 1)
        case .fromLTopToRBottom: return CGPoint(x: 1, y: 1)
        case .fromRTopToLBottom: return CGPoint(x: 0, y: 1)
        case .special(_, let ePoint): return ePoint
        }
    }
}

//enum LSGradientColorStyle {
//    case login
//    case main
//
//    var colors: [UIColor] {
//        switch self {
//        case .login:   return [UIColor(.blue3CC9FD), UIColor(.purpleB42BFF)]
//        case .main:    return [UIColor(.blue70D1FE), UIColor(.purpleC069FF)]
//        }
//    }
//}
//
//
protocol GradientProtocol {

//    func makeBackgroundGradient(_ colorStyle: LSGradientColorStyle, direction: LSGradientDirection, locations: [NSNumber]?)

    func makeGradient(_ colors: [UIColor], direction: GradientDirection, locations: [NSNumber]?)

    func clearGradient()
}

extension GradientProtocol where Self: UIView {
//    func makeBackgroundGradient(_ colorStyle: LSGradientColorStyle, direction: LSGradientDirection = .fromTopToBottom, locations: [NSNumber]? = nil) {
//        makeGradient(colorStyle.colors, direction: direction, locations: locations)
//    }

    func makeGradient(_ colors: [UIColor], direction: GradientDirection = .fromLeftToRight, locations: [NSNumber]? = nil) {
        if let gradientLayer = layer as? CAGradientLayer {

            gradientLayer.colors = colors.map({ $0.cgColor })
            gradientLayer.locations = locations
            gradientLayer.startPoint = direction.startPoint
            gradientLayer.endPoint = direction.endPoint

        }
    }

    func clearGradient() {
        if let gradientLayer = layer as? CAGradientLayer {
            gradientLayer.colors = nil
            gradientLayer.locations = nil
        }
    }
    
}

public class GradientView: UIView, GradientProtocol{

    public override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
}

public class GradientLabel: UILabel, GradientProtocol {

    public override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
}

public class GradientButton: UIButton, GradientProtocol {

    public override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
}

public class GradientImageView: UIImageView, GradientProtocol {
    public override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
}
