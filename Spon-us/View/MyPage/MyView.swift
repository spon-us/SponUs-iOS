//
//  MyView.swift
//  Spon-us
//
//  Created by yubin on 1/11/24.
//

import SwiftUI

struct MyView: View {
    @Binding var rootIsActive: Bool
    
    @State private var showLogoutAlert = false
    @State private var showAlert = false
    
    let searchItem: some View = {
        NavigationLink {
            SearchView()
        } label: {
            Image("ic_search_white")
        }
    }()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("MY")
                    .font(
                        Font.custom("SUIT", size: 30)
                            .weight(.bold)
                    )
                    .foregroundColor(Color.sponusWhite)
                
                HStack(spacing: 0) {
                    Image("profile_test")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipped()
                    
                    VStack(alignment: .leading, spacing: 0) {
                        NavigationLink(destination: MyProfileView(rootIsActive: .constant(false)), label: {
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
                        
                        Text("스포대학교 총학생회")
                            .font(.Heading09)
                            .foregroundColor(Color.sponusWhite)
                            .padding(.top, 11)
                    }
                    .padding(.leading, 16)
                    
                }
                .padding(.top, 24)
                .padding(.bottom, 36)
            }
            .padding(.leading, 20)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .frame(width: UIScreen.screenWidth, height: 205)
            .background(Color.sponusBlack)
            
            ScrollView {
                VStack(spacing: 20) {
                    NavigationLink(destination: HonorInfoEditView()) {
                        HStack {
                            Text("담당자 정보 수정하기")
                                .font(.Body05)
                                .foregroundColor(Color.sponusBlack)
                            Spacer()
                            
                            Image("ic_move_grey").frame(width: 28, height: 28)
                        }
                    }.frame(height: 28)
                    
                    Divider()
                    
                    NavigationLink(destination: CouponView()) {
                        HStack {
                            Text("쿠폰함")
                                .font(.Body05)
                                .foregroundColor(Color.sponusBlack)
                            Spacer()
                            
                            Image("ic_move_grey").frame(width: 28, height: 28)
                        }
                    }.frame(height: 28)
                    
                    Divider()
                    
                    Link(destination: URL(string: "http://pf.kakao.com/_QxkxfSG")!) {
                        HStack {
                            Text("문의하기")
                                .font(.Body05)
                                .foregroundColor(Color.sponusBlack)
                            Spacer()
                            
                            Image("ic_move_grey").frame(width: 28, height: 28)
                        }
                    }.frame(height: 28)
                    
                    Divider()
                    
                    NavigationLink(destination: PrivacyPolicyView()) {
                        HStack {
                            Text("개인정보처리방침")
                                .font(.Body05)
                                .foregroundColor(Color.sponusBlack)
                            Spacer()
                            
                            Image("ic_move_grey").frame(width: 28, height: 28)
                        }
                    }.frame(height: 28)
                    
                    Divider()
                    
                    NavigationLink(destination: TermsConditionsView()) {
                        HStack {
                            Text("이용약관")
                                .font(.Body05)
                                .foregroundColor(Color.sponusBlack)
                            Spacer()
                            
                            Image("ic_move_grey").frame(width: 28, height: 28)
                        }
                    }.frame(height: 28)
                    
                    Divider()
                    
                    HStack {
                        Text("버전정보")
                            .font(.Body05)
                            .foregroundColor(Color.sponusBlack)
                        Spacer()
                        
                        Text("1.1.1")
                            .font(.Body10)
                            .foregroundColor(Color.sponusGrey600)
                            .padding(.trailing, 12)
                    }.frame(height: 28)
                    
                    Divider()
                    
                    Button(action: {
                        showLogoutAlert = true
                    }) {
                        Text("로그아웃")
                            .font(.Body10)
                            .foregroundColor(Color.sponusBlack)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 10)
                            .overlay(
                                Rectangle()
                                    .inset(by: 0.5)
                                    .stroke(Color.sponusBlack, lineWidth: 1))
                    }
                    .padding(.top, 40)
                    .alert(isPresented: $showLogoutAlert) {
                        Alert(
                            title: Text("로그아웃 하시겠습니까?"),
                            primaryButton: .destructive(
                                Text("아니오")
                            ),
                            secondaryButton: .default(
                                Text("로그아웃"),
                                action: {}
                            )
                        )
                    }
                    
                    Button(action: {
                        showAlert = true
                    }) {
                        Text("계정탈퇴")
                            .font(.Caption04)
                            .foregroundColor(Color.sponusGrey600)
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("계정 탈퇴를 진행하시겠습니까?"),
                            message: Text("탈퇴 이후에는 되돌리기 어렵습니다."),
                            primaryButton: .default(
                                Text("취소")
                            ),
                            secondaryButton: .destructive(
                                Text("탈퇴"),
                                action: {}
                            )
                        )
                    }
                    .padding(.bottom, 34)
                }
                .padding(.top, 35)
                .padding([.leading, .trailing], 20)
                
            }
            .navigationBarItems(trailing: searchItem)
            .mynavigationBarBackground()
        }
    }
}

#Preview {
    MyView(rootIsActive: .constant(false))
}
