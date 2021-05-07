//
//  WalkthroughPageViewController.swift
//  Food Notes
//
//  Created by admin on 2021/5/7.
//

import UIKit

protocol WalkthroughPageViewControllerDelegate: class {
    func didUpdatePageIndex(currentIndex: Int)
}

class WalkthroughPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var pageHeadings = ["建立您自己的餐廳名單", "顯示您的位置", "發現很棒的餐廳"]
    var pageImages = ["onboarding-1", "onboarding-2", "onboarding-3"]
    var pageSubHeadings = ["建立您最喜歡的餐廳並創建自己的美食指南",
                           "在地圖上搜索並找到您最喜歡的餐廳",
                           "和朋友共享您找到的餐廳"]
    
    var currentIndex = 0
    
    weak var walkthroughDelegate: WalkthroughPageViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // 將dataSource、delegate設定為自己
        dataSource = self
        delegate = self
        
        // 建立第一個導覽畫面
        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    
    // MARK: - UIPageViewControllerDataSource methods
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! WalkthroughContentViewController).index
        index -= 1
        
        return contentViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! WalkthroughContentViewController).index
        index += 1
        
        return contentViewController(at: index)
    }
    
    
    
    // MARK: - UIPageViewControllerDelegate method
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed {
            if let contentViewController = pageViewController.viewControllers?.first as? WalkthroughContentViewController {
                print("Content view controller index: \(contentViewController.index)")
                
                currentIndex = contentViewController.index
                
                walkthroughDelegate?.didUpdatePageIndex(currentIndex: contentViewController.index)
            }
            
        }
    }
    
    
    // MARK: - Helper methods
    
    func contentViewController(at index: Int) -> WalkthroughContentViewController? {
        if index < 0 || index >= pageHeadings.count {
            return nil
        }
        
        // 建立新的view controller並傳遞合適的資料
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        if let pageContentViewController = storyboard.instantiateViewController(withIdentifier: "WalkthroughContentViewController") as? WalkthroughContentViewController {
            
            pageContentViewController.imageFile = pageImages[index]
            pageContentViewController.heading = pageHeadings[index]
            pageContentViewController.subHeading = pageSubHeadings[index]
            pageContentViewController.index = index
            
            return pageContentViewController
        }
        
        return nil
    }
    
    func forwardPage() {
        currentIndex += 1
        if let nextViewController = contentViewController(at: currentIndex) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }
}
