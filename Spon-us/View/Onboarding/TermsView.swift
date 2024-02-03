//
//  TermsView.swift
//  Spon-us
//
//  Created by 박현수 on 1/27/24.
//

import SwiftUI

struct TermsView: View {
    
    @State var processingPolicyTapped = false
    @State var gatherUsageTapped = false
    @State var termsConditionsTapped = false
    @State var thirdPartyTapped = false
    
    var body: some View {
        
        @State var acceptAll = processingPolicyTapped && gatherUsageTapped && termsConditionsTapped && thirdPartyTapped
        @State var nextButtonDisabled = !(processingPolicyTapped && gatherUsageTapped && termsConditionsTapped)
        
        VStack(spacing: 0) {
            ZStack {
                Rectangle().frame(height: 1).foregroundStyle(.sponusGrey100)
                HStack {
                    Rectangle().frame(width: 84, height: 1).foregroundStyle(.sponusBlack)
                    Spacer()
                }
            }.padding(.top, 8)
            HStack(spacing: 0) {
                Text("스포너스 이용을 위해\n이용약관에 동의해주세요")
                    .font(.Heading06)
                    .lineSpacing(6)
                    .padding(.top, 27)
                Spacer()
            }
            Button {
                switch acceptAll {
                case true:
                    processingPolicyTapped = false
                    gatherUsageTapped = false
                    termsConditionsTapped = false
                    thirdPartyTapped = false
                case false:
                    processingPolicyTapped = true
                    gatherUsageTapped = true
                    termsConditionsTapped = true
                    thirdPartyTapped = true
                }
            } label: {
                HStack(spacing: 0) {
                    Spacer()
                    Image(acceptAll ? .icCheckFilled : .icTermsCheckCircle).resizable().frame(width: 24, height: 24).padding(.trailing, 14)
                    Text("이용약관 전체 동의").font(.Body06).foregroundStyle(acceptAll ? .sponusBlack : .sponusGrey600)
                    Spacer()
                }.frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .border(acceptAll ? .sponusPrimary : .sponusGrey100)
            }.padding(.top, 32).padding(.bottom, 41)
            
            VStack(spacing: 8) {
                HStack(spacing: 0) {
                    Button {
                        processingPolicyTapped.toggle()
                    }
                    label: {
                        Image(processingPolicyTapped ? .icCheckPrimary : .icTermsCheck).resizable().frame(width: 20, height: 20)
                    }
                    Text("(필수) 개인정보처리방침을 읽고 숙지하였습니다").font(.Body10).foregroundStyle(.sponusGrey600).padding(.leading, 6)
                    Spacer()
                    NavigationLink {
                        ProcessingPolicyView()
                    } label: {
                        Image(.icGo).renderingMode(.template).foregroundStyle(.sponusGrey600).frame(width: 20, height: 20)
                    }
                }.padding(.bottom, 8)
                HStack(spacing: 0) {
                    Button {
                        gatherUsageTapped.toggle()
                    }
                    label: {
                        Image(gatherUsageTapped ? .icCheckPrimary : .icTermsCheck).resizable().frame(width: 20, height: 20)
                    }
                    Text("(필수) 개인정보 수집 및 이용 동의").font(.Body10).foregroundStyle(.sponusGrey600).padding(.leading, 6)
                    Spacer()
                    NavigationLink {
                        GatherAndUsageView()
                    } label: {
                        Image(.icGo).renderingMode(.template).foregroundStyle(.sponusGrey600).frame(width: 20, height: 20)
                    }
                }.padding(.bottom, 8)
                HStack(spacing: 0) {
                    Button {
                        termsConditionsTapped.toggle()
                    }
                    label: {
                        Image(termsConditionsTapped ? .icCheckPrimary : .icTermsCheck).resizable().frame(width: 20, height: 20)
                    }
                    Text("(필수) 이용약관 동의").font(.Body10).foregroundStyle(.sponusGrey600).padding(.leading, 6)
                    Spacer()
                    NavigationLink {
                        TermsAndConditionsView()
                    } label: {
                        Image(.icGo).renderingMode(.template).foregroundStyle(.sponusGrey600).frame(width: 20, height: 20)
                    }
                }.padding(.bottom, 8)
                HStack(spacing: 0) {
                    Button {
                        thirdPartyTapped.toggle()
                    }
                    label: {
                        Image(thirdPartyTapped ? .icCheckPrimary : .icTermsCheck).resizable().frame(width: 20, height: 20)
                    }
                    Text("(선택) 개인정보 제 3자 제공 동의").font(.Body10).foregroundStyle(.sponusGrey600).padding(.leading, 6)
                    Spacer()
                    NavigationLink {
                        ThirdPartyView()
                    } label: {
                        Image(.icGo).renderingMode(.template).foregroundStyle(.sponusGrey600).frame(width: 20, height: 20)
                    }
                }.padding(.bottom, 8)
            }
            Spacer()
            NavigationLink {
                RegisterIDView()
            } label: {
                Text("다음").font(.Body04).frame(maxWidth: .infinity).frame(height: 56).foregroundStyle(.sponusWhite).background(nextButtonDisabled ? .sponusGrey600 : .sponusPrimary).padding(.bottom, 16)
            }.disabled(nextButtonDisabled)

        }.padding(.horizontal, 20)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackButton())
    }
}

#Preview {
    TermsView()
}
