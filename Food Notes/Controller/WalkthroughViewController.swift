//
//  WalkthroughViewController.swift
//  Food Notes
//
//  Created by admin on 2021/5/7.
//

import UIKit

class WalkthroughViewController: UIViewController, WalkthroughPageViewControllerDelegate {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!{
        didSet {
            nextButton.layer.cornerRadius = 25.0
            nextButton.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var skipButton: UIButton!
    
    
    var walkthroughPageViewController: WalkthroughPageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - Action methods

    @IBAction func skipButtonTapped(sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButtonTapped(sender: UIButton) {
        
        if let index = walkthroughPageViewController?.currentIndex {
            switch index {
            case 0...1:
                walkthroughPageViewController?.forwardPage()
                
            case 2:
                UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
                dismiss(animated: true, completion: nil)
                
            default: break
                
            }
        }
        
        updateUI()
    }
    
    func updateUI() {
        // Update UI buttons
        if let index = walkthroughPageViewController?.currentIndex {
            switch index {
            case 0...1:
                nextButton.setTitle("下一頁", for: .normal)
                skipButton.isHidden = false
            case 2:
                nextButton.setTitle("開始", for: .normal)
                skipButton.isHidden = true
            default: break
            }
            
            pageControl.currentPage = index
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let pageViewController = destination as? WalkthroughPageViewController {
            walkthroughPageViewController = pageViewController
            walkthroughPageViewController?.walkthroughDelegate = self
        }
    }
    
    func didUpdatePageIndex(currentIndex: Int) {
        updateUI()
    }
}
