//
//  ScanCellView.swift
//  iBeaconSwiftUI
//
//  Created by GENKIFUJIMOTO on 2022/12/02.
//

import SwiftUI

struct ScanCellView: View {
    
    let scanName: String
    let UUID: String
    
    var body: some View {
        
        //左よせ　.leading
        //右よせ　.trailing
        VStack (alignment: .leading) {
            
            //上寄せ　.top
            //下寄せ　.bottom
            HStack {
                Text("登録名:\(scanName)")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.orange)
            }
            
            HStack {
                Text("UUID:\(UUID)")
                    .font(.caption2)
                    .fontWeight(.medium)
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

struct ScanCellView_Previews: PreviewProvider {
    static var previews: some View {
        ScanCellView(scanName: "ビーコン", UUID: "XXXXXx-xxxxx-xxxxx")
    }
}
