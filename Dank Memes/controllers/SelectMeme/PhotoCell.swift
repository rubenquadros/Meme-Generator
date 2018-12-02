//
//  PhotoCell.swift
//  Dank Memes
//
//  Created by Ruben on 12/08/18.
//  Copyright © 2018 Ruben. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell, UICollectionViewDelegate {
    
    lazy var myImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = UIColor.white
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupView(){
        self.addSubview(myImageView)
        myImageView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 200)
    }
    
}
