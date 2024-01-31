//
//  GatherAndUsageView.swift
//  Spon-us
//
//  Created by 박현수 on 1/28/24.
//

import SwiftUI

struct GatherAndUsageView: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("개인정보 수집 및 이용 동의")
        }.navigationTitle("개인정보 수집 및 이용 동의")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackButton())
    }
}

#Preview {
    GatherAndUsageView()
}
