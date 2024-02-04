//
//  PaymentSettingView.swift
//  Spon-us
//
//  Created by 황인성 on 2/5/24.
//

import SwiftUI

struct PaymentSettingView: View {
    
    var paymentBtnInActive = true
    
    @StateObject var viewModel = PortOneViewModel()

    @State var buttonTag: Int? = nil

//    @State var paymentWebViewMode: PaymentWebViewModeView = PaymentWebViewModeView()
    
    @State var selectedPayment = ""
    
    @Binding var isPayment: Bool
    
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
                    
                    Button(action: {
                        selectedPayment = "tosspayments"
                        viewModel.testPay = selectedPayment
                        print(viewModel.testPay)
                    }, label: {
                        Rectangle()
                            .fill(Color.blue)
                            .frame(maxWidth: .infinity, minHeight: 56)
                            .overlay(
                                HStack {
                                    Text("토스페이먼츠")
                                        .font(.Body06)
                                    .foregroundColor(Color.sponusBlack)
                                    
                                    Image(selectedPayment == "tosspayments" ? "ic_check1_filled" : "ic_check1")
                                }
                            )
                    })
                    .padding(.bottom, 10)
                    
                    Button(action: {
                        selectedPayment = "kcp"
                        viewModel.testPay = selectedPayment
                        print(viewModel.testPay)
                    }, label: {
                        Rectangle()
                            .fill(Color.green)
                            .frame(maxWidth: .infinity, minHeight: 56)
                            .overlay(
                                HStack {
                                    Text("KCP")
                                        .font(.Body06)
                                    .foregroundColor(Color.sponusBlack)
                                    
                                    Image(selectedPayment == "kcp" ? "ic_check1_filled" : "ic_check1")
                                    
                                }
                            )
                    })
                    .padding(.bottom, 10)
                    
                    Button(action: {
                        selectedPayment = "kakaopay"
                        viewModel.testPay = selectedPayment
                        print(viewModel.testPay)
                    }, label: {
                        Rectangle()
                            .fill(Color.yellow)
                            .frame(maxWidth: .infinity, minHeight: 56)
                            .overlay(
                                HStack {
                                    Text("카카오페이")
                                        .font(.Body06)
                                    .foregroundColor(Color.sponusBlack)
                                    
                                    Image(selectedPayment == "kakaopay" ? "ic_check1_filled" : "ic_check1")
                                }
                            )
                    })
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
            
//            Button(action: {
////                self.presentationMode.wrappedValue.dismiss()
////                popup = true
//            }, label: {
//                Text("결제하기")
//                    .font(.Body01)
//                    .foregroundColor(paymentBtnInActive ? Color.sponusPrimaryDarkmode : Color.sponusGrey200)
//                    .frame(maxWidth: .infinity)
//                    .padding(.top, 20)
//                    .background(paymentBtnInActive ? Color.sponusBlack : Color.sponusGrey600)
//            })
//            .disabled(!paymentBtnInActive)
            
            buttonPayment()
                .disabled(selectedPayment == "")
        }
        .navigationBarItems(leading: CustomBackButton())
        .navigationTitle("결제하기").font(.Body01)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .actionSheet(isPresented: $viewModel.showResult) {
            ActionSheet(title: Text("결제 결과 도착~"),
                    message: Text("\(String(describing: viewModel.iamportResponse))"),
                        buttons: [.default(Text("닫기")){
//                print(viewModel.iamportResponse!.success!)
                if viewModel.iamportResponse!.success! == true {
                    isPayment = true
                }
            }])
        }
        
    }
    
    private func buttonPayment() -> some View {
        ZStack {
            
            
            Button(action: {
                viewModel.isPayment = true
                viewModel.updateMerchantUid()
            }, label: {
                Text("결제하기")
                    .font(.Body01)
                    .foregroundColor(paymentBtnInActive ? Color.sponusPrimaryDarkmode : Color.sponusGrey200)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 20)
                    .background(paymentBtnInActive ? Color.sponusBlack : Color.sponusGrey600)
            })
            .disabled(!paymentBtnInActive)
            .onBackgroundDisappear {
                viewModel.clearButton()
            }

            if viewModel.isPayment {
                // trick size & opacity
                PaymentView(viewModel: viewModel)
                        .frame(width: 0, height: 0).opacity(0)
            }
        }
    }
    
}
