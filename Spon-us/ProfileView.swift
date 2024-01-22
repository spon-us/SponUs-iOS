//
//  ProfileVIew.swift
//  Spon-us
//
//  Created by 황인성 on 2024/01/16.
//

import SwiftUI

struct ProfileView: View {
    
    
    var body: some View {
        VStack(spacing: 0) {
            
//            Rectangle()
//            .fill(Color(red: 0.18, green: 0.2, blue: 0.21).opacity(0.6))
////              .foregroundColor(.clear)
//              .frame(maxWidth: .infinity, maxHeight: 111)
              
            
            ScrollView {
//                VStack{
                    Image("TestImage")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: 540)
                        .padding(.bottom, 40)
//                }
                VStack(alignment: .leading, spacing: 0){
                    
                    // Korean/Heading/Heading09
                    Text("기업 소개")
                        .font(.Heading09)
                      .foregroundColor(Color.sponusBlack)
                      .padding(.bottom, 16)
                    
                    SponUsDivider()
                        .padding(.bottom, 24)
                    
                    // Korean/Body/Body10
                    Text("무신사는 700만 회원을 보유한 국내 1위 온라인 패션 플랫폼입니다. 스트릿, 글로벌 명품, 디자이너 등 5천여 개 브랜드가 입점한 「무신사 스토어」와 국내·외 최신 패션 트렌드와 정보를 전달하는 패션 매거진 「무신사 매거진」을 운영하고 있습니다.")
                        .font(.Body10)
                      .foregroundColor(Color.sponusGrey800)
                      .padding(.trailing, 20)
                      .padding(.bottom, 40)
//                      .frame(width: 315, alignment: .topLeading)
                    
                    // Korean/Heading/Heading09
                    Text("기업 정보")
                        .font(.Heading09)
                      .foregroundColor(Color.sponusBlack)
                      .padding(.bottom, 16)
                    
                    SponUsDivider()
                        .padding(.bottom, 24)
                    
                    // English/English08
                    HStack(spacing: 13) {
                        Text("Instagram")
                            .font(.English08)
                        .foregroundColor(Color.sponusGrey800)
                        
                        Image("ic_link")
                    }
                    .padding(.bottom, 24)
                    
                    Button("Open Default App") {
                                openDefaultApp()
                            }
                    
                    HStack(spacing: 13) {
                        Text("www.musinsa.com")
                            .font(.English08)
                        .foregroundColor(Color.sponusGrey800)
                        
                        Image("ic_link")
                    }
                    .padding(.bottom, 24)
                    
                    Button("Open External App") {
                                openExternalApp()
                            }
                    
                    
                    
                    
                    HStack(spacing: 13) {
                        Text("facebook")
                            .font(.English08)
                        .foregroundColor(Color.sponusGrey800)
                        
                        Image("ic_link")
                    }
                    .padding(.bottom, 42)
                    
                    // Korean/Heading/Heading09
                    Text("활동 기록")
                        .font(.Heading09)
                      .foregroundColor(Color.sponusBlack)
                      .padding(.bottom, 16)
                    
                    SponUsDivider()
                        .padding(.bottom, 24)
                    
                    HStack {
                        Text("게시 중 공고")
                            .font(.Body06)
                        .foregroundColor(Color.sponusGrey800)
                        
                        Spacer()
                        
                        Text("1건")
                            .font(.English07)
                          .foregroundColor(Color.sponusPrimary)
                    }
                    .frame(width: 133)
                    .padding(.bottom, 20)
                    
                    HStack {
                        Text("게시 중 공고")
                            .font(.Body06)
                        .foregroundColor(Color.sponusGrey800)
                        
                        Spacer()
                        
                        Text("1건")
                            .font(.English07)
                          .foregroundColor(Color.sponusPrimary)
                    }
                    .frame(width: 133)
                    .padding(.bottom, 20)
                    
                    HStack {
                        Text("게시 중 공고")
                            .font(.Body06)
                        .foregroundColor(Color.sponusGrey800)
                        
                        Spacer()
                        
                        Text("1건")
                            .font(.English07)
                          .foregroundColor(Color.sponusPrimary)
                    }
                    .frame(width: 133)
                    
                    
                }
                .padding(.leading, 40)
            }
            
        }
        .navigationTitle("프로필").font(.Body01)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton())
        .navigationBarBackground()
    }
    
    func openDefaultApp() {
            guard let url = URL(string: "https://musinsa.com") else {
                return
            }

            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    
    func openExternalApp() {
            // Replace "externalapp://" with the actual URL scheme or custom URL supported by the external app
            guard let url = URL(string: "instagram://") else {
                return
            }

            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                // Handle the case where the external app cannot be opened
                print("External app not installed or supported.")
            }
        }
}

#Preview {
    ProfileView()
}
