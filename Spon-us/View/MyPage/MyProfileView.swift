//
//  MyProfileView.swift
//  Spon-us
//
//  Created by yubin on 2/6/24.
//

import SwiftUI

struct MyCustomBackButton: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button {
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Image(.icBack)
        }
    }
}

struct MyProfileView: View {
    @Binding var rootIsActive: Bool
    
    @ObservedObject var myOrganizationViewModel = MyOrganizationViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                ZStack(alignment: .topTrailing) {
                    ZStack(alignment: .bottomLeading) {
                        Image(.profileTest)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity, maxHeight: 540)
                        
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(maxWidth: .infinity).frame(height: 178)
                            .background(
                                LinearGradient(
                                    stops: [
                                        Gradient.Stop(color: Color(red: 0.13, green: 0.13, blue: 0.13).opacity(0), location: 0.00),
                                        Gradient.Stop(color: Color(red: 0.13, green: 0.13, blue: 0.13).opacity(0.45), location: 0.55),
                                        Gradient.Stop(color: Color(red: 0.13, green: 0.13, blue: 0.13).opacity(0.9), location: 1.00),
                                    ],
                                    startPoint: UnitPoint(x: 0.5, y: 0),
                                    endPoint: UnitPoint(x: 0.5, y: 1)
                                )
                            )
                        
                        VStack(alignment:.leading, spacing: 8) {
                            Text(myOrganizationViewModel.myOrganization?.suborganizationType == "STUDENT_COUNCIL" ?
                                 "Student Council" :
                                    (myOrganizationViewModel.myOrganization?.suborganizationType == "STUDENT_CLUB" ?
                                     "Student Club" :
                                        "Company"))
                            .font(.English15)
                            .foregroundColor(Color.sponusPrimary)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(
                                RoundedRectangle(cornerRadius: 99)
                                    .foregroundColor(Color.sponusSecondary)
                            )
                            Text(myOrganizationViewModel.myOrganization?.name ?? "스포대학교 총학생회")
                                .font(.Heading01)
                                .foregroundColor(Color.sponusWhite)
                                .padding(.bottom, 25)
                        }
                        .padding(.leading, 40)
                    }
                    
                    NavigationLink {
                        ProfileEditView()
                    } label: {
                        HStack {
                            Image(.icEdit)
                            
                            Text("프로필 수정")
                                .font(.Body10)
                                .foregroundColor(Color.sponusWhite)
                        }
                        .padding(8)
                        .frame(width: 122, alignment: .leading)
                        .background(Color.sponusBlack)
                    }
                    .padding([.top, .trailing], 20)
                }
                
                VStack(alignment: .leading, spacing: 16){
                    
                    Text("단체 소개")
                        .font(.Heading09)
                        .foregroundColor(Color.sponusBlack)
                    
                    SponUsDivider()
                        .padding(.bottom, 8)
                    
                    Text(myOrganizationViewModel.myOrganization?.description ?? "안녕하세요 스포대학교 제 21대 총학생회 스포너스입니다. 저희는 학생과 세상 사이의 장벽을 뛰어넘겠다는 각오로 스포대학교 학생들의 복지를 위해 힘쓰고 있습니다. \n연락 주시는 모든 일에 적극적으로 임하겠습니다.")
                        .font(.Body10)
                        .frame(alignment: .topLeading)
                        .foregroundColor(Color.sponusGrey800)
                        .padding(.trailing, 20)
                        .padding(.bottom, 24)
                    
                    Text("학생회 정보")
                        .font(.Heading09)
                    
                    SponUsDivider()
                        .padding(.bottom, 8)
                    
                    MyProfileSNSView()
                        .padding(.bottom, 24)
                    
                    Text("활동 기록")
                        .font(.Heading09)
                    
                    SponUsDivider()
                        .padding(.bottom, 8)
                    
                    MyProfileHistoryCell(stateMessage: "게시 중 공고")
                        .padding(.bottom, 4)
                    
                    MyProfileHistoryCell(stateMessage: "진행 중 공고")
                        .padding(.bottom, 4)
                    
                    MyProfileHistoryCell(stateMessage: "완료된 공고")
                }
                .foregroundColor(Color.sponusBlack)
                .padding(.top, 43)
                .padding(.leading, 40)
            }
            .navigationTitle("프로필").font(.Body01)
            
        }
        .onAppear {
            myOrganizationViewModel.fetchMyOrganization()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarBackground()
        .toolbar(.hidden, for: .tabBar)
        .navigationBarItems(leading: MyCustomBackButton())
    }
}

struct MyProfileSNSView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            
            Button(action: {
                openInstagram()
            }, label: {
                HStack(spacing: 13) {
                    Text("Instagram")
                        .font(.English08)
                        .foregroundColor(Color.sponusGrey800)
                    
                    Image(.icLink)
                }
            })
            
            Button(action: {
                openDefaultApp()
            }, label: {
                HStack(spacing: 13) {
                    Text(verbatim: "www.spon-us.com")
                        .font(.English08)
                        .foregroundColor(Color.sponusGrey800)
                    
                    Image(.icLink)
                }
            })
            
            Button(action: {
                openFacebook()
            }, label: {
                HStack(spacing: 13) {
                    Text("facebook")
                        .font(.English08)
                        .foregroundColor(Color.sponusGrey800)
                    
                    Image(.icLink)
                }
            })
        }
    }
    
    func openInstagram() {
        let instagramUrl = URL(string: "instagram://user?username=sponus_official")!
        if UIApplication.shared.canOpenURL(instagramUrl) {
            UIApplication.shared.open(instagramUrl, options: [:], completionHandler: nil)
        } else {
            let webUrl = URL(string: "https://www.instagram.com/sponus_official/")!
            UIApplication.shared.open(webUrl, options: [:], completionHandler: nil)
        }
    }
    
    func openDefaultApp() {
        guard let url = URL(string: "http://www.musinsa.com") else {
            return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func openFacebook() {
        let facebookUrl = URL(string: "facebook://")!
        if UIApplication.shared.canOpenURL(facebookUrl) {
            UIApplication.shared.open(facebookUrl, options: [:], completionHandler: nil)
        } else {
            let webUrl = URL(string: "https://www.facebook.com/")!
            UIApplication.shared.open(webUrl, options: [:], completionHandler: nil)
        }
    }
}

struct MyProfileHistoryCell: View {
    var stateMessage: String
    
    var body: some View {
        HStack {
            Text(stateMessage)
                .font(.Body06)
                .foregroundColor(Color.sponusGrey800)
            
            Spacer()
            
            Text("1건")
                .font(.English07)
                .foregroundColor(Color.sponusPrimary)
        }
        .frame(width: 133)
    }
}

#Preview {
    MyProfileView(rootIsActive: .constant(false))
}
