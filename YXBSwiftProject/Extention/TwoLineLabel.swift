//
//  TwoLineLabel.swift
//  ZJVideo
//
//  Created by sckj on 2020/8/17.
//

import UIKit

@IBDesignable
class TwoLineLabel: UILabel {
    
    @IBInspectable var topText: String = "" {
        didSet {
            updateText()
        }
    }
    
    @IBInspectable var bottomText: String = "" {
        didSet {
            updateText()
        }
    }
        
    @IBInspectable var topColor: UIColor = .titleColor {
        didSet {
            updateText()
        }
    }
    
    @IBInspectable var bottomColor: UIColor = .subTitleColor {
        didSet {
            updateText()
        }
    }
    
    @IBInspectable var verticalSpace : CGFloat = 5 {
        didSet {
            updateText()
        }
    }

    /// @IBInspectable 对UIFont类型无效，系统可以，这个要再研究一下
    @IBInspectable var topFont: UIFont = .systemFont(ofSize: 18) {
        didSet {
            updateText()
        }
    }
    
    @IBInspectable var bottomFont: UIFont = .systemFont(ofSize: 12) {
        didSet {
            updateText()
        }
    }

    
    convenience init(topText: String, bottomText: String) {
        self.init(frame: CGRect.zero)
        self.topText = topText
        self.bottomText = bottomText
        updateText()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.backgroundColor = .clear
        self.addSubview(self.topLabel)
        self.addSubview(self.bottomLabel)

        updateText()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        self.addSubview(self.topLabel)
        self.addSubview(self.bottomLabel)

        updateText()
    }
    
    func updateText() {
        self.topLabel.text = self.topText
        self.bottomLabel.text = self.bottomText
        self.topLabel.font = self.topFont
        self.bottomLabel.font = self.bottomFont
        self.topLabel.textColor = self.topColor
        self.bottomLabel.textColor = self.bottomColor
    }
    
    lazy var topLabel: UILabel = {
        let v = UILabel()
        v.textAlignment = .center
        v.backgroundColor = .clear
        return v
    }()
    
    lazy var bottomLabel: UILabel = {
        let v = UILabel()
        v.textAlignment = .center
        v.backgroundColor = .clear
        return v
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let maxWidth = self.width
        self.topLabel.frame = CGRect(x: 0, y: 0, width: maxWidth, height: self.topFont.lineHeight)
        self.bottomLabel.frame = CGRect(x: 0, y: self.topLabel.height + verticalSpace, width: maxWidth, height: self.bottomFont.lineHeight)
    }
    
    override var intrinsicContentSize: CGSize {
        let topSize = self.topLabel.intrinsicContentSize
        let bottomSize = self.bottomLabel.intrinsicContentSize
        let maxWidth = max(topSize.width, bottomSize.width)
        return CGSize(width: maxWidth, height: self.topFont.lineHeight + self.verticalSpace + self.bottomFont.lineHeight)
    }
    
}
