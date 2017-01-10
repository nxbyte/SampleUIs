
//  Developer: Warren Seto
//  Project: UIViewController_Transitions


import UIKit

class SlideOverAnimationDelegate : NSObject, UIViewControllerAnimatedTransitioning {
    
    lazy var isPresenting: Bool = true
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.55
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)?.view,
            toView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)?.view
        
        var center:CGPoint?
        
        if isPresenting {
            center = toView!.center
            toView!.center = CGPoint(x: center!.x, y: toView!.bounds.size.height * 1.6)
            transitionContext.containerView.addSubview(toView!)
        } else {
            center = CGPoint(x: toView!.center.x, y: toView!.bounds.size.height + fromView!.bounds.size.height)
        }
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: isPresenting ? 10.0 : 0.0, options: [.allowUserInteraction, .beginFromCurrentState], animations: {
            
            if self.isPresenting {
                toView!.center = center!
                fromView!.transform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.91)
            } else {
                fromView!.center = center!
                toView!.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
                toView!.frame = UIApplication.shared.keyWindow!.frame
            }
        })
        { _ in
            
            if !self.isPresenting {
                fromView!.removeFromSuperview()
            }
            
            transitionContext.completeTransition(true)
        }
    }
}

class SlideOverTransitioningDelegate : NSObject, UIViewControllerTransitioningDelegate {

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return SlideOverPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController)-> UIViewControllerAnimatedTransitioning? {
        return SlideOverAnimationDelegate()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = SlideOverAnimationDelegate()
        animator.isPresenting = false
        
        return animator
    }
}

class SlideOverPresentationController: UIPresentationController {
    lazy var dimmingView = UIView()
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
    }
    
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        dimmingView.frame = containerView!.bounds
        dimmingView.alpha = 0.0
        containerView!.insertSubview(dimmingView, at: 0)
        
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: {
            _ in
            self.dimmingView.alpha = 1.0
        }, completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: {
            _ in
            self.dimmingView.alpha = 0.0
            }, completion: {
                _ in
                self.dimmingView.removeFromSuperview()
        })
    }
    
    // Currently Overlays in all orientations. Remove max(...) to make the presenting view full-screen
    override var frameOfPresentedViewInContainerView : CGRect {

        let bounds = containerView!.bounds,
            pixelHeight = max(UIApplication.shared.statusBarFrame.height * UIScreen.main.scale, 40)
        
        return CGRect(x: 0, y: pixelHeight, width: bounds.width, height: bounds.height - pixelHeight)
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        dimmingView.frame = containerView!.bounds
        presentedView!.frame = frameOfPresentedViewInContainerView
    }
}


class DismissSlideOverAnimator : NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.55
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
            else {
                return
        }
        
        let containerView = transitionContext.containerView
        
        containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
        
        let screenBounds = UIScreen.main.bounds
        let bottomLeftCorner = CGPoint(x: 0, y: screenBounds.height)
        let finalFrame = CGRect(origin: bottomLeftCorner, size: screenBounds.size)
        
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                fromVC.view.frame = finalFrame
            },
            completion: { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        )
    }
}
