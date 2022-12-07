//
//  ScanResultView.swift
//  iBeaconSwiftUI
//
//  Created by GENKIFUJIMOTO on 2022/12/02.
//

import SwiftUI
import CoreLocation

struct ScanResultView: View {
    
    @StateObject var locationViewModel = LocationViewModel()
    
    //StateObject
    //View内でViewModelを保持する場合は@StateObjectを使用すべきである
    
    //ObservedObject
    //親Viewから渡されるデータを参照するのみの場合は、再描画による初期化の影響を受けないので@ObservedObjectを使えばよい
    
    //データ受け取り変数
    var scanName:String
    var UUID:String
    
    var body: some View {
        
        List {
            //ビーコン空か確認
            if !locationViewModel.beaconArry.isEmpty{
                ForEach(locationViewModel.beaconArry,id:\.self) { index in
                    //Cellのビューを作成
                    ScanResultCell(major: "\(index.major)", miner: "\(index.minor)", rssi: "\(index.rssi)", proximity: "\(index.proximity.rawValue)",UUID: "\(UUID)")
                }
            }
        }.onViewWillAppear {
            //view表示後にUUIDを送る
            sendUUID(UUID: UUID)
        }
        .navigationTitle("スキャン結果")
        //Listの表示スタイルを明示的に設定し、iOS13に合わせる方法
        .listStyle(PlainListStyle())
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func sendUUID(UUID:String){
        print("\(UUID)")
        locationViewModel.getUUID = UUID
    }
}


