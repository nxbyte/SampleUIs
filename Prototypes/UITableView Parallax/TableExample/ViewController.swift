// Warren Seto
// ViewController.swift
// TableExample (Parallax UITableView)

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate
{
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableview.dequeueReusableCellWithIdentifier("UITableCell") as! UITableCell
        
        cell.title.text = "Cell \(indexPath.row)"
        cell.subtitle.text = "This is a parallex cell \(indexPath.row)"
        cell.IMAGE.image = UIImage(named: "nature\(Int(arc4random_uniform(8) + 1)).jpg")

        return cell
    }

    var last = CGFloat(0.0);
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool)
    {
        if (scrollView.contentOffset.x < 0)
        {
            tableview.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Right)
        }
            
        else if (scrollView.contentOffset.x > 0)
        {
            tableview.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Left)
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        for element in self.tableview.visibleCells as! [UITableCell]
        {
            element.parallax(tableview, view: self.view)
        }
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle { return UIStatusBarStyle.LightContent }
    
    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() }
}


class UITableCell : UITableViewCell
{
    @IBOutlet weak var IMAGE: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    
    func parallax (tableview:UITableView, view:UIView)
    {
        let rectInSuperview = tableview.convertRect(self.frame, toView: view)
        
        let distanceFromCenter = CGRectGetHeight(view.frame)/2 - CGRectGetMinY(rectInSuperview);
        let difference = CGRectGetHeight(IMAGE.frame) - CGRectGetHeight(self.frame);
        let move = (distanceFromCenter / CGRectGetHeight(view.frame)) * difference;
        
        var imageRect = IMAGE.frame;
        imageRect.origin.y = -(difference/2)+move;
        IMAGE.frame = imageRect;
    }
}