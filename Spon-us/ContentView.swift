//
//  ContentView.swift
//  Spon-us
//
//  Created by yubin on 1/2/24.
//

import SwiftUI

import PhotosUI


struct ContentView: View {
    @State private var selectedTab: Int = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem({
                    Image(selectedTab == 0 ? "ic_home_check" : "ic_home")
                    Text("HOME")
                        .font(.English18)
                })
                .tag(0)
            
            SavedView()
                .tabItem {
                    Image(selectedTab == 1 ? "ic_saved_check" : "ic_saved")
                    Text("SAVED")
                        .font(.English18)
                }
                .tag(1)

            CategoryView()
                .tabItem {
                    Image(selectedTab == 2 ? "ic_discovery_check" : "ic_discovery")
                    Text("CATEGORY")
                        .font(.English18)
                }
                .tag(2)

            MyView(rootIsActive: .constant(false))
                .tabItem {
                    Image(selectedTab == 3 ? "ic_mypage_check" : "ic_mypage")
                    Text("MY")
                        .font(.English18)
                }
                .tag(3)
        }
    }
}

#Preview {
    ContentView()
}
