//
//  PaymentView.swift
//  Spon-us
//
//  Created by 황인성 on 1/25/24.
//

import SwiftUI

struct PaymentView: View {
    
    var paymentBtnInActive = true
    
    var body: some View {
        VStack {
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
                    
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Rectangle()
                                .fill(Color.sponusGrey50)
                                .stroke(Color.sponusGrey100, lineWidth: 1)
                                .frame(width: 158, height: 56)
                                .overlay(
                                    Text("담당자 정보")
                                        .font(.Body10)
                                        .foregroundColor(Color.sponusBlack)
                                )
                            
                            Spacer()
                            
                            Rectangle()
                                .fill(Color.sponusGrey50)
                                .stroke(Color.sponusGrey100, lineWidth: 1)
                                .frame(width: 158, height: 56)
                                .overlay(
                                    Text("연락 가능 시간")
                                        .font(.Body10)
                                        .foregroundColor(Color.sponusBlack)
                                )
                        }
                        .padding(.bottom, 16)
                        
                        Rectangle()
                            .fill(Color.sponusGrey50)
                            .stroke(Color.sponusGrey100, lineWidth: 1)
                            .frame(width: 158, height: 56)
                            .overlay(
                                Text("선호 연락 방법")
                                    .font(.Body10)
                                    .foregroundColor(Color.sponusBlack)
                            )
                    }
                    .padding(.bottom, 32)
                    
                    Text("쿠폰 사용하기")
                        .font(.Heading09)
                        .foregroundColor(Color.sponusBlack)
                        .padding(.bottom, 16)
                    
                    SponUsDivider()
                        .padding(.bottom, 24)
                    
                    
                    Rectangle()
                        .fill(Color.sponusGrey50)
                        .stroke(Color.sponusGrey100, lineWidth: 1)
                        .frame(maxWidth: .infinity, minHeight: 56)
                        .overlay(
                            Text("사용 가능한 쿠폰이 없습니다")
                                .font(.Body10)
                                .foregroundColor(Color.sponusBlack)
                        )
                        .padding(.bottom, 32)
                    
                    Text("결제하기")
                        .font(.Heading09)
                        .foregroundColor(Color.sponusBlack)
                        .padding(.bottom, 16)
                    
                    SponUsDivider()
                        .padding(.bottom, 24)
                    
                    Rectangle()
                        .fill(Color.yellow)
                        .frame(maxWidth: .infinity, minHeight: 56)
                        .overlay(
                            Text("카카오페이")
                                .font(.Body06)
                                .foregroundColor(Color.sponusBlack)
                        )
                        .padding(.bottom, 64)
                    
                    SponUsDivider()
                        .padding(.bottom, 16)
                    
                    HStack{
                        
                        Text("결제금액")
                            .font(.Heading09)
                            .foregroundColor(Color.sponusBlack)
                        
                        Spacer()
                        
                        Text("1,400 원")
                            .font(
                                Font.custom("SUIT", size: 26)
                                    .weight(.bold)
                            )
                            .foregroundColor(Color.sponusBlack)
                    }
                    .padding(.bottom, 12)
                    
                    SponUsDivider()
                        .padding(.bottom, 24)
                    
                    HStack {
                        Text("서비스 이용료")
                            .font(.Body10)
                            .foregroundColor(Color.sponusGrey700)
                        
                        Spacer()
                        
                        Text("1400원")
                            .font(.Body10)
                            .foregroundColor(Color.sponusGrey700)
                    }
                    .padding(.bottom, 8)
                    
                    HStack {
                        Text("할인 금액")
                            .font(.Body10)
                            .foregroundColor(Color.sponusGrey700)
                        
                        Spacer()
                        
                        Text("0원")
                            .font(.Body10)
                            .foregroundColor(Color.sponusGrey700)
                    }
                    .padding(.bottom, 24)
                    
                    
                    Rectangle()
                        .fill(.clear)
                        .stroke(Color.sponusGrey100, lineWidth: 1)
                        .frame(maxWidth: .infinity, minHeight: 56)
                        .overlay(
                            
                            HStack(spacing: 0){
                                
                                Button(action: {
                                    
                                }, label: {
                                    Image("ic_check1")
                                })
                                .padding(.trailing, 12)
                                
                                
                                Text("결제 내용을 확인했으며 서비스 처리 방침에 동의합니다.")
                                    .font(.Caption04)
                                    .foregroundColor(Color.sponusBlack)
                            }
                        )
                        .padding(.bottom, 60)
                }
                .padding(.horizontal, 20)
            }
            
            Button(action: {
//                self.presentationMode.wrappedValue.dismiss()
//                popup = true
            }, label: {
                Text("수정완료")
                    .font(.Body01)
                    .foregroundColor(paymentBtnInActive ? Color.sponusGrey200 : Color.sponusPrimaryDarkmode)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 20)
                    .background(paymentBtnInActive ? Color.sponusGrey600 : Color.sponusBlack)
            })
            .disabled(paymentBtnInActive)
        }
        .navigationBarItems(leading: CustomBackButton())
        .navigationTitle("결제하기").font(.Body01)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    PaymentView()
}
