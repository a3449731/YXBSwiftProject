//
//  HeaderFrame.swift
//  voice
//
//  Created by mac on 2023/3/28.
//

import UIKit
import SDWebImage

// 头像 + 静态框
class HeaderStaticView: UIView {
    
    private var headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private var headerFramImageView = UIImageView()
    
    public func setImage(url: String?, headerFrameUrl: String? = nil, placeholderImage: UIImage? = nil) {
        headerImageView.sd_setImage(with: URL(string: url ?? ""), placeholderImage: placeholderImage)
        headerFramImageView.sd_setImage(with: URL(string: headerFrameUrl ?? ""))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(headerImageView)
        self.addSubview(headerFramImageView)
        
        headerImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(2).priority(900)
        }
        
        headerFramImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerImageView.layer.cornerRadius = (self.frame.height - 4)/2
    }
}
