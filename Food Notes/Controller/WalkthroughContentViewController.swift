//
//  WalkthroughContentViewController.swift
//  Food Notes
//
//  Created by admin on 2021/5/7.
//

import UIKit

class WalkthroughContentViewController: UIViewController {
    
    @IBOutlet weak var headingLabel: UILabel!{
        didSet {
            headingLabel.numberOfLines = 0
        }
    }
    @IBOutlet weak var subHeadingLabel: UILabel!{
        didSet {
            subHeadingLabel.numberOfLines = 0
        }
    }
    @IBOutlet weak var contentImageView: UIImageView!
    
    var index = 0
    var heading = ""
    var subHeading = ""
    var imageFile = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headingLabel.text = heading
        subHeadingLabel.text = subHeading
        contentImageView.image = UIImage(named: imageFile)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
