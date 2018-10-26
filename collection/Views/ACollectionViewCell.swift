//
//  ACollectionViewCell.swift
//  collection
//
//  Created by 薛永伟 on 2018/10/24.
//  Copyright © 2018年 薛永伟. All rights reserved.
//

import UIKit

class ACollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var btn: UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
//        customSubviews()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customSubviews()
    }
    lazy var shadowView: UIView = {
        let view = UIView.init()
        view.backgroundColor = UIColor.lightGray
        view.layer.shadowColor = UIColor.red.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 5
        
//        view.layer.shadowOffset = CGSize.init(width: 0, height: 0)
        view.layer.cornerRadius = 10
        view.layer.shouldRasterize = true
        return view
    }()
    
    func customSubviews(){
//        self.translatesAutoresizingMaskIntoConstraints = false
//        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.layer.drawsAsynchronously = true
        contentView.insertSubview(shadowView, at: 0)
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        shadowView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10).isActive = true
        shadowView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
        shadowView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10).isActive = true
        
        
   
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shadowView.layer.shadowPath = UIBezierPath.init(roundedRect: shadowView.bounds, cornerRadius: shadowView.layer.cornerRadius).cgPath
    }
}
