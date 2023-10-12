//
//  FurnitureTableViewController.swift
//  MyLabHomeFurnitureSharing
//
//  Created by 曹家瑋 on 2023/10/12.
//

import UIKit

class FurnitureTableViewController: UITableViewController {

    // cell id
    struct PropertyKeys {
        static let furnitureCell = "FurnitureCell"
    }
    
    // 初始化預設的房間和家具數據模型
    var rooms: [Room] = [
        Room(name: "客廳",
             furniture: [
                Furniture(name: "沙發", description: "一個舒適的休息地方。"),
                Furniture(name: "電視", description: "供所有人觀看的娛樂設備。"),
                Furniture(name: "茶几", description: "放飲料的好地方。")
             ]),
        Room(name: "廚房", furniture: [
            Furniture(name: "爐灶", description: "在這裡加熱和烹飪你的食物。"),
            Furniture(name: "烤箱", description: "為你的朋友們烘焙美味的點心。"),
            Furniture(name: "水槽", description: "別忘了清洗碗盤！")
        ]),
        Room(name: "臥室", furniture: [
            Furniture(name: "床", description: "夜間休息的地方。"),
            Furniture(name: "書桌", description: "學習，保持頭腦敏銳。"),
            Furniture(name: "衣櫃", description: "掛起你的衣物，保持它們不起皺。")
        ])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.cellLayoutMarginsFollowReadableWidth = true
    }

    // MARK: - Table view data source

    // 表格視圖的section數量
    override func numberOfSections(in tableView: UITableView) -> Int {
        return rooms.count
    }

    // 每個section的row
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms[section].furniture.count
    }

    // 配置每個cell的內容
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 使用可重用的單元格並配置其內容
        let cell = tableView.dequeueReusableCell(withIdentifier: PropertyKeys.furnitureCell, for: indexPath)
        
        // 根據 indexPath 獲取相應的 Room 和 Furniture 對象
        let room = rooms[indexPath.section]
        let furniture = room.furniture[indexPath.row]
        
        // 使用默認的單元格內容配置並賦值
        var content = cell.defaultContentConfiguration()
        content.text = furniture.name
        cell.contentConfiguration = content
        
        return cell
    }
    
    // 為每個section提供title
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // 直接使用 section 索引來從 rooms array 中取得標題
        return rooms[section].name
    }

    // 定義一個 segue action，當用戶選中一個 cell 時將觸發此動作
    @IBSegueAction func showFurnitureDetail(_ coder: NSCoder, sender: Any?) -> FurnitureDetailViewController? {
        
        // 確保 sender 是一個 cell 並且可以找到其在表格視圖中的位置
        guard let cell = sender as? UITableViewCell,
              let indexPath = tableView.indexPath(for: cell) else { return nil }
        
        // 獲取被選中的 Room 和 Furniture 對象
        let selectedRoom = rooms[indexPath.section]
        let selectedFurniture = selectedRoom.furniture[indexPath.row]
        
        // 使用初始化器創建並返回一個配置好的 FurnitureDetailViewController
        return FurnitureDetailViewController(coder: coder, furniture: selectedFurniture)
    }
    

    
}
