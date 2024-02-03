//
//  SelectUserTypeView.swift
//  Spon-us
//
//  Created by 박현수 on 2/3/24.
//

import SwiftUI

struct SelectUserTypeView: View {
    @State var isStudent = false
    @State var isCompany = false
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle().frame(height: 1).foregroundStyle(.sponusBlack)
            HStack(spacing: 0) {
                Text("어느 단체이신가요?")
                    .font(.Heading06)
                    .lineSpacing(6)
                    .padding(.top, 28)
                Spacer()
            }
            HStack(spacing: 0) {
                Button {
                    isStudent.toggle()
                    isCompany = false
                } label: {
                    Image(isStudent ? .icCircleFilled : .icCircle).resizable().frame(width: 20, height: 20)
                }.padding(.leading, 16)
                Text("대학생 단체입니다").font(.Body06).padding(.leading, 16)
                Spacer()
            }.frame(height: 56).border(isStudent ? .sponusPrimary : .sponusGrey100).padding(.top, 68)
            HStack(spacing: 0) {
                Button {
                    isCompany.toggle()
                    isStudent = false
                } label: {
                    Image(isCompany ? .icCircleFilled : .icCircle).resizable().frame(width: 20, height: 20)
                }.padding(.leading, 16)
                Text("기업 담당자입니다").font(.Body06).padding(.leading, 16)
                Spacer()
            }.frame(height: 56).border(isCompany ? .sponusPrimary : .sponusGrey100).padding(.top, 16)
            Spacer()
            NavigationLink {
                SelectUserTypeView()
            } label: {
                Text("다음").font(.Body04).frame(maxWidth: .infinity).frame(height: 56).foregroundStyle(.sponusWhite).background(!(isStudent || isCompany) ? .sponusGrey600 : .sponusPrimary).padding(.bottom, 16)
            }.disabled(!(isStudent || isCompany))
        }.padding(.horizontal, 20)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackButton())
    }
}

#Preview {
    SelectUserTypeView()
}
