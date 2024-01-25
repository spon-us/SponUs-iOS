//
//  OnBoardingView.swift
//  Spon-us
//
//  Created by 박현수 on 1/25/24.
//

import SwiftUI

struct OnBoardingView: View {
    @State var isPresented = false
    
    var body: some View {
        VStack(spacing: 0) {
            Image(.logoMainWhite).resizable().frame(width: 159, height:33).padding(.top, 136)
            Spacer()
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("기업과 대학생이").font(.system(size: 26)).padding(.vertical, 7)
                    Text("만나는 자리,").font(.system(size: 26)).padding(.vertical, 7)
                    Text("회원님 환영합니다").font(.system(size: 26)).bold().padding(.vertical, 7)
                }.padding(.leading, 20).foregroundStyle(.white)
                Spacer()
            }.padding(.bottom, 40)
            Button {
                isPresented = true
            } label: {
                Text("시작하기")
                    .font(.Body04).foregroundStyle(.sponusWhite)
                    .frame(maxWidth: .infinity).frame(height: 56)
                    .background(.sponusPrimary)
                    .padding(.horizontal, 20)
            }.padding(.bottom, 90)

        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image(.onBoardingBg).resizable().scaledToFill())
            .edgesIgnoringSafeArea(.vertical)
            .fullScreenCover(isPresented: $isPresented) {
                LoginView()
            }
    }
}

#Preview {
    OnBoardingView()
}
