//
//  LoginView.swift
//  Spon-us
//
//  Created by 박현수 on 1/25/24.
//

import SwiftUI

struct LoginView: View {
    @State var userID = ""
    @State private var userPW = ""
    
    var body: some View {
        VStack(spacing: 0) {
            Image(.logoMain).resizable().frame(width: 159, height: 33).padding(.top, 91)
            Text("로그인하고 다양한 정보를 만나보세요").font(.Body10).foregroundStyle(.sponusGrey700).padding(.top, 12)
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Text("이메일 주소").font(.Caption04)
                    Spacer()
                }.padding(.bottom, 8)
                TextField("ex) sponus@sponus.co.kr", text: $userID).padding(.bottom, 6)
                Divider().background(.sponusGrey200)
            }.padding(.horizontal, 20)
                .padding(.top, 50)
                .padding(.bottom, 28)
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Text("비밀번호").font(.Caption04)
                    Spacer()
                }.padding(.bottom, 8)
                SecureField("ex) sponus@sponus.co.kr", text: $userID).padding(.bottom, 6)
                Divider().background(.sponusGrey200)
            }.padding(.horizontal, 20)
            Spacer()
        }
    }
}

#Preview {
    LoginView()
}
