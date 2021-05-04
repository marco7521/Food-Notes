//
//  RestaurantDetailHeaderView.swift
//  Food Notes
//
//  Created by admin on 2021/5/3.
//

import UIKit

class RestaurantDetailHeaderView: UIView {

    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.numberOfLines = 0
        }
    }
    @IBOutlet var typeLabel: UILabel! {
        didSet {
            //設定標籤圓角效果
            typeLabel.layer.cornerRadius = 5.0
            typeLabel.layer.masksToBounds = true
        }
    }
    @IBOutlet var heartImageView: UIImageView! {
        didSet {
            //設定圖片為板模範本(也可至assets目錄，至屬性檢閱器設定該圖片Render as 為 Template image)
            heartImageView.image = UIImage(named: "heart-tick")?.withRenderingMode(.alwaysTemplate)
            heartImageView.tintColor = .white
        }
    }
}
