//
//  RestaurantTableViewCell.swift
//  Food Notes
//
//  Created by admin on 2021/5/3.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!{
        didSet {
            //設定圖示為圓形
            thumbnailImageView.layer.cornerRadius = thumbnailImageView.bounds.width / 2
            thumbnailImageView.clipsToBounds = true //可在storyBoard設定
        }
    }
    @IBOutlet weak var heartImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
