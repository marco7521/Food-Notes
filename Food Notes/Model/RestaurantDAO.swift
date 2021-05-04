//
//  RestaurantDAO.swift
//  Food Notes
//
//  Created by admin on 2021/5/3.
//

import Foundation

class RestaurantDAO{
    let TABLE_NAME_RESTAURANT = "Restaurant"
    let TABLE_COLUMNNAME_PID = "pid"
    let TABLE_COLUMNNAME_NAME = "name"
    let TABLE_COLUMNNAME_TYPES = "types"
    let TABLE_COLUMNNAME_TEL = "tel"
    let TABLE_COLUMNNAME_ADDRESS = "address"
    let TABLE_COLUMNNAME_REMARKS = "remarks"
    let TABLE_COLUMNNAME_ISFAVORITE = "isfavorite"
    let TABLE_COLUMNNAME_PHOTO = "photo"
    private static var _inst = RestaurantDAO()
    public static var shared: RestaurantDAO{
        return _inst
    }
    
    var dbPath = ""
    //初始化邏輯
    private init() {
        dbPath = "\(NSHomeDirectory())/Documents/database.db"
        print(dbPath)
        let fileMgr = FileManager.default
        if let src = Bundle.main.path(forResource: "restaurantDATA", ofType: "db"){
            //檔案如果不存在就複製一份過去
            if !fileMgr.fileExists(atPath: dbPath){
                try?fileMgr.copyItem(atPath: src, toPath: dbPath)
            }
        }
    }
    
    //查詢全部
    func getAllRestaurants () -> [Restaurant]{
        var list = [Restaurant]()
        let db = FMDatabase(path: dbPath)
        db?.open()
        let sql = "SELECT * FROM \(TABLE_NAME_RESTAURANT)"
        if let result = db?.executeQuery(sql, withArgumentsIn: []){
            //如果有下一筆資料
            while result.next(){
                let pid = Int(result.int(forColumn: TABLE_COLUMNNAME_PID))//注意轉型，32位元轉Int
                let name = result.string(forColumn: TABLE_COLUMNNAME_NAME)
                let types = result.string(forColumn: TABLE_COLUMNNAME_TYPES)
                let tel = result.string(forColumn: TABLE_COLUMNNAME_TEL)
                let address = result.string(forColumn: TABLE_COLUMNNAME_ADDRESS)
                let remarks = result.string(forColumn: TABLE_COLUMNNAME_REMARKS)
                let isfavorite = Int(result.int(forColumn: TABLE_COLUMNNAME_ISFAVORITE))//注意轉型，32位元轉Int
                let photo = result.data(forColumn: TABLE_COLUMNNAME_PHOTO)
                list.append(Restaurant(pid: pid, name: name ?? "", types: types ?? "", tel: tel ?? "", address: address ?? "", remarks: remarks ?? "", isfavorite: isfavorite, photo: photo))
            }
            result.close()
        }
        db?.close()
        return list
    }
    
    //查詢單筆資料
    func getRestaurantByID(_ pid: Int) -> Restaurant? {
        var ret: Restaurant?
        let db = FMDatabase(path: dbPath)
        db?.open()
        let sql = "SELECT * FROM \(TABLE_NAME_RESTAURANT) WHERE \(TABLE_COLUMNNAME_PID) = ? "
        if let result = db?.executeQuery(sql, withArgumentsIn: [pid]){
            //如果有下一筆資料
            if result.next(){
                let pid = Int(result.int(forColumn: TABLE_COLUMNNAME_PID))//注意轉型，32位元轉Int
                let name = result.string(forColumn: TABLE_COLUMNNAME_NAME)
                let types = result.string(forColumn: TABLE_COLUMNNAME_TYPES)
                let tel = result.string(forColumn: TABLE_COLUMNNAME_TEL)
                let address = result.string(forColumn: TABLE_COLUMNNAME_ADDRESS)
                let remarks = result.string(forColumn: TABLE_COLUMNNAME_REMARKS)
                let isfavorite = Int(result.int(forColumn: TABLE_COLUMNNAME_ISFAVORITE))//注意轉型，32位元轉Int
                let photo = result.data(forColumn: TABLE_COLUMNNAME_PHOTO)
                ret = Restaurant(pid: pid, name: name ?? "", types: types ?? "", tel: tel ?? "", address: address ?? "", remarks: remarks ?? "", isfavorite: isfavorite, photo: photo)
            }
            result.close()
        }
        db?.close()
        return ret
    }
    
    //查詢myFavorite資料
    func getRestaurantByMyFavorite() -> [Restaurant] {
        var list = [Restaurant]()
        let db = FMDatabase(path: dbPath)
        db?.open()
        let sql = "SELECT * FROM \(TABLE_NAME_RESTAURANT) WHERE \(TABLE_COLUMNNAME_ISFAVORITE) = 1"
        if let result = db?.executeQuery(sql, withArgumentsIn: []){
            //如果有下一筆資料
            while result.next(){
                let pid = Int(result.int(forColumn: TABLE_COLUMNNAME_PID))//注意轉型，32位元轉Int
                let name = result.string(forColumn: TABLE_COLUMNNAME_NAME)
                let types = result.string(forColumn: TABLE_COLUMNNAME_TYPES)
                let tel = result.string(forColumn: TABLE_COLUMNNAME_TEL)
                let address = result.string(forColumn: TABLE_COLUMNNAME_ADDRESS)
                let remarks = result.string(forColumn: TABLE_COLUMNNAME_REMARKS)
                let isfavorite = Int(result.int(forColumn: TABLE_COLUMNNAME_ISFAVORITE))//注意轉型，32位元轉Int
                let photo = result.data(forColumn: TABLE_COLUMNNAME_PHOTO)
                list.append(Restaurant(pid: pid, name: name ?? "", types: types ?? "", tel: tel ?? "", address: address ?? "", remarks: remarks ?? "", isfavorite: isfavorite, photo: photo))
            }
            result.close()
        }
        db?.close()
        return list
    }
    
    //新增
    func insert(data: Restaurant){
        let db = FMDatabase(path: dbPath)
        db?.open()
        let sql = "INSERT INTO \(TABLE_NAME_RESTAURANT) (\(TABLE_COLUMNNAME_NAME),\(TABLE_COLUMNNAME_TYPES),\(TABLE_COLUMNNAME_TEL),\(TABLE_COLUMNNAME_ADDRESS),\(TABLE_COLUMNNAME_REMARKS),\(TABLE_COLUMNNAME_ISFAVORITE),\(TABLE_COLUMNNAME_PHOTO)) VALUES(?, ?, ?, ?, ?, ?, ?)"
        print("新增： \(sql)")
        db?.executeUpdate(sql, withArgumentsIn: [data.name, data.types, data.tel, data.address, data.remarks, data.isfavorite, data.photo])
        db?.close()
    }
    
    //刪除
    func delete(pid: Int){
        let db = FMDatabase(path: dbPath)
        db?.open()
        let sql = "DELETE FROM \(TABLE_NAME_RESTAURANT) WHERE pid = ?"
        print("刪除： \(sql)")
        db?.executeUpdate(sql, withArgumentsIn: [pid])
        db?.close()
    }
    
    //修改更新
    func update(data: Restaurant){
        let db = FMDatabase(path: dbPath)
        db?.open()
        let sql = "UPDATE \(TABLE_NAME_RESTAURANT) SET \(TABLE_COLUMNNAME_NAME)= ?,\(TABLE_COLUMNNAME_TYPES)=?,\(TABLE_COLUMNNAME_TEL)=?,\(TABLE_COLUMNNAME_ADDRESS)=?,\(TABLE_COLUMNNAME_REMARKS)=?,\(TABLE_COLUMNNAME_ISFAVORITE)=?,\(TABLE_COLUMNNAME_PHOTO)=? WHERE \(TABLE_COLUMNNAME_PID) = ?"
        print("更新： \(sql)")
        db?.executeUpdate(sql, withArgumentsIn: [data.name, data.types, data.tel, data.address, data.remarks, data.isfavorite, data.photo, data.pid])
        db?.close()
    }
}
