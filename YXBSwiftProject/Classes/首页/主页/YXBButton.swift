//
//  YXBButton.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/9/28.
//  Copyright © 2023 ShengChang. All rights reserved.
//


import UIKit

extension UIButton {
    
    convenience init(title: String?, titleColor: UIColor?, image: UIImage?, titleFont: UIFont?, bgColor: UIColor? = nil) {
        self.init()
        setTitle(title, for: .normal)
        setImage(image, for: .normal)
        setTitleColor(titleColor, for: .normal)
        if let font = titleFont {
             titleLabel?.font = font
        }
        backgroundColor = bgColor
    }
    
    
    public func setButtonTo(text:String, color:UIColor, fontSize:CGFloat) {
        self.setTitle(text, for: .normal)
        self.setTitleColor(color, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        self.sizeToFit()
    }
    
    public convenience init(text:String, color:UIColor, fontSize:CGFloat) {
        self.init()
        self.setButtonTo(text: text, color: color, fontSize: fontSize)
    }
    
    public convenience init(text:String, color:UIColor, fontSize:CGFloat, target:AnyObject?, selector:Selector) {
        self.init()
        self.setButtonTo(text: text, color: color, fontSize: fontSize)
        self.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    public convenience init(imageName:String) {
        self.init()
        self.setImage(UIImage.init(named: imageName), for: .normal)
    }
    
    public convenience init(imageName:String, target:AnyObject?, selector:Selector) {
        self.init()
        self.setImage(UIImage.init(named: imageName), for: .normal)
        self.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    public func textLeftAndImageRight(space:CGFloat){
        //文字在左，图片在右
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -(self.imageView?.frame.size.width)!-space, bottom: 0.0, right: (self.imageView?.frame.size.width)!)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: (self.titleLabel?.bounds.size.width)!+space, bottom: 0, right: -(self.titleLabel?.bounds.size.width)!)
    }
   
    
    ///文字在右图片在左（正常状态的基础上加一个间距）
    func setImageLeftTextRight(space:CGFloat) {
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -space * 0.5, bottom: 0, right: space * 0.5)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: space * 0.5, bottom: 0, right: -space * 0.5)
    }
    ///文字在左图片在右（正常状态的基础上加一个间距，切换位置）
    func setTextLeftImageRight(space:CGFloat) {
        let imageWidth = self.imageView?.frame.size.width
        let labelWidth = self.titleLabel?.intrinsicContentSize.width
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth! + space * 0.5, bottom: 0, right: -labelWidth! - space * 0.5)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth! - space * 0.5, bottom: 0, right: imageWidth! + space * 0.5)
    }
    ///文字在下图片在上
    /*
     图像的中心位置向右移动了labelWidth * 0.5，向上移动了-imageHeight * 0.5 - space * 0.5
     文字的中心位置向左移动了imageWidth * 0.5，向下移动了labelHeight*0.5+space*0.5
     */
    func setImageTopTextBottom(space:CGFloat) {
        let imageWidth = self.imageView?.frame.size.width
        let imageHeight = self.imageView?.frame.size.height
        let labelWidth = self.titleLabel?.intrinsicContentSize.width
        let labelHeight = self.titleLabel?.intrinsicContentSize.height
        self.imageEdgeInsets = UIEdgeInsets(top: -imageHeight! * 0.5 - space * 0.5, left: labelWidth! * 0.5, bottom: imageHeight! * 0.5 + space * 0.5, right: -labelWidth! * 0.5)
        self.titleEdgeInsets = UIEdgeInsets(top: labelHeight! * 0.5 + space * 0.5, left: -imageWidth! * 0.5, bottom: -labelHeight! * 0.5 - space * 0.5, right: imageWidth! * 0.5)
    }
    ///文字在上图片在下
    /*
     图像的中心位置向右移动了labelWidth * 0.5，向下移动了imageHeight * 0.5 + space * 0.5
     文字的中心位置向左移动了imageWidth * 0.5，向上移动了labelHeight*0.5+space*0.5
     */
    func setTextTopImageBottom(space:CGFloat) {
        let imageWidth = self.imageView?.frame.size.width
        let imageHeight = self.imageView?.frame.size.height
        let labelWidth = self.titleLabel?.intrinsicContentSize.width
        let labelHeight = self.titleLabel?.intrinsicContentSize.height
        self.imageEdgeInsets = UIEdgeInsets(top: imageHeight! * 0.5 + space * 0.5, left: labelWidth! * 0.5, bottom: -imageHeight! * 0.5 - space * 0.5, right: -labelWidth! * 0.5)
        self.titleEdgeInsets = UIEdgeInsets(top: -labelHeight! * 0.5 - space * 0.5, left: -imageWidth! * 0.5, bottom: labelHeight! * 0.5 + space * 0.5, right: imageWidth! * 0.5)
    }
    
    @discardableResult
    func backgroundGradient<T: UIButton>(_ colours: [UIColor],
                                             _ isVertical: Bool = false,
                                             _ state: UIControl.State) -> T {
        let gradientLayer = CAGradientLayer()
            //几个颜色
        gradientLayer.colors = colours.map { $0.cgColor }
            //颜色的分界点
        gradientLayer.locations = [0.0,1.0]
            //开始
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            //结束,主要是控制渐变方向
        gradientLayer.endPoint  = isVertical == true ? CGPoint(x: 0.0, y: 1.0) : CGPoint(x: 1.0, y: 0)
            //多大区域
        gradientLayer.frame = self.bounds.isEmpty ? CGRect(x: 0, y: 0, width: 320, height: 30) : self.bounds
            
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
            
        if let context = UIGraphicsGetCurrentContext() {
                
            gradientLayer.render(in: context)
                
            let outputImage = UIGraphicsGetImageFromCurrentImageContext()
                
            UIGraphicsEndImageContext()
                
            setBackgroundImage(outputImage, for: state)
        }
        return self as! T
    }
    
    func removeAddedCAGradientLayer() {
        setBackgroundImage(nil, for: UIControl.State.normal)
    }
}


/// 支持自定义，且支持自动布局的按钮
class YXBButton: UIButton {

    enum ImagePostion {
        case left  // 图左文右
        case right  // 图右文左
        case top    // 图上文下
        case bottom  // 图下文上
    }

    public let imagePostion: ImagePostion
    public let interitemSpace: CGFloat

    init(postion: ImagePostion, interitemSpace space: CGFloat = 0) {
        imagePostion = postion
        interitemSpace = space
        super.init(frame: .zero)

        contentEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        let imageSize = imageView?.intrinsicContentSize ?? .zero
        let titleSize = titleLabel?.intrinsicContentSize ?? .zero

         guard let _ = imageView?.image, let _ = titleLabel?.text else {
            return super.intrinsicContentSize
        }

        switch imagePostion {
        case .left, .right:
            return CGSize(width: imageSize.width + interitemSpace + titleSize.width + contentEdgeInsets.left + contentEdgeInsets.right,
                          height: max(imageSize.height, titleSize.height) + contentEdgeInsets.top + contentEdgeInsets.bottom)

        case .bottom, .top:
            return CGSize(width: max(imageSize.width, titleSize.width) + contentEdgeInsets.left + contentEdgeInsets.right,
                         height: imageSize.height + interitemSpace + titleSize.height + contentEdgeInsets.top + contentEdgeInsets.bottom)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        guard let _ = imageView?.image, let _ = titleLabel?.text else {
            return
        }

        var imageWidth: CGFloat = 0.0
        var imageHeight: CGFloat = 0.0
        if let imgView = self.imageView {
            //    获取按钮图片的宽高
            let imgSize = (currentImage != nil) ? imgView.intrinsicContentSize : CGSize.zero
            imageWidth = imgSize.width
            imageHeight = imgSize.height
        }

        var labelWidth: CGFloat = 0.0
        var labelHeight: CGFloat = 0.0
        if let label = self.titleLabel {
            //    获取文字的宽高
            let labelSize = label.intrinsicContentSize
            labelWidth = labelSize.width
            labelHeight = labelSize.height
        }

        var imageOffset: CGFloat = 0

        if constraints.isEmpty {   //frame 布局
            let contentW = bounds.width - contentEdgeInsets.left - contentEdgeInsets.right

            if contentW >= labelWidth + imageWidth {
                imageOffset = labelWidth / 2
            } else {
                imageOffset = contentW > imageWidth ?  (contentW - imageWidth)/2 : 0
            }

        } else {   //自动布局
            
            if bounds.size != intrinsicContentSize {
                invalidateIntrinsicContentSize()
            }
            
            var constraintWidth: CGFloat = 0
            for item in constraints {
                if item.firstAttribute == .width {
                    constraintWidth = item.constant
                }
            }
            
            if constraintWidth > 0 {
                let constraintWidth = bounds.width - contentEdgeInsets.left - contentEdgeInsets.right

                if constraintWidth >= labelWidth + imageWidth {
                    imageOffset = labelWidth / 2
                } else {
                    imageOffset = constraintWidth > imageWidth ?  (constraintWidth - imageWidth)/2 : 0
                }
                
            }else{
                imageOffset =  labelWidth > imageWidth ?  (labelWidth - imageWidth)/2 : 0
            }
        }

        //按钮图片文字的位置 EdgeInsets 都是相对原来的位置变化
          var titleTop: CGFloat = 0.0, titleLeft: CGFloat = 0.0, titleBottom: CGFloat = 0.0, titleRight: CGFloat = 0.0
          var imageTop: CGFloat = 0.0, imageLeft: CGFloat = 0.0, imageBottom: CGFloat = 0.0, imageRight: CGFloat = 0.0

          switch imagePostion {
          case .left:
              //    图片在左、文字在右;
              imageTop = 0
              imageBottom = 0
              imageLeft =  -interitemSpace / 2.0
              imageRight = interitemSpace / 2.0

              titleTop = 0
              titleBottom = 0
              titleLeft = interitemSpace / 2
              titleRight = -interitemSpace / 2

          case .top://    图片在上，文字在下
              imageTop = -(labelHeight / 2.0 + interitemSpace / 2.0)//图片上移半个label高度和半个space高度  给label使用
              imageBottom = (labelHeight / 2.0 + interitemSpace / 2.0)
              imageLeft = imageOffset
              imageRight = -imageOffset

              titleLeft = -imageWidth
              titleRight = 0
              titleTop = imageHeight / 2.0 + interitemSpace / 2.0//文字下移半个image高度和半个space高度
              titleBottom = -(imageHeight / 2.0 + interitemSpace / 2.0)

          case .right://    图片在右，文字在左
              imageTop = 0
              imageBottom = 0
              imageRight = -(labelWidth + interitemSpace / 2.0)
              imageLeft = labelWidth + interitemSpace / 2.0

              titleTop = 0
              titleLeft = -(imageWidth + interitemSpace / 2.0)
              titleBottom = 0
              titleRight = imageWidth + interitemSpace / 2.0

          case .bottom://    图片在下，文字在上
              imageLeft =  imageOffset
              imageRight = -imageOffset
              imageBottom = -(labelHeight / 2.0 + interitemSpace / 2.0)
              imageTop = labelHeight / 2.0 + interitemSpace / 2.0//图片下移半个label高度和半个space高度  给label使用

              titleTop = -(imageHeight / 2.0 + interitemSpace / 2.0)
              titleBottom = imageHeight / 2.0 + interitemSpace / 2.0
              titleLeft =  -imageWidth
              titleRight = 0
          }

          imageEdgeInsets = UIEdgeInsets(top: imageTop, left: imageLeft, bottom: imageBottom, right: imageRight)
          titleEdgeInsets = UIEdgeInsets(top: titleTop, left: titleLeft, bottom: titleBottom, right: titleRight)

    }
}


class GradientCustomButton: YXBButton, GradientProtocol {
    public override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
}
