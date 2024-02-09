//
//  SelectUserTypeView.swift
//  Spon-us
//
//  Created by 박현수 on 2/3/24.
//

import SwiftUI

struct SelectUserTypeView: View {
    @State var userID: String
    @State var userPW: String
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
                if isStudent {
                    StudentTypeView(userID: userID, userPW: userPW)
                }
                else {
                    fillInGroupNameView(userID: userID, userPW: userPW, orgType: .company, subOrgType: nil)
                }
            } label: {
                Text("다음").font(.Body04).frame(maxWidth: .infinity).frame(height: 56).foregroundStyle(.sponusWhite).background(!(isStudent || isCompany) ? .sponusGrey600 : .sponusPrimary).padding(.bottom, 16)
            }.disabled(!(isStudent || isCompany))
        }.padding(.horizontal, 20)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackButton())
    }
}

struct StudentTypeView: View {
    @State var userID: String
    @State var userPW: String
    @State var isCouncil = false
    @State var isClub = false
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle().frame(height: 1).foregroundStyle(.sponusBlack)
            HStack(spacing: 0) {
                Text("어떤 성격의 단체이신가요?")
                    .font(.Heading06)
                    .lineSpacing(6)
                    .padding(.top, 28)
                Spacer()
            }
            HStack(spacing: 0) {
                Button {
                    isCouncil.toggle()
                    isClub = false
                } label: {
                    Image(isCouncil ? .icCircleFilled : .icCircle).resizable().frame(width: 20, height: 20)
                }.padding(.leading, 16)
                Text("학생회입니다").font(.Body06).padding(.leading, 16)
                Spacer()
            }.frame(height: 56).border(isCouncil ? .sponusPrimary : .sponusGrey100).padding(.top, 68)
            HStack(spacing: 0) {
                Button {
                    isClub.toggle()
                    isCouncil = false
                } label: {
                    Image(isClub ? .icCircleFilled : .icCircle).resizable().frame(width: 20, height: 20)
                }.padding(.leading, 16)
                Text("동아리입니다").font(.Body06).padding(.leading, 16)
                Spacer()
            }.frame(height: 56).border(isClub ? .sponusPrimary : .sponusGrey100).padding(.top, 16)
            Spacer()
            NavigationLink {
                if isCouncil {
                    fillInGroupNameView(userID: userID, userPW: userPW, orgType: .student, subOrgType: .studentCouncil)
                }
                else {
                    fillInGroupNameView(userID: userID, userPW: userPW, orgType: .student, subOrgType: .studentClub)
                }
            } label: {
                Text("다음").font(.Body04).frame(maxWidth: .infinity).frame(height: 56).foregroundStyle(.sponusWhite).background(!(isCouncil || isClub) ? .sponusGrey600 : .sponusPrimary).padding(.bottom, 16)
            }.disabled(!(isCouncil || isClub))
        }.padding(.horizontal, 20)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackButton())
    }
}


struct fillInGroupNameView: View {
    @State var userID: String
    @State var userPW: String
    @State var orgType: OrgType
    @State var subOrgType: SubOrgType?
    @State var groupName = ""
    @FocusState private var isTextFieldFocused: Bool
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
            HStack {
                TextField("", text: $groupName, prompt: Text("ex. 스포너스 대외협력팀").font(.Body06).foregroundStyle(.sponusGrey600)).focused($isTextFieldFocused)
                    .font(.English08)
                    .padding(.vertical, 16)
                    .padding(.horizontal, 20)
            }.border(isTextFieldFocused ? .sponusPrimary : .sponusGrey100)
                .padding(.top, 68)
                
            Spacer()
            NavigationLink {
                OnboardingCompletedView(userID: userID, userPW: userPW, orgType: orgType, subOrgType: subOrgType, groupName: groupName)
            } label: {
                Text("다음").font(.Body04).frame(maxWidth: .infinity).frame(height: 56).foregroundStyle(.sponusWhite).background(groupName.isEmpty ? .sponusGrey600 : .sponusPrimary).padding(.bottom, 16)
            }.disabled(groupName.isEmpty)
        }.padding(.horizontal, 20)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackButton())
    }
}

struct OnboardingCompletedView: View {
    @StateObject var joinViewModel = JoinViewModel()
    
    @State var userID: String
    @State var userPW: String
    @State var orgType: OrgType
    @State var subOrgType: SubOrgType?
    @State var groupName: String
    @State var goToContentView = false

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            Image(.logoApp).resizable().frame(width: 120, height: 120)
            HStack(spacing: 0) {
                Text("가입을 환영합니다").font(.Heading06)
                Spacer()
            }.padding(.top, 150)
            HStack(spacing: 0) {
                Text("이제 다양한 기업, 학생과\n협업을 맺어보세요")
                    .font(.system(size: 16))
                    .foregroundStyle(.sponusGrey700)
                    .lineSpacing(4)
                Spacer()
            }.padding(.top, 12)
            Spacer()
            Button {
                goToContentView = true
            } label: {
                Text("시작하기").font(.Body04).frame(maxWidth: .infinity).frame(height: 56).foregroundStyle(.sponusWhite).background(joinViewModel.isButtonEnabled ? .sponusPrimary : .sponusGrey600).padding(.bottom, 16)
            }.disabled(!joinViewModel.isButtonEnabled).fullScreenCover(isPresented: $goToContentView, content: {
                ContentView()
            })
        }.padding(.horizontal, 20)
            .toolbar(.hidden, for: .navigationBar)
            .onAppear() {
                joinViewModel.postJoin(name: groupName, email: userID, password: userPW, orgType: orgType, subOrgType: subOrgType)
            }
    }
}

//#Preview {
//    OnboardingCompletedView(userID: "temp", userPW: "temp", orgType: .student, subOrgType: nil, groupName: "temp")
//}
