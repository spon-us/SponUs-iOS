//
//  ChargerInfoView.swift
//  Spon-us
//
//  Created by yubin on 1/22/24.
//

import SwiftUI

struct ChargerInfoView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var rootIsActive: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 0) {
                    HStack(alignment: .center) {
                        Image("musinsa")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 79, height: 79)
                            .clipped()
                        
                        VStack(spacing: 0) {
                            NavigationLink(destination: ProfileView(rootIsActive: $rootIsActive), label: {
                                HStack {
                                    Text("Profile")
                                        .font(.English15)
                                        .foregroundColor(Color.sponusPrimary)
                                    
                                    Image("ic_go_12px")
                                        .frame(width: 12, height: 12)
                                        .padding(.leading, -6)
                                }
                            })
                            .padding(.leading, 12)
                            .padding(.trailing, 7)
                            .padding(.vertical, 4)
                            .frame(width: 69, height: 26, alignment: .center)
                            .background(Color.sponusSecondary)
                            .cornerRadius(99)
                            
                            
                            Text("무신사 담당자")
                                .font(.Body07)
                                .foregroundColor(Color.sponusBlack)
                                .padding(.top, 11)
                                .padding(.leading, 16)
                        }
                    }
                    
                    Text("담당자 정보")
                        .font(.Heading09)
                        .foregroundColor(Color.sponusBlack)
                        .padding(.top, 32)
                    
                    Rectangle()
                        .fill(Color.sponusBlack)
                        .frame(maxWidth: .infinity, maxHeight: 1)
                        .padding(.top, 16)
                    
                    HStack {
                        Text("e-mail")
                            .font(.English08)
                            .foregroundColor(Color.sponusGrey800)
                        
                        Text("musinsa@gmail.com")
                            .font(.English08)
                            .foregroundColor(Color.sponusBlack)
                            .padding(.leading, 33)
                    }
                    .padding(.top, 20)
                    
                    Rectangle()
                        .fill(Color.sponusGrey100)
                        .frame(maxWidth: .infinity, maxHeight: 1)
                        .padding(.top, 16)
                    
                    HStack {
                        Text("phone")
                            .font(.English08)
                            .foregroundColor(Color.sponusGrey800)
                        
                        Text("010-1234-5678")
                            .font(.English08)
                            .foregroundColor(Color.sponusBlack)
                            .padding(.leading, 36)
                    }
                    .padding(.top, 16)
                    
                    Rectangle()
                        .fill(Color.sponusGrey100)
                        .frame(maxWidth: .infinity, maxHeight: 1)
                        .padding(.top, 16)
                    
                    Text("연락 가능 시간")
                        .font(.Heading09)
                        .foregroundColor(Color.sponusBlack)
                        .padding(.top, 32)
                    
                    Rectangle()
                        .fill(Color.sponusBlack)
                        .frame(maxWidth: .infinity, maxHeight: 1)
                        .padding(.top, 16)
                    
                    HStack {
                        Text("day")
                            .font(.English08)
                            .foregroundColor(Color.sponusGrey800)
                        
                        Text("월 - 금")
                            .font(.Body06)
                            .foregroundColor(Color.sponusBlack)
                            .padding(.leading, 54)
                    }
                    .padding(.top, 20)
                    
                    Rectangle()
                        .fill(Color.sponusGrey100)
                        .frame(maxWidth: .infinity, maxHeight: 1)
                        .padding(.top, 16)
                    
                    HStack {
                        Text("time")
                            .font(.English08)
                            .foregroundColor(Color.sponusGrey800)
                        
                        Text("14:00 - 18:00")
                            .font(.English08)
                            .foregroundColor(Color.sponusBlack)
                            .padding(.leading, 49)
                    }
                    .padding(.top, 16)
                    
                    Rectangle()
                        .fill(Color.sponusGrey100)
                        .frame(maxWidth: .infinity, maxHeight: 1)
                        .padding(.top, 16)
                    
                    Text("선호 연락 방법")
                        .font(.Heading09)
                        .foregroundColor(Color.sponusBlack)
                        .padding(.top, 32)
                    
                    Rectangle()
                        .fill(Color.sponusBlack)
                        .frame(maxWidth: .infinity, maxHeight: 1)
                        .padding(.top, 16)
                    
                    HStack {
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
                    .padding(.top, 20)
                    
                    Rectangle()
                        .fill(Color.sponusGrey100)
                        .frame(maxWidth: .infinity, maxHeight: 1)
                        .padding(.top, 16)
                    
                    Text("협업이 진행 중입니다")
                        .font(.Body03)
                        .foregroundColor(Color.sponusGrey900)
                        .frame(height: 56)
                        .frame(maxWidth: .infinity)
                        .background(Color.sponusGrey50)
                        .padding(.top, 22)
                        .padding(.bottom, 16)
                }
                .padding(.top, 16)
                .padding(.horizontal, 20)
            }
            
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
        .gesture(
            DragGesture().onEnded { value in
                if value.translation.width > 100 {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        )
        .navigationTitle("담당자 정보").font(.Body01)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton())
    }
}

#Preview {
    ChargerInfoView(rootIsActive: .constant(false))
}
