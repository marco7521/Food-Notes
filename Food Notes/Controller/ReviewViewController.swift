//
//  ReviewViewController.swift
//  Food Notes
//
//  Created by admin on 2021/5/5.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet var rateButtons: [UIButton]!
    
    @IBOutlet weak var closeButton: UIButton!
    var restaurant = Restaurant()

    override func viewDidLoad() {
        super.viewDidLoad()

        //設定背景圖
        if let dataPhoto = restaurant.photo{
            backgroundImageView.image = UIImage(data: dataPhoto)
        }
        
        // 背景圖模糊效果
        let blurEffect = UIBlurEffect(style: .dark) //.dark  .light  .extraLight
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        // 建立將視圖移動至畫面右側600點的漸變變形
        let moveRightTransform = CGAffineTransform.init(translationX: 600, y: 0)
        let scaleUpTransform = CGAffineTransform.init(scaleX: 5.0, y: 5.0)
        let moveScaleTransform = scaleUpTransform.concatenating(moveRightTransform)
        
        // 使按鈕隱藏並移至畫面外
        for rateButton in rateButtons {
            rateButton.transform = moveScaleTransform
            rateButton.alpha = 0
        }
        
        // 建立將視圖移動至畫面上方800點的漸變變形
        let moveUpTransform = CGAffineTransform.init(translationX: 0, y: -800)
        closeButton.transform = moveUpTransform
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //設定rateButtons按鈕動畫效果(使用迴圈)
        for index in 0...rateButtons.count - 1 {
            UIView.animate(withDuration: 0.4, delay: 0.1 + 0.05 * Double(index), options: [], animations: {
                self.rateButtons[index].alpha = 1.0
                self.rateButtons[index].transform = .identity//重設按鈕原來的位置
            }, completion: nil)
        }
        /*
        UIView.animate(withDuration: 0.4, delay: 0.1, options: [], animations: {
            self.rateButtons[0].alpha = 1.0
            self.rateButtons[0].transform = .identity //重設按鈕原來的位置
        }, completion: nil)

        UIView.animate(withDuration: 0.4, delay: 0.15, options: [], animations: {
            self.rateButtons[1].alpha = 1.0
            self.rateButtons[1].transform = .identity //重設按鈕原來的位置
        }, completion: nil)

        UIView.animate(withDuration: 0.4, delay: 0.2, options: [], animations: {
            self.rateButtons[2].alpha = 1.0
            self.rateButtons[2].transform = .identity //重設按鈕原來的位置
        }, completion: nil)

        UIView.animate(withDuration: 0.4, delay: 0.25, options: [], animations: {
            self.rateButtons[3].alpha = 1.0
            self.rateButtons[3].transform = .identity //重設按鈕原來的位置
        }, completion: nil)

        UIView.animate(withDuration: 0.4, delay: 0.3, options: [], animations: {
            self.rateButtons[4].alpha = 1.0
            self.rateButtons[4].transform = .identity //重設按鈕原來的位置
        }, completion: nil)
        */
        
        //設定closeButton按鈕動畫效果
        UIView.animate(withDuration: 0.3, delay: 0.5, options: [], animations: {
            self.closeButton.transform = .identity //重設按鈕原來的位置
        }, completion: nil)
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
