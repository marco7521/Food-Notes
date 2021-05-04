//
//  RestaurantDetailIconTextCell.swift
//  Food Notes
//
//  Created by admin on 2021/5/4.
//

import UIKit

class RestaurantDetailIconTextCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var shortTextLabel: UILabel!{
        didSet {
            //文字多行顯示
            shortTextLabel.numberOfLines = 0
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
