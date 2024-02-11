//
//  LoginView.swift
//  Spon-us
//
//  Created by 박현수 on 1/25/24.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State var userID = ""
    @State private var userPW = ""
    @State private var isPWSecure = true
    @State var isEmailValid = false
    @State var goToContentView = false
    @State var goToTermsView = false
    
    @FocusState private var isEmailTextFieldFocused: Bool
    @FocusState private var isPWTextFieldFocused: Bool
    @FocusState private var isPWSecureFieldFocused: Bool
    
    
    let emailRegexPattern = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,6}$/
    
    var body: some View {
        let emailTextField = TextField("", text: $userID, prompt: Text(verbatim: "ex) sponus@sponus.co.kr").font(.Caption04).foregroundStyle(.sponusGrey500)).focused($isEmailTextFieldFocused)
            .font(.Caption04)
        
        let pwSecureField = SecureField("", text: $userPW).focused($isPWSecureFieldFocused).font(.Caption04)
        let pwTextField = TextField("", text: $userPW).focused($isPWTextFieldFocused).font(.Caption04)
        NavigationStack {
            VStack(spacing: 0) {
                Image(.logoMain).resizable().frame(width: 159, height: 33).padding(.top, 91)
                Text("로그인하고 다양한 정보를 만나보세요").font(.Body10).foregroundStyle(.sponusGrey700).padding(.top, 12)
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Text("이메일 주소").font(.Caption04)
                        Spacer()
                    }.padding(.bottom, 8)
                    emailTextField.padding(.bottom, 6)
                    if (isEmailTextFieldFocused) {
                        Divider()
                            .background(.sponusPrimary)
                    }
                    else if (((userID.wholeMatch(of: emailRegexPattern)?.output) != nil) || userID.isEmpty) {
                        Divider()
                            .background(.sponusGrey200)
                    }
                    else {
                        Divider().background(.sponusRed).padding(.bottom, 8)
                        HStack(spacing: 0) {
                            Image(.icWarning).resizable().frame(width: 14, height: 14).padding(.trailing, 4)
                            Text("이메일을 다시 입력해주세요")
                                .font(.system(size: 12))
                                .foregroundStyle(.sponusRed)
                            Spacer()
                        }
                    }
                    
                }.padding(.horizontal, 20)
                    .padding(.top, 50)
                    .padding(.bottom, 28)
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Text("비밀번호").font(.Caption04)
                        Spacer()
                    }.padding(.bottom, 8)
                    ZStack {
                        if isPWSecure {
                            pwSecureField
                        }
                        else {
                            pwTextField
                        }
                        HStack {
                            Spacer()
                            Button {
                                isPWSecure.toggle()
                            } label: {
                                if isPWSecure {
                                    Image(.icEyeOff).resizable()
                                        .frame(width: 20, height: 20)
                                }
                                else {
                                    Image(.icEyeSmall).resizable()
                                        .frame(width: 20, height: 20)
                                }
                            }
                        }
                    }.padding(.bottom, 6)
                    if (isPWSecureFieldFocused || isPWTextFieldFocused) {
                        Divider()
                            .background(.sponusPrimary)
                    }
                    //                else if (((userID.wholeMatch(of: emailRegexPattern)?.output) != nil) || userID.isEmpty) {
                    //                    Divider()
                    //                        .background(.sponusGrey200)
                    //                }
                    else {
                        Divider().background(.sponusGrey200)
                    }
                }.padding(.horizontal, 20)
                    .padding(.bottom, 48)
                Button {
                    Messaging.messaging().token { token, error in
                        if let error = error {
                            print("Error fetching FCM registration token: \(error)")
                        } else if let token = token {
                            print("FCM registration token: \(token)")
                            // 여기서 토큰을 사용하거나 저장합니다.
                        }
                    }
                    //goToContentView = true
                } label: {
                    Text("로그인")
                        .font(.Body04).foregroundStyle(.sponusWhite)
                        .frame(maxWidth: .infinity).frame(height: 56)
                        .background(.sponusPrimary)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                }.fullScreenCover(isPresented: $goToContentView, content: {
                    ContentView()
                })
                Button {
                    goToTermsView = true
                } label: {
                    Text("이메일 가입")
                        .font(.Caption04).foregroundStyle(.sponusGrey900)
                        .frame(width: 111, height: 38)
                        .padding(.horizontal, 20)
                }.navigationDestination(isPresented: $goToTermsView, destination: {
                    TermsView()
                })
                Spacer()
            }
        }
    }
}

#Preview {
    LoginView()
}
