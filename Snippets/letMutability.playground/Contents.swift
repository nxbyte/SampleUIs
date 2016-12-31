
/*
    Developer: Warren Seto
         File: letMutability.playground
      Purpose: A playground that shows two implementations of the same functional code. One uses let-mutability while the other uses regular sequential assignments
*/


import UIKit

func showLabel1 (_ text:String, presentingVC:UIViewController)
{
    let showLabel = UILabel(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
    
    showLabel.text = text
    
    showLabel.alpha = 1
    
    presentingVC.view.addSubview(showLabel)
    
    UIView.animate(withDuration: 5, animations: {
        showLabel.alpha = 0
    }, completion: {
        (flag) -> Void in showLabel.removeFromSuperview()
    })
}


func showLabel2 (_ text:String, presentingVC:UIViewController)
{
    let showLabel:UILabel = {
        $0.text = text
        $0.alpha = 1
        return $0
    } (UILabel(frame: CGRect(x: 100, y: 100, width: 100, height: 100)))
    
    presentingVC.view.addSubview(showLabel)
    
    UIView.animate(withDuration: 5, animations: {
        showLabel.alpha = 0
    }, completion: {
        (flag) -> Void in showLabel.removeFromSuperview()
    })
}
