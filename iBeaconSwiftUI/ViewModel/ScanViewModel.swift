//
//  addUUIDViewModel.swift
//  iBeaconSwiftUI
//
//  Created by GENKIFUJIMOTO on 2022/12/05.
//

import Foundation
import SwiftUI
import RealmSwift

// ObservableObject 監視対象
class ScanViewModel:ObservableObject{
    
    // Model をもつ
    // @Published Modelに変更があったとき即座にViewを変更
    @Published var itemList: Results<ScanList> = ScanList.findAll()
    private var notificationTokens: [NotificationToken] = []

    //Relm利用
    let realm = try! Realm()
    
    //テキスト入力の値をRealmに保存
    func addUUID(addNameText:String,uuidText:String){
        let scanList:ScanList = ScanList()
        scanList.addName = addNameText
        scanList.UUID = uuidText
        ScanList.add(scanList)
    }
    
    init() {
        // DBに変更があったタイミングでitemEntitiesの変数に値を入れ直す
        notificationTokens.append (itemList.observe { change in
            switch change {
            case let .initial(results):
                self.itemList = results
                print("変更")
            case let .update(results, _, _, _):
                self.itemList = results
                print("アップデート")
            case let .error(error):
                print(error.localizedDescription)
                print("エラー")
            }
        })
    }
    
    deinit {
        notificationTokens.forEach { $0.invalidate() }
    }
}
