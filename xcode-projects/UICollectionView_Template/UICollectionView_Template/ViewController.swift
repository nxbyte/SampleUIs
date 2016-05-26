/*
    Author:      Warren Seto
    Source File: ViewController.swift
    Project:     UICollectionView_Template
*/

// Images courtesy of pixabay.com

import UIKit

class ViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(#function)
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionCell", forIndexPath: indexPath) as! CanvasCell,
            randomImage = "nature\(Int(arc4random_uniform(8) + 1)).jpg"
        
        cell.picture.image = UIImage(named: randomImage)
        cell.caption.text = randomImage
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    /* Configures the size of each UICollectionView Cell */
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone {
            return CGSize(width: UIScreen.mainScreen().bounds.width - 20, height: 150)
        }
        
        else {
            return CGSize(width: 360, height: 150)
        }
    }
    
    override func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        (collectionView.cellForItemAtIndexPath(indexPath) as! CanvasCell).picture.alpha = 0.9
    }
    
    override func collectionView(collectionView: UICollectionView, didUnhighlightItemAtIndexPath indexPath: NSIndexPath) {
        (collectionView.cellForItemAtIndexPath(indexPath) as! CanvasCell).picture.alpha = 1
    }
    
    /* Updates the UICollectionView when the orientation changes with new frames */
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator)
    {
        guard coordinator.animateAlongsideTransition({ context in self.collectionView!.frame.size = size }, completion: nil)
        else { return }
    }
    
    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() }
}


/* A subclass of the default UICollectionViewCell to customize the cell */
class CanvasCell : UICollectionViewCell
{
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var caption: UILabel!

    override func layoutSubviews()
    {
        picture.layer.cornerRadius = 4.0
        picture.layer.masksToBounds = true
        
        caption.layer.shadowOpacity = 1
        caption.layer.shadowOffset = CGSizeZero
        caption.layer.masksToBounds = false
        caption.layer.shouldRasterize = true
        caption.layer.rasterizationScale = UIScreen.mainScreen().scale
        
        self.contentView.frame = self.bounds
    }
}
