//
//  ContentView.swift
//  Spon-us
//
//  Created by yubin on 1/2/24.
//

import SwiftUI

struct ContentView: View {
    @State var isPresented = false
    @State private var progressStatus = Portfolio.ProgressStatus()

    var body: some View {
        VStack {
            Button { self.isPresented.toggle() }
            label: {
                HStack {
                    Image(.btnMove)
                    Text("포트폴리오")
                }
            }
            .fullScreenCover(isPresented: $isPresented, content: { Portfolio(progressStatus: progressStatus) })
        }
        .padding()
    }
}

//#Preview {
//    ContentView()
//}
