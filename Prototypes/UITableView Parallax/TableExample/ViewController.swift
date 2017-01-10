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
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableview.dequeueReusableCell(withIdentifier: "UITableCell") as! UITableCell
        
        cell.title.text = "Cell \(indexPath.row)"
        cell.subtitle.text = "This is a parallex cell \(indexPath.row)"
        cell.IMAGE.image = UIImage(named: "nature\(Int(arc4random_uniform(8) + 1)).jpg")

        return cell
    }

    var last = CGFloat(0.0);
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    {
        if (scrollView.contentOffset.x < 0)
        {
            tableview.reloadSections(IndexSet(integer: 0), with: UITableViewRowAnimation.right)
        }
            
        else if (scrollView.contentOffset.x > 0)
        {
            tableview.reloadSections(IndexSet(integer: 0), with: UITableViewRowAnimation.left)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        for element in self.tableview.visibleCells as! [UITableCell]
        {
            element.parallax(tableview, view: self.view)
        }
    }

    override var preferredStatusBarStyle : UIStatusBarStyle { return UIStatusBarStyle.lightContent }
    
    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() }
}


class UITableCell : UITableViewCell
{
    @IBOutlet weak var IMAGE: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    
    func parallax (_ tableview:UITableView, view:UIView)
    {
        let rectInSuperview = tableview.convert(self.frame, to: view)
        
        let distanceFromCenter = view.frame.height/2 - rectInSuperview.minY;
        let difference = IMAGE.frame.height - self.frame.height;
        let move = (distanceFromCenter / view.frame.height) * difference;
        
        var imageRect = IMAGE.frame;
        imageRect.origin.y = -(difference/2)+move;
        IMAGE.frame = imageRect;
    }
}
