//
//  TabBarView.swift
//  FoodTestApp
//
//  Created by Ульяна Гритчина on 30.06.2023.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Image("homeIcone")
                    Text("j")
                }
            
            Color.red
                .tabItem {
                    Label("Train", systemImage: "bolt.fill")
                }
             
            Color.blue
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
