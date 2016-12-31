
//  Developer: Warren Seto
//  Project: UITableView Template


import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    /* Required for UITableView to work! (1) */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // For the Table View, I created a new cell object and used the default UITableViewCell in this project
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCellIdentifier", for: indexPath)
        
        /* For the Table View, I populated each cell with an image and a String */
        cell.imageView?.image = UIImage(named: "\(indexPath.row % 6)")
        cell.textLabel?.text = "Icon \(indexPath.row)"
        
        return cell
    }

    /* Required for UITableView to work! (2) */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // This value dictates the number of cells that will be shown in the Table View
        return 10
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

