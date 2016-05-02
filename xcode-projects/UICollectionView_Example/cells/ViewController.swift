// Warren Seto
// ViewController.swift
// cells (UICollectionView)

// Images courtesy of pixabay.com

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        print("Click")
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CanvasCell", forIndexPath: indexPath) as! CanvasCell
        let randomImage = "nature\(Int(arc4random_uniform(8) + 1)).jpg"
        
        cell.picture.image = UIImage(named: randomImage)
        cell.picture.layer.cornerRadius = 4.0
        cell.picture.layer.masksToBounds = true
        
        cell.label.text = randomImage
        cell.label.layer.shadowOpacity = 1
        cell.label.layer.shadowOffset = CGSizeZero
        cell.label.layer.masksToBounds = false
        cell.label.layer.shouldRasterize = true
        cell.label.layer.rasterizationScale = UIScreen.mainScreen().scale
        
        cell.contentView.frame = cell.bounds
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath)
    {
        (collectionView.cellForItemAtIndexPath(indexPath) as! CanvasCell).picture.alpha = 0.8
    }

    func collectionView(collectionView: UICollectionView, didUnhighlightItemAtIndexPath indexPath: NSIndexPath)
    {
        (collectionView.cellForItemAtIndexPath(indexPath) as! CanvasCell).picture.alpha = 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        //Default iPad Dimensions
        var size = CGSize(width: 360, height: 150)
        
        //Change to iPhone Dimensions
        if (UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone)
        {
            //height = CGFloat(90)
            size.width = (UIScreen.mainScreen().bounds.width - 20)
        }
        
        return size
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}

class CanvasCell : UICollectionViewCell
{
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var label: UILabel!
}
