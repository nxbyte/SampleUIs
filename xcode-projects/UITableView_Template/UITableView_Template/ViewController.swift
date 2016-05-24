/*
    Author:      Warren Seto
    Source File: ViewController.swift
    Project:     UITableView_Template
*/

// Images courtesy of pixabay.com

import UIKit

class ViewController: UITableViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        print("Tapped")
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 10
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("TableCell") as! CanvasCell
        let randomImage = "nature\(Int(arc4random_uniform(8) + 1)).jpg"
        
        cell.picture.image = UIImage(named: randomImage)
        cell.caption.text = randomImage
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath)
    {
        (tableView.cellForRowAtIndexPath(indexPath) as! CanvasCell).picture.alpha = 0.8
    }
    
    override func tableView(tableView: UITableView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath)
    {
        (tableView.cellForRowAtIndexPath(indexPath) as! CanvasCell).picture.alpha = 1
    }
    
    /* Configures the size of each TableView Cell */
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 150.0
    }
    
    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() }
}

class CanvasCell : UITableViewCell
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
