// Warren Seto
// ViewController.swift
// cells (UITableView)

// Images courtesy of pixabay.com

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        print("Click")
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("CanvasCell") as! CanvasCell
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
        
        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 10
    }
    
    func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath)
    {
        (tableView.cellForRowAtIndexPath(indexPath) as! CanvasCell).picture.alpha = 0.8
    }
    
    func tableView(tableView: UITableView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath)
    {
        (tableView.cellForRowAtIndexPath(indexPath) as! CanvasCell).picture.alpha = 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 150.0
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}

class CanvasCell : UITableViewCell
{
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var label: UILabel!
}

