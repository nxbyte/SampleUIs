
//  Developer: Warren Seto
//  Project: UIViewController_Transitions


import UIKit

class FirstVC: UIViewController {

    //
    let slideOverDelegate = SlideOverTransitioningDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func presentSlideOver(_ sender: Any) {
        
        // Make the instance of the View Controller to Transition to
        if let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SecondVC") {
            
            // Configure the transition from one view controller to the other
            nextVC.modalPresentationStyle = .custom
            nextVC.transitioningDelegate = slideOverDelegate
            
            self.present(nextVC, animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func presentSlideUp(_ sender: Any) {
        
        // Make the instance of the View Controller to Transition to
        if let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SecondVC") {
            
            // Configure the transition from one view controller to the other
            let presentationController = SlideUpTransition(presentedViewController: nextVC, presenting: self)
            nextVC.transitioningDelegate = presentationController
            
            self.present(nextVC, animated: true, completion: nil)
        }
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

