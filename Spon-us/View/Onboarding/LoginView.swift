//
//  LoginView.swift
//  Spon-us
//
//  Created by 박현수 on 1/25/24.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack(spacing: 0) {
            Image(.logoMain).resizable().frame(width: 159, height: 33).padding(.top, 91)
            Text("로그인하고 다양한 정보를 만나보세요").font(.Body10)
            Spacer()
        }
    }
}

#Preview {
    LoginView()
}
