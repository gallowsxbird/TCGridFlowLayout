//
//  TCGridFlowLayout.swift
//
//  Created by Marco Cancellieri on 10/10/15.
//  Copyright © 2015 Tricorn Corporation. All rights reserved.
//  http://tricorn.co/

import UIKit

class TCGridFlowLayout: UICollectionViewFlowLayout {
  
    private var isLandscape = UIInterfaceOrientationIsLandscape(UIApplication.shared.statusBarOrientation)
    @IBInspectable var columns : Int = 2 {
        didSet{
            prepare()
        }
    }
    @IBInspectable var gutter : CGFloat = 1 {
        didSet{
            prepare()
        }
    }
    @IBInspectable var inset: CGFloat = 0 {
        didSet{
            prepare()
        }
    }
    
    var columnsLandscape : CGFloat?
    
    
    init(columns: Int, gutter: CGFloat, inset: CGFloat){
        super.init()
        self.columns = columns
        self.gutter = gutter
        self.inset = inset
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepare() {
        if(scrollDirection  != .vertical){
            debugPrint("WARNING: Horizontal scrollDirection not supported by TCGridFlowLayout. Setting Vertical direction!")
            scrollDirection = .vertical
        }
        
        setSpacings()
        setItemSize(parentSize: collectionViewContentSize)
    }
    
    private func setSpacings(){
        minimumInteritemSpacing = getGutter()
        minimumLineSpacing = getGutter()
        sectionInset = UIEdgeInsetsMake(getInset(), getInset(), getInset(), getInset())
    }
    
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        let cvWidth = collectionView!.frame.size.width
        
        // check if switching to landscape (seems like there's no better way of doing this...)
        if(newBounds.size.width != cvWidth){
            isLandscape = newBounds.size.width > cvWidth
            
            if(columnsLandscape == nil){
                columnsLandscape = getLandscapeColumns()
            }
            
            setItemSize(parentSize: newBounds.size)
            
            return true
        }
        // Orientation has not changed. Don't invalidate layout
        return false
    }
    
    private func setItemSize(parentSize : CGSize){
        let sizeVal = CGFloat(Int((parentSize.width - (getColumns() - 1) * getGutter() - 2 * getInset()) / getColumns()))
        
        self.itemSize = CGSize(width: sizeVal, height: sizeVal)
    }
    
    func getLandscapeColumns() -> CGFloat {
        let cvSize = collectionView!.frame.size
        return CGFloat(Int(cvSize.height / cvSize.width * CGFloat(columns)))
    }
    
    
    // return values based on current orientation
    func getColumns() -> CGFloat {
        if(isLandscape && columnsLandscape != nil){
            return columnsLandscape!
        }
        return CGFloat(columns)
    }
    // left these here for possible future changes
    func getInset() -> CGFloat {
        return inset
    }
    
    func getGutter() -> CGFloat {
        return gutter
    }

}
