//
//  HeaderFrame.swift
//  voice
//
//  Created by mac on 2023/3/28.
//

import UIKit
import SDWebImage

// 头像 + 静态框
@objc class HeaderStaticView: UIView {
    
    @objc var headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    @objc var headerFramImageView = UIImageView()
    
    @objc var image: UIImage? {
        headerImageView.image
    }
    
    @objc public func setImage(url: String?, headerFrameUrl: String? = nil, placeholderImage: UIImage? = nil) {
        if let url = url {
            if url.hasPrefix("http") {
                headerImageView.sd_setImage(with: URL(string: url), placeholderImage: placeholderImage)
            } else {
                headerImageView.image = UIImage(named: url)
            }
        } else {
            headerImageView.image = nil
        }
        headerFramImageView.sd_setImage(with: URL(string: headerFrameUrl ?? ""))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(headerImageView)
        self.addSubview(headerFramImageView)
        
        headerImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
//            make.edges.equalToSuperview().inset(2).priority(900)
        }
        
        // 头像框是头像的1.25倍
        headerFramImageView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
            make.center.equalToSuperview()
            make.width.equalTo(headerImageView.snp.width).multipliedBy(1.25)
            make.height.equalTo(headerImageView.snp.height).multipliedBy(1.25)
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
