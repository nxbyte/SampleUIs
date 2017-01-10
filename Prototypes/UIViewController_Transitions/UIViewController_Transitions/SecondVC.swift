
//  Developer: Warren Seto
//  Project: UIViewController_Transitions


import UIKit

class SecondVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Update the presented view controller with the size after the transition is done
        self.updatePreferredContentSizeWithTraitCollection(self.traitCollection)
    }
    
    
    @IBAction func closeVC(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        
        // Update the size of the presented view controller on rotation
        self.updatePreferredContentSizeWithTraitCollection(newCollection)
    }
    
    // Sets the size for the presented view controller for any orientation
    func updatePreferredContentSizeWithTraitCollection(_ traitCollection: UITraitCollection) {
        self.preferredContentSize = CGSize(width: self.view.bounds.size.width, height: traitCollection.verticalSizeClass == .compact ? 135 : 280)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

