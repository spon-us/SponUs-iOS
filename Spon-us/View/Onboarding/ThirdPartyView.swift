//
//  ThirdPartyView.swift
//  Spon-us
//
//  Created by 박현수 on 1/28/24.
//

import SwiftUI

struct ThirdPartyView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                Image(.thirdParty)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.top, 34)
                    .padding(.bottom, 110)
                
                    
                    
//                    Text("제5조(개인정보의 제3자 제공)").font(.Body05).padding(.top, 34)
//                    Text("회사는 개인정보보호법에 근거하여 다음과 같은 내용으로 개인정보를 제3자에게 제공하고자 합니다..").lineSpacing(3).font(.Body10).foregroundStyle(.sponusGrey800).padding(.top, 12)
//                    HStack(spacing: 0) {
//                        VStack(spacing: 0) {
//                            Text("1. ").lineSpacing(3).font(.Body10).foregroundStyle(.sponusGrey800)
//                            Spacer()
//                        }.frame(width: 20)
//                        Text("개인정보를 제공 받는 제3자 : 본 서비스를 이용하는 타 이용자").lineSpacing(3).font(.Body10).foregroundStyle(.sponusGrey800)
//                    }.padding(.top, 12)
//                    HStack(spacing: 0) {
//                        VStack(spacing: 0) {
//                            Text("2. ").lineSpacing(3).font(.Body10).foregroundStyle(.sponusGrey800)
//                        }.frame(width: 20)
//                        Text("개인정보 제공 목적 : 서비스 이용").lineSpacing(3).font(.Body10).foregroundStyle(.sponusGrey800)
//                    }.padding(.top, 6)
//                    HStack(spacing: 0) {
//                        VStack(spacing: 0) {
//                            Text("3. ").lineSpacing(3).font(.Body10).foregroundStyle(.sponusGrey800)
//                            
//                        }.frame(width: 20)
//                        Text("개인정보 제공 항목 : 성명, 전화번호, 이메일").lineSpacing(3).font(.Body10).foregroundStyle(.sponusGrey800)
//                    }.padding(.top, 6)
//                    HStack(spacing: 0) {
//                        VStack(spacing: 0) {
//                            Text("4. ").lineSpacing(3).font(.Body10).foregroundStyle(.sponusGrey800)
//                            Spacer()
//                        }.frame(width: 20)
//                        Text("개인정보 보유 및 이용기간 : 개인정보 제공 목적 달성일까지").lineSpacing(3).font(.Body10).foregroundStyle(.sponusGrey800)
//                    }.padding(.top, 6)
//                    HStack(spacing: 0) {
//                        VStack(spacing: 0) {
//                            Text("5. ").lineSpacing(3).font(.Body10).foregroundStyle(.sponusGrey800)
//                            
//                        }.frame(width: 20)
//                        Text("개인정보 제공 거부 시 불이익 : 서비스 이용 제한").lineSpacing(3).font(.Body10).foregroundStyle(.sponusGrey800)
//                    }.padding(.top, 6)
//                        
//                    Text("2024년 01월 23일").lineSpacing(3).font(.Body10).foregroundStyle(.sponusGrey800).padding(.top, 6).padding(.bottom, 110)
                
            }.padding(.horizontal, 20)
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("확인").font(.Body01).foregroundStyle(.sponusPrimaryDarkmode).frame(maxWidth: .infinity).padding(.top, 20)
            }.background(.sponusBlack)
        }.navigationTitle("개인정보 제 3자 처리 방침")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackButton())
    }
}

#Preview {
    ThirdPartyView()
}
