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
            
            Rectangle()
              .foregroundColor(.clear)
              .frame(maxWidth: .infinity, maxHeight: 111)
              .background(Color(red: 0.18, green: 0.2, blue: 0.21).opacity(0.8))
            
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
                        .padding(.bottom, 22)
                    
                    // English/English08
                    HStack(spacing: 13) {
                        Text("Instagram")
                            .font(.English08)
                        .foregroundColor(Color.sponusGrey800)
                        
                        Image("ic_link")
                    }
                    .padding(.bottom, 24)
                    
                    HStack(spacing: 13) {
                        Text("www.musinsa.com")
                            .font(.English08)
                        .foregroundColor(Color.sponusGrey800)
                        
                        Image("ic_link")
                    }
                    .padding(.bottom, 24)
                    
                    HStack(spacing: 13) {
                        Text("facebook")
                            .font(.English08)
                        .foregroundColor(Color.sponusGrey800)
                        
                        Image("ic_link")
                    }
                    .padding(.bottom, 42)
                    
                }
                .padding(.leading, 40)
            }
            
        }
    }
}

#Preview {
    ProfileView()
}
