//
//  ViewController.swift
//  TCGridFlowLayoutExample
//
//  Created by Marco Cancellieri on 11/10/15.
//  Copyright © 2015 Tricorn Corporation. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.registerClass(TCGridViewCell.self, forCellWithReuseIdentifier: "gridCell")
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        let layout = TCGridFlowLayout(columns: 3, gutter: 1, inset: 0)
        self.collectionView.collectionViewLayout = layout
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 100
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("gridCell", forIndexPath: indexPath) as! TCGridViewCell
        
    
        cell.imageView.image = UIImage(named: "Tricorn_Cell")
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        self.performSegueWithIdentifier("showDetail", sender: self)
    }
    
    
    
}

