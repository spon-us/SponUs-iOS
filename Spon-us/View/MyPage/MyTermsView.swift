//
//  MyTermsView.swift
//  Spon-us
//
//  Created by yubin on 2/3/24.
//

import SwiftUI

struct PrivacyPolicyView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                Image("privacy_policy")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.top, 34)
                    .padding(.bottom, 110)
            }.padding(.horizontal, 20)
            
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("확인").font(.Body01).foregroundStyle(.sponusPrimaryDarkmode).frame(maxWidth: .infinity).padding(.top, 20)
            }.background(.sponusBlack)
        }
        .navigationTitle("개인정보처리방침")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton())
        .toolbar(.hidden, for: .tabBar)
    }
}

struct TermsConditionsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                Image("terms_conditions")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.top, 34)
                    .padding(.bottom, 110)
            }.padding(.horizontal, 20)
            
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("확인").font(.Body01).foregroundStyle(.sponusPrimaryDarkmode).frame(maxWidth: .infinity).padding(.top, 20)
            }.background(.sponusBlack)
        }
        .navigationTitle("이용약관")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton())
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    PrivacyPolicyView()
}

#Preview {
    TermsConditionsView()
}
