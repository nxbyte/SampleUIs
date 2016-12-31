
//  Developer: Warren Seto
//  Project: UICollectionView Template


import UIKit

class ViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    /* Required for UICollectionView to work! (1) */
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // For the Collection View, I created a new cell object and a custom UICollectionViewCell in this project
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomItemIdentifier", for: indexPath) as! CustomItem
        
        /* For the Collection View, I populated each cell with an image and a String */
        item.imageView.image = UIImage(named: "\(indexPath.row % 6)")
        item.title.text = "Icon \(indexPath.row)"
        
        return item
    }
    
    /* Required for UICollectionView to work! (2) */
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // This value dictates the number of items that will be shown in the Collection View
        return 10
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

