//
//  ThirdPartyView.swift
//  Spon-us
//
//  Created by 박현수 on 1/28/24.
//

import SwiftUI

struct ThirdPartyView: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("개인정보 제 3자 처리 방침")
        }.navigationTitle("개인정보 제 3자 처리 방침")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackButton())
    }
}

#Preview {
    ThirdPartyView()
}
