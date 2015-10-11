//
//  TCGridFlowLayout.swift
//
//  Created by Marco Cancellieri on 10/10/15.
//  Copyright © 2015 Tricorn Corporation. All rights reserved.
//  http://tricorn.co/

import UIKit

class TCGridFlowLayout: UICollectionViewFlowLayout {
    
    private var isLandscape = UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication().statusBarOrientation)
    var inset: CGFloat = 0 {
        didSet{
            prepareLayout()
        }
    }
    var columns : Int = 2 {
        didSet{
            prepareLayout()
        }
    }
    var gutter : CGFloat = 1 {
        didSet{
            prepareLayout()
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
    
    override func prepareLayout() {
        if(scrollDirection  != .Vertical){
            debugPrint("WARNING: Horizontal scrollDirection not supported by TCGridFlowLayout. Setting Vertical direction!")
            scrollDirection = .Vertical
        }
        
        setSpacings()
        setItemSize(collectionViewContentSize())
    }
    
    private func setSpacings(){
        minimumInteritemSpacing = getGutter()
        minimumLineSpacing = getGutter()
        sectionInset = UIEdgeInsetsMake(getInset(), getInset(), getInset(), getInset())
    }
    
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        let cvWidth = collectionView!.frame.size.width
        
        // check if switching to landscape (seems like there's no better way of doing this...)
        if(newBounds.size.width != cvWidth){
            isLandscape = newBounds.size.width > cvWidth
            
            if(columnsLandscape == nil){
                columnsLandscape = getLandscapeColumns()
            }
            
            setItemSize(newBounds.size)
            
            return true
        }
        // Orientation has not changed. Don't invalidate layout
        return false
    }
    
    private func setItemSize(parentSize : CGSize){
        let sizeVal = CGFloat(Int((parentSize.width - (getColumns() - 1) * getGutter() - 2 * getInset()) / getColumns()))
        
        self.itemSize = CGSizeMake(sizeVal, sizeVal);
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