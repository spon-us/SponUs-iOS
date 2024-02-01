//
//  GatherAndUsageView.swift
//  Spon-us
//
//  Created by 박현수 on 1/28/24.
//

import SwiftUI

struct GatherAndUsageView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 0) {
                    Image(.gatherUsage1)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.top, 34)
                    Image(.gatherUsage2)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.top, 12)
                    Image(.gatherUsage3)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.top, 12)
                    Image(.gatherUsage4)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.top, 12)
                    Image(.gatherUsage5)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.top, 12)
                }.padding(.bottom, 110)
                
                    
            }.padding(.horizontal, 20)
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("확인").font(.Body01).foregroundStyle(.sponusPrimaryDarkmode).frame(maxWidth: .infinity).padding(.top, 20)
            }.background(.sponusBlack)
        }.navigationTitle("개인정보 수집 및 이용 동의")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarItems(leading: CustomBackButton())
    }
//    var body: some View {
//        VStack(spacing: 0) {
//            ScrollView {
//                VStack(alignment: .leading, spacing: 0) {
//                    Text("개인정보처리동의서").font(.Body05).padding(.top, 34)
//                    Text("스포너스(이하 '회사'라고 합니다)는 개인정보보호법 등 관련 법령상의 개인정보보호 규정을 준수하며 귀하의 개인정보보호에 최선을 다하고 있습니다. 회사는 개인정보보호법에 근거하여 다음과 같은 내용으로 개인정보를 수집 및 처리하고자 합니다.\n\n다음의 내용을 자세히 읽어보시고 모든 내용을 이해하신 후에 동의 여부를 결정해주시기 바랍니다.").lineSpacing(3).font(.Body10).foregroundStyle(.sponusGrey800).padding(.top, 12)
//                    Text("제1조(개인정보 수집 및 이용 목적)").font(.Body05).padding(.top, 12)
//                    Text("이용자가 제공한 모든 정보는 다음의 목적을 위해 활용하며, 목적 이외의 용도로는 사용되지 않습니다.").lineSpacing(3).font(.Body10).foregroundStyle(.sponusGrey800).padding(.top, 12)
//                    HStack(spacing: 0) {
//                        Text("•").font(.Body10).foregroundStyle(.sponusGrey800).frame(width: 20)
//                        Text("서비스 제공").font(.Body10).foregroundStyle(.sponusGrey800)
//                    }.padding(.top, 6)
//                    Text("제2조(개인정보 수집 및 이용 항목)").font(.Body05).padding(.top, 12)
//                    Text("제2조(개인정보 수집 및 이용 항목)\n회사는 개인정보 수집 목적을 위하여 다음과 같은 정보를 수집합니다.").lineSpacing(3).font(.Body10).foregroundStyle(.sponusGrey800).padding(.top, 12)
//                    HStack(spacing: 0) {
//                        Text("•").font(.Body10).foregroundStyle(.sponusGrey800).frame(width: 20)
//                        Text("성명, 전화번호 및 이메일").font(.Body10).foregroundStyle(.sponusGrey800)
//                    }.padding(.top, 6)
//                    Text("제3조(개인정보 보유 및 이용 기간)").font(.Body05).padding(.top, 12)
//                    HStack(spacing: 0) {
//                        VStack(spacing: 0) {
//                            Text("1. ").lineSpacing(3).font(.Body10).foregroundStyle(.sponusGrey800)
//                            Spacer()
//                        }.frame(width: 20)
//                        Text("수집한 개인정보는 수집·이용 동의일로부터 개인정보 수집·이용 목적을 달성할 때까지 보관 및 이용합니다.").lineSpacing(3).font(.Body10).foregroundStyle(.sponusGrey800)
//                    }.padding(.top, 12)
//                    HStack(spacing: 0) {
//                        VStack(spacing: 0) {
//                            Text("2. ").lineSpacing(3).font(.Body10).foregroundStyle(.sponusGrey800)
//                            Spacer()
//                        }.frame(width: 20)
//                        Text("개인정보 보유기간의 경과, 처리목적의 달성 등 개인정보가 불필요하게 되었을 때에는 지체없이 해당 개인정보를 파기합니다.").lineSpacing(3).font(.Body10).foregroundStyle(.sponusGrey800)
//                    }.padding(.top, 6)
//                    Text("제4조(동의 거부 관리)").font(.Body05).padding(.top, 12)
//                    
//                        
//                    Text("귀하는 본 안내에 따른 개인정보 수집·이용에 대하여 동의를 거부할 권리가 있습니다. 다만, 귀하가 개인정보 동의를 거부하시는 경우에 서비스 이용 제한의 불이익이 발생할 수 있음을 알려드립니다.\n본인은 위의 동의서 내용을 충분히 숙지하였으며, 위와 같이 개인정보를 수집·이용하는데 동의합니다.").lineSpacing(3).font(.Body10).foregroundStyle(.sponusGrey800).padding(.top, 12).padding(.bottom, 110)
//                }
//            }.padding(.horizontal, 20)
//            Button {
//                presentationMode.wrappedValue.dismiss()
//            } label: {
//                Text("확인").font(.Body01).foregroundStyle(.sponusPrimaryDarkmode).frame(maxWidth: .infinity).padding(.top, 20)
//            }.background(.sponusBlack)
//        }.navigationTitle("개인정보 수집 및 이용 동의")
//            .navigationBarTitleDisplayMode(.inline)
//            .navigationBarBackButtonHidden(true)
//            .navigationBarItems(leading: CustomBackButton())
//    }
}

#Preview {
    GatherAndUsageView()
}
