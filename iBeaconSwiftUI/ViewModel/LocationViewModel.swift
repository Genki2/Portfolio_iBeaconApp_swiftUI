//
//  LocationViewModel.swift
//  iBeaconSwiftUI
//
//  Created by GENKIFUJIMOTO on 2022/12/06.
//

import Foundation
import CoreLocation

class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    //Published　変化があった際にViewに対して通知を行う役目
    @Published  var beaconArry:[CLBeacon] = []
    
    var getUUID: String = ""
    private let locationManager: CLLocationManager
    private var beaconRegion : CLBeaconRegion!
    
    override init() {
        
        locationManager = CLLocationManager()
        let authorizationStatus = locationManager.authorizationStatus
        
        super.init()
        locationManager.delegate = self
        
        // 位置情報の認証ステータスを取得
        switch authorizationStatus {
        case .notDetermined:
            // 位置情報の認証が許可されていない場合は認証ダイアログを表示
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("位置情報の使用が制限されています。")
        case .denied:
            print("位置情報を使用できません。")
        case .authorizedAlways, .authorizedWhenInUse:
            startMonitoring(scanUUID: getUUID)
        default:
            print("nexpected status")
        }
    }
    
    func startMonitoring(scanUUID:String){
        // ビーコン領域の初期化
        
        guard  !scanUUID.isEmpty else {
            return
        }
        
        let uuid:UUID? = UUID(uuidString: scanUUID)
        beaconRegion = CLBeaconRegion(uuid: uuid!, identifier: "BeaconApp")
        self.locationManager.startMonitoring(for: self.beaconRegion)
    }
    
    //===========================
    // locationManager デリゲート
    //===========================
    // 位置情報の認証ステータス変更
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if (status == .authorizedWhenInUse) {
            // ビーコン領域の観測を開始
            startMonitoring(scanUUID: getUUID)
        }
        
        if (status == .authorizedAlways) {
            // ビーコン領域の観測を開始
            startMonitoring(scanUUID: getUUID)
        }
    }
    
    
    //観測の開始に成功すると呼ばれる
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        //観測開始に成功したら、領域内にいるかどうかの判定をおこなう。→（didDetermineState）へ
        // ビーコン領域のステータスを取得
        self.locationManager.requestState(for: self.beaconRegion)
    }
    
    // ビーコン領域のステータスを取得
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for inRegion: CLRegion) {
        
        switch (state) {
        case .inside: // ビーコン領域内
            // ビーコンの測定を開始
            self.locationManager.startRangingBeacons(satisfying: self.beaconRegion.beaconIdentityConstraint)
            print("iBeacon inside")
            
            break
        case .outside: // ビーコン領域外
            print("iBeacon outside")
            break
            
        case .unknown: // 不明
            print("iBeacon unknown")
            break
        }
    }

    //領域内にいるので測定をする
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion){
        
        beaconArry = beacons
        print("確認\(beaconArry.count)")
        
        // update tableView
        
        /*
         beaconから取得できるデータ
         proximityUUID   :   regionの識別子
         major           :   識別子１
         minor           :   識別子２
         proximity       :   相対距離
         accuracy        :   精度
         rssi            :   電波強度
         
         timestamp:2022-04-15 00:52:16 +0000
         uuid:FDA50693-A4E2-4FB1-AFCF-C6EB07647825
         major:10065
         minor:26049
         proximity:immediate
         accuracy:0.03592646551894389
         rssi:-49
         */
        
        for beacon in beacons {
            
            print("uuid:\(beacon.uuid)")
            print("major:\(beacon.major)")
            print("minor:\(beacon.minor)")
            
            if (beacon.proximity == CLProximity.immediate) {
                //すぐそば
                print("proximity:immediate")
            }
            if (beacon.proximity == CLProximity.near) {
                //近く
                print("proximity:near")
            }
            if (beacon.proximity == CLProximity.far) {
                //遠い
                print("proximity:Far")
            }
            if (beacon.proximity == CLProximity.unknown) {
                //未検出
                print("proximity:unknown")
            }
            print("accuracy:\(beacon.accuracy)")
            print("rssi:\(beacon.rssi)")
            print("timestamp:\(beacon.timestamp)\n")
        }
    }
}
