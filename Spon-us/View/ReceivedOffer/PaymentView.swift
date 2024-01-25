//
//  PaymentView.swift
//  Spon-us
//
//  Created by 황인성 on 1/25/24.
//

import SwiftUI

struct PaymentView: View {
    var body: some View {
        ScrollView{
            LazyVStack(alignment: .leading, spacing: 0){
                HStack(spacing: 0){
                    Rectangle()
                        .frame(width: 79, height: 79)
                        .padding(.trailing, 28)
                    
                    // Korean/Body/Body07
                    Text("무신사 담당자 정보")
                        .font(.Body07)
                      .foregroundColor(Color.sponusBlack)
                    
                    
                }
                .padding(.bottom, 37)
                
                // Korean/Heading/Heading09
                Text("결제 항목")
                    .font(.Heading09)
                  .foregroundColor(.black)
                  .padding(.bottom, 16)
                
                SponUsDivider()
                    .padding(.bottom, 16)
                
                Rectangle()
                    .frame(width: 158, height: 56)
            }
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    PaymentView()
}
