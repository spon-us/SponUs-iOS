//
//  ChargerInfoViewTest.swift
//  Spon-us
//
//  Created by 황인성 on 2/5/24.
//

import SwiftUI

struct ChargerInfoViewTest: View {
    @Environment(\.presentationMode) var presentationMode
    @State var isPayment = false
    @Binding var rootIsActive: Bool
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        HStack(alignment: .center, spacing: 0) {
                            Image("post_list_dummy_image")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 79, height: 79)
                                .clipped()
                                .padding(.trailing, 12)
                            
                            VStack(alignment: .leading, spacing: 0) {
                                NavigationLink(destination: /*ProfileView(rootIsActive: $rootIsActive)*/Text("더미 만드세요!"), label: {
                                    HStack(spacing: 0) {
                                        Text("Profile")
                                            .font(.English15)
                                            .foregroundColor(Color.sponusPrimary)
                                        
                                        Image("ic_go_12px")
                                            .frame(width: 12, height: 12)
                                    }
                                    .padding(.leading, 12)
                                    .padding(.trailing, 7)
                                    .padding(.vertical, 4)
                                    .background(
                                        Rectangle()
                                            .fill(Color.sponusSecondary)
                                            .cornerRadius(99)
                                    )
                                })
                                .padding(.bottom, 11)
                                
                                
                                Text("스포너스 무신사 담당자")
                                    .font(.Body07)
                                    .foregroundColor(Color.sponusBlack)
                                    .padding(.leading, 6)
                                
                            }
                        }
                        .padding(.bottom, 32)
                        
                        Text("담당자 정보")
                            .font(.Heading09)
                            .foregroundColor(Color.sponusBlack)
                            .padding(.bottom, 16)
                        
                        SponUsDivider()
                            .padding(.bottom, 24)
                        
                        
                        VStack(alignment: .leading, spacing: 0) {
                            HStack(spacing: 0) {
                                Text("e-mail")
                                    .foregroundColor(Color.sponusGrey800)
                                    .frame(width: 88, alignment: .leading)
                                
                                Text("sponus@gmail.com")
                                    .foregroundColor(Color.sponusBlack)
                            }
                            .font(.English08)
                            .padding(.bottom, 16)
                            
                            SponUsDivider()
                                .foregroundColor(Color.sponusGrey100)
                                .padding(.bottom, 16)
                            
                            HStack(spacing: 0) {
                                Text("phone")
                                    .foregroundColor(Color.sponusGrey800)
                                    .frame(width: 88, alignment: .leading)
                                
                                Text("010-1234-5678")
                                    .foregroundColor(Color.sponusBlack)
                            }
                            .font(.English08)
                            .padding(.bottom, 16)
                            
                            SponUsDivider()
                                .foregroundColor(Color.sponusGrey100)
                        }
                        .blur(radius: isPayment == true ? 0.0 : 7.0)
                        .padding(.bottom, 32)
                        
                        
                        
                        Text("연락 가능 시간")
                            .font(.Heading09)
                            .foregroundColor(Color.sponusBlack)
                            .padding(.bottom, 16)
                        
                        SponUsDivider()
                            .padding(.bottom, 24)
                        
                        VStack(alignment: .leading, spacing: 0) {
                            HStack(spacing: 0) {
                                Text("day")
                                    .foregroundColor(Color.sponusGrey800)
                                    .frame(width: 88, alignment: .leading)
                                
                                Text("월 - 금")
                                    .foregroundColor(Color.sponusBlack)
                            }
                            .font(.English08)
                            .padding(.bottom, 16)
                            
                            SponUsDivider()
                                .foregroundColor(Color.sponusGrey100)
                                .padding(.bottom, 16)
                            
                            
                            HStack(spacing: 0) {
                                
                                Text("time")
                                    .font(.English08)
                                    .foregroundColor(Color.sponusGrey800)
                                    .frame(width: 88, alignment: .leading)
                                
                                Text("14:00 - 18:00")
                                    .font(.English08)
                                    .foregroundColor(Color.sponusBlack)
                            }
                            .padding(.bottom, 16)
                            
                            SponUsDivider()
                                .foregroundColor(Color.sponusGrey100)
                            
                        }
                        .blur(radius: isPayment == true ? 0.0 : 7.0)
                        .padding(.bottom, 32)
                        
                        Text("선호 연락 방법")
                            .font(.Heading09)
                            .foregroundColor(Color.sponusBlack)
                            .padding(.bottom, 16)
                        
                        SponUsDivider()
                            .padding(.bottom, 24)
                        
                        VStack(alignment: .leading, spacing: 0) {
                            HStack(spacing: 0) {
                                Text("contact")
                                    .font(.English08)
                                    .foregroundColor(Color.sponusGrey800)
                                
                                Text("이메일")
                                    .font(.Body06)
                                    .foregroundColor(Color.sponusBlack)
                                    .padding(.leading, 27)
                                
                                Text("전화")
                                    .font(.Body06)
                                    .foregroundColor(Color.sponusBlack)
                                    .padding(.leading, 4)
                            }
                            .padding(.bottom, 16)
                            
                            SponUsDivider()
                                .foregroundColor(Color.sponusGrey100)
                        }
                        .blur(radius: isPayment == true ? 0.0 : 7.0)
                        
                        
                        
                        //
                        //                    Text("협업이 진행 중입니다")
                        //                        .font(.Body03)
                        //                        .foregroundColor(Color.sponusGrey900)
                        //                        .frame(height: 56)
                        //                        .frame(maxWidth: .infinity)
                        //                        .background(Color.sponusGrey50)
                        //                        .padding(.top, 22)
                        //                        .padding(.bottom, 16)
                    }
                    .padding(.top, 16)
                    .padding(.horizontal, 20)
                }
                
                if isPayment == true {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("확인")
                            .font(.Body01)
                            .foregroundColor(Color.sponusPrimaryDarkmode)
                            .frame(maxWidth: .infinity)
                            .padding(.top, 20)
                            .background(Color.sponusBlack)
                    }
                }
                else {
                    HStack(spacing: 0) {
                        Button(action: {
                            
                        }, label: {
                            Text("거절하기")
                                .font(.Body01)
                                .foregroundColor(Color.sponusGrey800)
                                .frame(maxWidth: .infinity)
                                .padding(.top, 20)
                        })
                        
                        
                        
                        Rectangle()
                            .fill(Color.sponusGrey900)
                            .frame(width: 1, height: 17)
                            .padding(.top, 20)
                        
                        
                        //                    Button(action: {
                        //
                        //                    }, label: {
                        //                        Text("수락하기")
                        //                            .font(.Body01)
                        //                            .foregroundColor(Color.sponusPrimaryDarkmode)
                        //                            .frame(maxWidth: .infinity)
                        //                            .padding(.top, 20)
                        //                    })
                        
                        NavigationLink(destination: PaymentSettingView(isPayment: $isPayment), label: {
                            Text("수락하기")
                                .font(.Body01)
                                .foregroundColor(Color.sponusPrimaryDarkmode)
                                .frame(maxWidth: .infinity)
                                .padding(.top, 20)
                        })
                        
                        
                    }
                    .padding(.bottom, 20).background(Color.sponusBlack)
                }
                
                
                
            }
            .navigationTitle("담당자 정보").font(.Body01)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackButton())
        }
    }
}

//#Preview {
//    ChargerInfoViewTest()
//}
