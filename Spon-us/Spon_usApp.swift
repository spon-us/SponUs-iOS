//
//  Spon_usApp.swift
//  Spon-us
//
//  Created by yubin on 1/2/24.
//

import SwiftUI

@main
struct Spon_usApp: App {
    
    @State var rootIsActive = true
    
    var body: some Scene {
        WindowGroup {
            OnBoardingView()
//            ContentView()
//            ChargerInfoViewTest(rootIsActive: $rootIsActive)
        }
    }
}
