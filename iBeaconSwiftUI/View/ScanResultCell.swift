//
//  ScanResultCell.swift
//  iBeaconSwiftUI
//
//  Created by GENKIFUJIMOTO on 2022/12/02.
//

import SwiftUI

struct ScanResultCell: View {
    
    let major: String
    let miner: String
    let rssi: String
    let proximity: String
    let UUID: String
    
    var body: some View {
        
        //左よせ　.leading
        //右よせ　.trailing
        VStack (alignment: .leading,spacing: 3) {
            
            //上寄せ　.top
            //下寄せ　.bottom
            HStack {
                Text("Major:\(major)")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.black)
                
                Text("Miner:\(miner)")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.black)
            }
            
            HStack {
                Text("RSSI:\(rssi)")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.red)
                    .multilineTextAlignment(.center)
                
                Text("proximity:\(proximity)")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.red)
                    .multilineTextAlignment(.center)
            }
            
            HStack {
                Text("UUID:\(UUID)")
                    .font(.caption2)
                    .fontWeight(.medium)
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.leading)
            }
            
        }
    }
}

struct ScanResultCell_Previews: PreviewProvider {
    static var previews: some View {
        ScanResultCell(major: "0", miner: "4155", rssi: "-20", proximity: "近く",UUID: "xxx-xxx-xxx-xx-xxxx")
    }
}
