//
//  ScanView.swift
//  iBeaconSwiftUI
//
//  Created by GENKIFUJIMOTO on 2022/12/02.
//

import SwiftUI

struct ScanView: View {
    
    @State private var isShowing = false
    @ObservedObject var scanVM = ScanViewModel()
    
    //SwiftUIでType ‘()’ cannot conform to ‘View’;
    //Viewの中にSwiftのコードは書けない
    
    //ContentViewでNavigationLink使用
    var body: some View {
        
        List {
            ForEach(scanVM.itemList) { index in
                
                if index.isInvalidated {
                    EmptyView()
                } else {
                    NavigationLink(destination: ScanResultView(scanName: index.addName, UUID: index.UUID)) {
                        ScanCellView(scanName: index.addName, UUID:index.UUID)
                    }
                }
            }
        }
        .navigationTitle("スキャンリスト")
        //Listの表示スタイルを明示的に設定し、iOS13に合わせる方法
        .listStyle(PlainListStyle())
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            trailing: Button(action: {
                isShowing = true
            }) {
                Text("追加")
            }
            //フルスクリーン　モーダル遷移
                .fullScreenCover(isPresented: $isShowing) {
                    AddScanUUIDView()
                    //.environmentObject(ScanViewModel())
                })
    }
}


struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView()
            .previewDevice("iPhone SE (3rd generation)")
            .previewDisplayName("iPhone SE")
    }
}
