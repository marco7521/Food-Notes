//
//  RestaurantTableViewController.swift
//  Food Notes
//
//  Created by admin on 2021/5/3.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    //Data
    var list = [Restaurant]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        tableView.cellLayoutMarginsFollowReadableWidth = true
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Configure navigation bar appearance
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        if let customFont = UIFont(name: "Rubik-Medium", size: 40.0) {
            navigationController?.navigationBar.largeTitleTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1.0), NSAttributedString.Key.font: customFont ]
        }
        navigationController?.hidesBarsOnSwipe = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        list = RestaurantDAO.shared.getAllRestaurants()
        tableView.reloadData()
        navigationController?.hidesBarsOnSwipe = true
    }
    
    func loadData(){
        list = RestaurantDAO.shared.getAllRestaurants()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RestaurantTableViewCell
        cell.nameLabel.text = list[indexPath.row].name
        cell.locationLabel.text = list[indexPath.row].address
        cell.typeLabel.text = list[indexPath.row].types
        if let photoData = list[indexPath.row].photo{
            cell.thumbnailImageView.image = UIImage(data: photoData)
        }
        //判斷是否為我的最愛
        cell.heartImageView.isHidden = list[indexPath.row].isfavorite == 1 ? false : true
        
        tableView.rowHeight = 80
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //Update memory
            let data = list.remove(at: indexPath.row)
            //update database
            RestaurantDAO.shared.delete(pid: data.pid)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    //客製化向左滑：刪除功能、分享功能
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //刪除功能
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            //Update memory
            let data = self.list.remove(at: indexPath.row)
            //update database
            RestaurantDAO.shared.delete(pid: data.pid)
            
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            
            // Call completion handler with true to indicate
            completionHandler(true)
        }
        
        //分享功能
        let shareAction = UIContextualAction(style: .normal, title: "Share") { (action, sourceView, completionHandler) in
            let defaultText = "Just checking in at " + self.list[indexPath.row].name
            
            let activityController: UIActivityViewController
            
            if let imageToShare = UIImage(data: self.list[indexPath.row].photo!) {
                activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
            } else  {
                activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            }
            
            if let popoverController = activityController.popoverPresentationController {
                if let cell = tableView.cellForRow(at: indexPath) {
                    popoverController.sourceView = cell
                    popoverController.sourceRect = cell.bounds
                }
            }
            
            self.present(activityController, animated: true, completion: nil)
            completionHandler(true)
        }
        
        // 客製化向左滑按鈕
        deleteAction.backgroundColor = UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0)
        deleteAction.image = UIImage(named: "delete")
        shareAction.backgroundColor = UIColor(red: 254.0/255.0, green: 149.0/255.0, blue: 38.0/255.0, alpha: 1.0)
        shareAction.image = UIImage(named: "share")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
        
        return swipeConfiguration
    }
    
    
    //客製化向右滑：我的最愛功能
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let isFavoriteAction = UIContextualAction(style: .normal, title: "Favorite") { (action, sourceView, completionHandler) in
            let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
            self.list[indexPath.row].isfavorite = (self.list[indexPath.row].isfavorite == 1) ? 0 : 1
            cell.heartImageView.isHidden = self.list[indexPath.row].isfavorite == 1 ? false : true
            
            //滑動或點選後，資料更新
            let dao = RestaurantDAO.shared
            dao.update(data: self.list[indexPath.row])
            
            completionHandler(true)
        }
        
        // 客製化向右滑按鈕
        isFavoriteAction.backgroundColor = UIColor(red: 39.0/255.0, green: 174.0/255.0, blue: 96.0/255.0, alpha: 1.0)
        isFavoriteAction.image = self.list[indexPath.row].isfavorite == 1 ? UIImage(named: "undo") : UIImage(named: "tick")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [isFavoriteAction])
        
        return swipeConfiguration
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let next = segue.destination as? RestaurantDetailViewController, let indexPath = tableView.indexPathForSelectedRow{
            let data = list[indexPath.row]
            next.restaurant = list[indexPath.row]
        }
        
//        if segue.identifier == "showRestaurantDetail" {
//            if let indexPath = tableView.indexPathForSelectedRow {
//                let next = segue.destination as! RestaurantDetailViewController
//                let data = list[indexPath.row]
//                next.pid = data.pid
//            }
//        }
    }
    

}