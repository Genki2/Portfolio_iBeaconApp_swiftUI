//
//  AddScanUUIDView.swift
//  iBeaconSwiftUI
//
//  Created by GENKIFUJIMOTO on 2022/12/04.
//

import SwiftUI
import RealmSwift

struct AddScanUUIDView: View {
    
    @State private var name = ""
    @State private var UUID = ""
    
    var scanVM = ScanViewModel()
    
    //①モーダルを画面を閉じる
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        
            VStack {
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }){
                    Text("閉じる")
                        .padding([.top, .leading], 10.0)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Spacer().frame(height: 100)
                
                TextField("登録名", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                TextField("UUID", text: $UUID)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Button(action:{
                    //名前とUUID追加する
                    scanVM.addUUID(addNameText: name, uuidText: UUID)
                    
                    //②モーダルを画面を閉じる
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("追加")
                        .bold()
                        .frame(width: 100, height: 50)
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                        .clipShape(Capsule())
                        .padding()
                }
                Spacer()
            }
    }
}

struct AddScanUUIDView_Previews: PreviewProvider {
    static var previews: some View {
        AddScanUUIDView()
            //.environmentObject(ScanViewModel())
    }
}
