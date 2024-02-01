//
//  TermsAndConditionsView.swift
//  Spon-us
//
//  Created by 박현수 on 1/28/24.
//

import SwiftUI

struct TermsAndConditionsView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                Image(.termsConditions)
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
        }.navigationTitle("이용약관 동의")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackButton())
    }
}

#Preview {
    TermsAndConditionsView()
}
