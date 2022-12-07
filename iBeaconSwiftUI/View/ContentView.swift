//
//  ContentView.swift
//  iBeaconSwiftUI
//
//  Created by GENKIFUJIMOTO on 2022/12/02.
//

import SwiftUI

struct ContentView: View {
    
    //①NavigationLinkをButton操作
    //変数用意
    @State var page : Int? = 0
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                Spacer().frame(height: 100)
                
                Text("iBeacon App")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .padding(.bottom, 50.0)
                
                //②NavigationLinkをButton操作
                //NavigationLinkの引数「tag」に値、引数「selection」に用意した変数のBindingを渡す
                NavigationLink(destination : ScanView(), tag: 1, selection: $page) {
                    EmptyView()
                }
                
                Button(action: {
                    //③NavigationLinkをButton操作
                    //用意した変数をNavigationLinkのtagの値にする
                    self.page = 1
                }) {
                    Text("スキャン")
                        .bold()
                        .frame(width: 200, height: 50)
                        .foregroundColor(Color.white)
                        .background(Color.purple)
                        .clipShape(Capsule())
                        .padding()
                }
                
                Spacer()
                
//                Button(action: {
//                    print("Button")
//                }) {
//                    Text("発信")
//                        .bold()
//                        .frame(width: 200, height: 50)
//                        .foregroundColor(Color.white)
//                        .background(Color.purple)
//                        .clipShape(Capsule())
//                }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice("iPhone SE (3rd generation)")
                .previewDisplayName("iPhone SE")
            ContentView()
                .previewDevice("iPhone 11")
                .previewDisplayName("iPhone 11")
        }
    }
}
