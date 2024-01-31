//
//  TermsAndConditionsView.swift
//  Spon-us
//
//  Created by 박현수 on 1/28/24.
//

import SwiftUI

struct TermsAndConditionsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Text("서비스 이용약관 (상품, 서비스 등 이용 일반 회원용)").font(.Body05).padding(.top, 34)
                Text("제1조(목적)").font(.Body05).padding(.top, 12)
                HStack(spacing: 0) {
                    VStack(spacing: 0) {
                        Text("1. ").font(.Body10).foregroundStyle(.sponusGrey800)
                        Spacer()
                    }
                    Text("본 약관은 스포너스가 운영하는 모바일 애플리케이션 '스포너스'을 통해 제공되는 전자상거래 서비스와 관련하여 당사자의 권리 의무 및 책임사항을 규정하는 것을 목적으로 합니다.").lineSpacing(3).font(.Body10).foregroundStyle(.sponusGrey800)
                }.padding(.top, 12)
                HStack(spacing: 0) {
                    VStack(spacing: 0) {
                        Text("2. ").font(.Body10).foregroundStyle(.sponusGrey800)
                        Spacer()
                    }
                    Text("PC통신, 무선 등을 이용하는 전자상거래에 대하여도 그 성질에 반하지 않는 한 본 약관을 준용합니다.").lineSpacing(3).font(.Body10).foregroundStyle(.sponusGrey800)
                }.padding(.top, 6)
                Text("제2조(정의)").font(.Body05).padding(.top, 12)
                HStack(spacing: 0) {
                    VStack(spacing: 0) {
                        Text("1. ")
                            .font(.Body10).foregroundStyle(.sponusGrey800)
                        Spacer()
                    }
                    VStack(spacing: 0) {
                        HStack {
                            Text("본 약관에서 사용하는 용어의 정의는 다음과 같습니다.").font(.Body10).foregroundStyle(.sponusGrey800)
                            Spacer()
                        }.padding(.bottom, 3)
                        
                        HStack(spacing: 0) {
                            VStack(spacing: 0) {
                                Text("a. ")
                                    .font(.Body10).foregroundStyle(.sponusGrey800)
                                Spacer()
                            }
                            Text("'회사'라 함은, 스포너스가 재화 또는 용역을 제공하기 위하여 컴퓨터 등 정보통신설비를 이용하여 상품을 거래할 수 있도록 설정한 가상의 영업장을 운영하는 주체를 말하며, 아울러 '스포너스'을 통해 제공되는 전자상거래 관련 서비스의 의미로도 사용합니다.").lineSpacing(3).font(.Body10).lineLimit(.max).foregroundStyle(.sponusGrey800)
                        }.padding(.bottom, 3)
                        HStack(spacing: 0) {
                            VStack(spacing: 0) {
                                Text("b. ")
                                    .font(.Body10).foregroundStyle(.sponusGrey800)
                                Spacer()
                            }
                            Text("'모바일앱'이라 함은, '회사'가 개발 및 운영을 담당하고, '이용자'의 편의를 위하여 제공하는 모바일 애플리케이션을 말합니다.").lineSpacing(3).font(.Body10).foregroundStyle(.sponusGrey800)
                        }.padding(.bottom, 3)
                        HStack(spacing: 0) {
                            VStack(spacing: 0) {
                                Text("c. ")
                                    .font(.Body10).foregroundStyle(.sponusGrey800)
                                Spacer()
                            }
                            Text("본 조에서 정의되지 않은 본 약관 상의 용어는 일반적인 거래관행에 따라 해석합니다.").lineSpacing(3).font(.Body10).foregroundStyle(.sponusGrey800)
                        }.padding(.bottom, 3)
                    }
                }.padding(.top, 12)
            }
        }.padding(.horizontal, 20)
            .navigationTitle("이용약관 동의")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackButton())
    }
}

#Preview {
    TermsAndConditionsView()
}
