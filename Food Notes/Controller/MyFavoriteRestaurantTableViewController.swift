//
//  MyFavoriteRestaurantTableViewController.swift
//  Food Notes
//
//  Created by admin on 2021/5/12.
//

import UIKit

class MyFavoriteRestaurantTableViewController: UITableViewController, UISearchResultsUpdating {
    
    //Data
    var restaurants = [Restaurant]()
    var searchResults: [Restaurant] = []
    
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        
        tableView.cellLayoutMarginsFollowReadableWidth = true
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // 設定navigation bar外觀
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        if let customFont = UIFont(name: "Rubik-Medium", size: 40.0) {
            navigationController?.navigationBar.largeTitleTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1.0), NSAttributedString.Key.font: customFont ]
        }
        navigationController?.hidesBarsOnSwipe = true
        
        // 增加 search bar
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "搜尋餐廳..."
        searchController.searchBar.barTintColor = .white
        searchController.searchBar.backgroundImage = UIImage()
        searchController.searchBar.tintColor = UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1.0) //search bar按鈕文字顏色
//        self.navigationItem.searchController = searchController
        tableView.tableHeaderView = searchController.searchBar //search bar放在tableView的tableHeaderView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
        tableView.reloadData()
        navigationController?.hidesBarsOnSwipe = true
    }
    
    func loadData(){
        restaurants = RestaurantDAO.shared.getRestaurantByMyFavorite()
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return searchResults.count
        } else {
            return restaurants.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyFavoriteCell", for: indexPath) as! MyFavoriteRestaurantTableViewCell

        //判斷是從搜尋結果或是原來陣列取得的餐廳
        let restaurant = (searchController.isActive) ? searchResults[indexPath.row] : restaurants[indexPath.row]
        
        cell.nameLabel.text = restaurant.name
        cell.locationLabel.text = restaurant.address
        cell.typeLabel.text = restaurant.types
        if let photoData = restaurant.photo{
            cell.thumbnailImageView.image = UIImage(data: photoData)
        }
        //判斷是否為我的最愛
        cell.heartImageView.isHidden = restaurant.isfavorite == 1 ? false : true
        
        tableView.rowHeight = 80
        
        return cell
    }


    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showRestaurantDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let nextController = segue.destination as! RestaurantDetailViewController
                nextController.pid = (searchController.isActive) ? searchResults[indexPath.row].pid : restaurants[indexPath.row].pid
                
                //跳至下一頁時 tab bar隱藏（也可在storyboard設定）
                nextController.hidesBottomBarWhenPushed = true
            }
        }
    }
    
    
    
    // MARK: - Helper methods
    
    func filterContent(for searchText: String) {
        searchResults = restaurants.filter({ (restaurant) -> Bool in
            let name = restaurant.name
            let address = restaurant.address
            let type = restaurant.types
            //可以搜尋餐廳名字或地址或類型
            let isMatch = name.localizedCaseInsensitiveContains(searchText) || address.localizedCaseInsensitiveContains(searchText) || type.localizedCaseInsensitiveContains(searchText)
            return isMatch
        })
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }
}
