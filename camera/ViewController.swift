//
//  ViewController.swift
//  camera
//
//  Created by 原田摩利奈 on 2019/01/08.
//  Copyright © 2019 原田摩利奈. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,  UITextFieldDelegate  {
    
    // UserDefaults のインスタンス
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var showImageView: UIImageView!
    @IBOutlet weak var saveTextField: UITextField!

    
    @IBAction func button(_ sender: Any) {
        // アクションシートのタイトルとメッセージ
        let actionSheet = UIAlertController(title: "選択", message: "どちらか選択してください", preferredStyle: .actionSheet)
        
        // 選択肢と、選択肢ごとの処理
        // handlerで指定した処理が、ボタン押下時に行われる
        let saveTo1 = UIAlertAction(title: "カメラ", style: .default, handler: actionSheetCamera(sender:))
        let saveTo2 = UIAlertAction(title: "写真", style: .default, handler: actionSheetPhotLibruary(sender:))
        let cancel = UIAlertAction(title: "cancel", style: .cancel, handler: {
            (action: UIAlertAction) -> Void in
            print("キャンセルしました")
        })
        // アクションシートに、定義した選択肢を追加する
        actionSheet.addAction(saveTo1)
        actionSheet.addAction(saveTo2)
        actionSheet.addAction(cancel)
        
        // アクションシートを表示する
        present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        // Keyを指定して保存
        let str = saveTextField.text
        userDefaults.set(str, forKey: "DataStore")
        userDefaults.synchronize()
    }
    
    
    // アクションシートで選択した時の処理
    func actionSheetCamera(sender: UIAlertAction) {
        //インスタンス作成
        let pickerController = UIImagePickerController()
        
        //ソースタイプを指定(cameraの場合はplistでカメラ使用を許可すること)
        pickerController.sourceType = .camera
        
        //カメラを表示
        present(pickerController, animated: true, completion: nil)

    }
    func actionSheetPhotLibruary(sender: UIAlertAction) {
            let ipc = UIImagePickerController()
        ipc.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
        ipc.sourceType = UIImagePickerController.SourceType.photoLibrary
            //編集を可能にする
            ipc.allowsEditing = true
            self.present(ipc,animated: true, completion: nil)
    }
    
    
    
    //　撮影が完了時した時に呼ばれる
    func imagePickerController(_ imagePicker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        if let pickedImage = info[.originalImage]
            as? UIImage {
            showImageView.image = pickedImage
        }
        
        
        //閉じる処理
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // textFiel の情報を受け取るための delegate を設定
        saveTextField.delegate = self
        
        // デフォルト値
        userDefaults.register(defaults: ["DataStore": "default"])
    
        // Keyを指定して読み込み
        let str: String = userDefaults.object(forKey: "DataStore") as! String
        
        saveTextField.text = str
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        
        // キーボードを閉じる
        textField.resignFirstResponder()
        
        return true
    }
    
}

