//
//  MainView.swift
//  TestSwiftUI
//
//  Created by 柳宗青 on 2022/5/27.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView  {
            CreationView().tabItem {
                Image(systemName: "1.square.fill")
                Text("First")
            }
            
            Text("Another Tab").tabItem {
                Image(systemName: "2.square.fill")
                Text("Second")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
