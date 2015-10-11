//
//  TCGridViewCell.swift
//  GridTest
//
//  Created by Marco Cancellieri on 10/10/15.
//  Copyright © 2015 Tricorn Corporation. All rights reserved.
//  http://tricorn.co/

import UIKit

class TCGridViewCell: UICollectionViewCell {
    var imageView = UIImageView()
    var highlightView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupCell()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupCell()
        
    }
    
    private func setupCell(){
        self.imageView.contentMode = .ScaleAspectFill
        self.backgroundView = self.imageView
        
        self.highlightView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.selectedBackgroundView = self.highlightView
    }
    
    func setImage(image: UIImage){
        self.imageView.image = image
    }
    
    override func prepareForReuse() {
        self.imageView.image = nil
        self.selected = false
    }
}
