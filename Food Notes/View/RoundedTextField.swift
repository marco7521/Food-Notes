//
//  RoundedTextField.swift
//  Food Notes
//
//  Created by admin on 2021/5/5.
//

import UIKit

class RoundedTextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10);
    
    //此方法所回傳的繪製矩形是針對文字欄位的文字
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    //此方法所回傳的繪製矩形是針對文字欄位的佔位符文字
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    //此方法所回傳的矩形是用於顯示可編輯的文字
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    //每當文字欄位佈局時會呼叫此方法
    override func layoutSubviews() {
        super.layoutSubviews()

        //建立圓角
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = true
    }

}
