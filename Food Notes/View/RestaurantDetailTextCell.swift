//
//  RestaurantDetailTextCell.swift
//  Food Notes
//
//  Created by admin on 2021/5/4.
//

import UIKit

class RestaurantDetailTextCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            //文字多行顯示
            descriptionLabel.numberOfLines = 0
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
