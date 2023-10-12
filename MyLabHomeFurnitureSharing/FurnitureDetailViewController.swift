//
//  FurnitureDetailViewController.swift
//  MyLabHomeFurnitureSharing
//
//  Created by 曹家瑋 on 2023/10/12.
//

import UIKit

class FurnitureDetailViewController: UIViewController {
    
    // 家具相關
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var choosePhotoButton: UIButton!
    @IBOutlet weak var furnitureTitleLabel: UILabel!
    @IBOutlet weak var furnitureDescriptionLabel: UILabel!
    
    // 用於儲存傳入的 Furniture 資訊
    var furniture: Furniture?
    
    // 自訂的初始化方法，允許在初始化時指定一個 Furniture 物件
    init?(coder: NSCoder,furniture: Furniture? = nil) {
        self.furniture = furniture
        super.init(coder: coder)
    }
    
    // 由於覆寫了 init(coder:), 必須實現 required init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 當視圖控制器的視圖加載完成後會調用這個方法
    override func viewDidLoad() {
        super.viewDidLoad()

        // 更新視圖的內容
        updateView()
    }
    

    // 用戶點擊選擇照片按鈕後觸發
    @IBAction func choosePhotoButtonTapped(_ sender: UIButton) {
        // 創建 imagePicker
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        // alertController 來顯示 Action Sheet
        let alertController = UIAlertController(title: "選取照片來源", message: nil, preferredStyle: .actionSheet)
        
        // 添加取消操作到 alertController
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // 檢查相機是否可用，並添加相關操作
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "相機", style: .default) { action in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(cameraAction)
        }
        
        // 檢查照片庫是否可用，並添加相關操作
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "相簿", style: .default) { action in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(photoLibraryAction)
        }
        
        // 指定popover的來源視圖並呈現 alertController
        alertController.popoverPresentationController?.sourceView = sender
        present(alertController, animated: true, completion: nil)
    }
    
    // 用戶點擊分享按鈕後觸發
    @IBAction func actionButtonTapped(_ sender: UIBarButtonItem) {
        // 檢查家具是否存在
        guard let furniture = furniture else { return }
        
        // 創建要分享的項目列表：首先將家具的名稱和描述添加到items陣列中。
        var items: [Any] = ["\(furniture.name)： \(furniture.description)"]
        // 檢查photoImageView中是否有圖片，如果有，則將該圖片也添加到items陣列中。
        if let image = photoImageView.image {
            items.append(image)
        }
        
        // 創建並呈現UIActivityViewController
        let activityController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
    
    /// 更新視圖內容
    func updateView() {
        // 檢查 furniture 物件是否為 nil
        guard let furniture = furniture else { return }
        
        // 如果 furniture 有圖片資料，則將其顯示在圖片視圖上；否則，將圖片視圖的圖片設置為 nil
        if let imageData = furniture.imageData,
           let image = UIImage(data: imageData) {
            photoImageView.image = image
        } else {
            photoImageView.image = nil
        }
        
        // 更新Label的文字
        furnitureTitleLabel.text = furniture.name
        furnitureDescriptionLabel.text = furniture.description
    }
    
}

// 處理ImagePickerController的delegate
extension FurnitureDetailViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 從info字典中嘗試獲取使用者選擇的原始圖片
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        
        // 將圖片轉換為jpeg格式的Data對象，壓縮設置為0.9
        furniture?.imageData = selectedImage.jpegData(compressionQuality: 0.9)
        
        // 關閉圖片選擇器
        dismiss(animated: true) {
            self.updateView()
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // 用戶取消選擇時關閉圖片選擇器
        dismiss(animated: true, completion: nil)
    }
    
}
