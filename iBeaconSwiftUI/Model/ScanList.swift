//
//  ScanList.swift
//  iBeaconSwiftUI
//
//  Created by GENKIFUJIMOTO on 2022/12/05.
//

import Foundation
import RealmSwift

class ScanList: Object,Identifiable {
    
    @objc dynamic var UUID = ""
    @objc dynamic var addName = ""
    
    //　ユニークキーの設定 後から変更することができない。
    override static func primaryKey() -> String? {
        return "UUID"
    }
}

extension ScanList {
    private static var config = Realm.Configuration(schemaVersion: 1)
    private static var realm = try! Realm(configuration: config)
    
    static func findAll() -> Results<ScanList> {
        realm.objects(ScanList.self)
    }
    
    static func add(_ scanList: ScanList) {
        try! realm.write {
            // modified 一致したキーのデータを新しいオブジェクトで更新してくれる
            realm.add(scanList ,update: .modified)
        }
    }
    
    static func delete(_ scanList: ScanList) {
        try! realm.write {
            realm.delete(scanList)
        }
    }
    
    static func delete(_ scanLists: [ScanList]) {
        try! realm.write {
            realm.delete(scanLists)
        }
    }
}
