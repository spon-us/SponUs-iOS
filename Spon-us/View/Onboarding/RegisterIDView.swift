//
//  RegisterIDView.swift
//  Spon-us
//
//  Created by 박현수 on 2/1/24.
//

import SwiftUI
import PopupView

struct RegisterIDView: View {
    @ObservedObject var emailViewModel = EmailViewModel()
    
    @State private var isEmailValidated = false
    @State var isAuthenticated = false
    
    @State private var userID = ""
    @State private var authCode = ""
    @State private var correctAuthCode = ""
    @State private var sentAuthCode = false
    @State private var authCodeExpired = false
    @State private var authCodeSubmitted = false
    
    @State private var showingSentPopup = false
    @State private var showingCompletedPopup = false
    
    @FocusState private var isEmailTextFieldFocused: Bool
    @FocusState private var isAuthCodeTextFieldFocused: Bool
    
    @State private var timeRemaining = 0
    @State private var isTimerRunning = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    let emailRegexPattern = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,6}$/
    
    let dummyAuthCode = ""
    
    private func startTimer() {
        if !isTimerRunning {
            isTimerRunning = true
            timeRemaining = 300
        }
    }
    
    private func stopTimer() {
        isTimerRunning = false
        timeRemaining = 0
    }
    
    private func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%d분 %02d초", minutes, remainingSeconds)
    }
    
    private func createSentToastMessage() -> some View {
        HStack {
            Text("인증번호를 전송했습니다").font(.Body03).foregroundStyle(.sponusPrimary)
        }.frame(height: 56).frame(maxWidth: .infinity).background(Color.sponusSecondary)
    }
    
    private func createCompletedToastMessage() -> some View {
        HStack {
            Text("인증이 완료되었습니다").font(.Body03).foregroundStyle(.sponusPrimary)
        }.frame(height: 56).frame(maxWidth: .infinity).background(Color.sponusSecondary)
    }
    
    var body: some View {
        
        if isEmailValidated {
            ZStack {
                VStack(spacing: 0) {
                    ZStack {
                        Rectangle().frame(height: 1).foregroundStyle(.sponusGrey100)
                        HStack {
                            Rectangle().frame(width: 168, height: 1).foregroundStyle(.sponusBlack)
                            Spacer()
                        }
                    }.padding(.top, 8)
                    HStack(spacing: 0) {
                        Text("로그인에 사용할\n아이디를 입력해주세요")
                            .font(.Heading06)
                            .lineSpacing(6)
                            .padding(.top, 28)
                        Spacer()
                    }
                    
                    HStack(spacing: 0) {
                        Text(userID)
                            .font(.English08)
                            .padding(.leading, 20)
                        Spacer()
                    }.frame(height: 56)
                        .frame(maxWidth: .infinity)
                        .frame(alignment: .leading)
                        .border(.sponusGrey100)
                        .padding(.top, 32)
                    
                    
                    
                    
                    HStack(spacing: 0) {
                        TextField("", text: $authCode, prompt: Text("인증번호 입력").font(.Body06).foregroundStyle(.sponusGrey600)).focused($isAuthCodeTextFieldFocused)
                            .font(.English08)
                            .padding(.vertical, 16)
                            .padding(.horizontal, 20)
                        if !isAuthenticated {
                            if !sentAuthCode {
                                Button {
                                    emailViewModel.postEmail(email: userID)
                                    sentAuthCode = true
                                    showingSentPopup = true
                                    startTimer()
                                } label: {
                                    Text("인증번호 받기").font(.Caption04).frame(width: 86, height: 30).foregroundStyle(.sponusPrimary).border(.sponusPrimary)
                                }.padding(.trailing, 20)
                            }
                            else {
                                Button {
                                    authCodeSubmitted = true
                                    sentAuthCode = false
                                    stopTimer()
                                    isAuthCodeTextFieldFocused = false
                                    if ((authCode == emailViewModel.email?.content) && authCodeSubmitted) {
                                        isAuthenticated = true
                                        showingCompletedPopup = true
                                    }
                                    else {
                                        authCode = ""
                                    }
                                } label: {
                                    Text("인증받기").font(.Caption04).frame(width: 62, height: 30).foregroundStyle(.sponusWhite).border(.sponusPrimary).background(.sponusPrimary)
                                }.padding(.trailing, 20)
                                
                            }
                        }
                    }.border(isAuthCodeTextFieldFocused ? .sponusPrimary : (((authCode != emailViewModel.email?.content) && authCodeSubmitted) ? .sponusRed : .sponusGrey100))
                        .padding(.top, 16)
                    if isTimerRunning {
                        if timeRemaining == 0 {
                            HStack(spacing: 0) {
                                Image(.icClock).resizable().frame(width: 16, height: 16).padding(.trailing, 4)
                                Text("인증번호가 만료되었습니다").font(.system(size: 12)).foregroundStyle(.sponusRed)
                                Spacer()
                            }.padding(.top, 12)
                        }
                        else {
                            HStack(spacing: 0) {
                                Image(.icClock).resizable().frame(width: 16, height: 16).padding(.trailing, 4)
                                Text("남은 시간: ").font(.system(size: 12)).foregroundStyle(.sponusRed)
                                Text(timeString(from: timeRemaining)).font(.system(size: 12)).foregroundStyle(.sponusRed)
                                    .onReceive(timer) { _ in
                                        if timeRemaining > 0 {
                                            timeRemaining -= 1
                                        }
                                    }
                                Spacer()
                            }.padding(.top, 12)
                        }
                    }
                    else if (authCodeSubmitted && (authCode != emailViewModel.email?.content)) {
                        HStack(spacing: 0) {
                            Image(.icWarning).resizable().frame(width: 16, height: 16).padding(.trailing, 4)
                            Text("인증번호를 다시 입력해주세요").font(.system(size: 12)).foregroundStyle(.sponusRed)
                            Spacer()
                        }.padding(.top, 12)
                    }
                    Spacer()
                    
                    NavigationLink {
                        RegisterPWView()
                    } label: {
                        Text("다음").font(.Body04).frame(maxWidth: .infinity).frame(height: 56).foregroundStyle(.sponusWhite).background(!isAuthenticated ? .sponusGrey600 : .sponusPrimary).padding(.bottom, 16)
                    }.disabled(!isAuthenticated)
                }.navigationBarTitleDisplayMode(.inline)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarItems(leading: CustomBackButton())
            }.padding(.horizontal, 20)
                .popup(isPresented: $showingSentPopup) {
                    createSentToastMessage().padding(.horizontal, 20)
                } customize: {
                    $0.type(.floater(verticalPadding: 88))
                        .position(.bottom)
                        .animation(.spring)
                        .closeOnTap(true)
                        .closeOnTapOutside(true)
                        .autohideIn(2)
                }
                .popup(isPresented: $showingCompletedPopup) {
                    createCompletedToastMessage().padding(.horizontal, 20)
                } customize: {
                    $0.type(.floater(verticalPadding: 88))
                        .position(.bottom)
                        .animation(.spring)
                        .closeOnTap(true)
                        .closeOnTapOutside(true)
                        .autohideIn(2)
                }
        }
        else {
            VStack(spacing: 0) {
                ZStack {
                    Rectangle().frame(height: 1).foregroundStyle(.sponusGrey100)
                    HStack {
                        Rectangle().frame(width: 168, height: 1).foregroundStyle(.sponusBlack)
                        Spacer()
                    }
                }.padding(.top, 8)
                HStack(spacing: 0) {
                    Text("로그인에 사용할\n아이디를 입력해주세요")
                        .font(.Heading06)
                        .lineSpacing(6)
                        .padding(.top, 28)
                    Spacer()
                }
                HStack(spacing: 0) {
                    TextField("", text: $userID, prompt: Text("이메일 입력").font(.Body06).foregroundStyle(.sponusGrey600)).focused($isEmailTextFieldFocused)
                        .font(.English08)
                        .padding(.vertical, 16)
                        .padding(.horizontal, 20)
                    if !userID.isEmpty {
                        Button {
                            userID = ""
                            isEmailTextFieldFocused = false
                        } label: {
                            Image(.icCancel).resizable().frame(width: 28, height: 28)
                        }.padding(.trailing, 12)
                        
                    }
                }.border(isEmailTextFieldFocused ? .sponusPrimary : ((userID.wholeMatch(of: emailRegexPattern)?.output == nil && !userID.isEmpty) ? .sponusRed : .sponusGrey100))
                    .padding(.top, 32)
                if (userID.isEmpty && !isEmailTextFieldFocused) {
                    HStack(spacing: 0) {
                        Text("*개인 이메일이 아닌 ").font(.system(size: 12))
                        Text("단체 이메일").font(.system(size: 12)).foregroundStyle(.sponusPrimary)
                        Text("을 사용하시는 것을 권장드립니다").font(.system(size: 12))
                        Spacer()
                    }.padding(.top, 12)
                    
                }
                else if (userID.wholeMatch(of: emailRegexPattern)?.output != nil) {
                    HStack(spacing: 0) {
                        Image(.icCheckEmpty).resizable().frame(width: 16, height: 16).padding(.trailing, 2)
                        Text("사용 가능한 이메일입니다").font(.system(size: 12)).foregroundStyle(.sponusPrimary)
                        Spacer()
                    }.padding(.top, 12)
                }
                else if (userID.wholeMatch(of: emailRegexPattern)?.output == nil && !isEmailTextFieldFocused) {
                    HStack(spacing: 0) {
                        Image(.icWarning).resizable().frame(width: 16, height: 16).padding(.trailing, 2)
                        Text("이메일을 다시 입력해주세요").font(.system(size: 12)).foregroundStyle(.sponusRed)
                        Spacer()
                    }.padding(.top, 12)
                }
                Spacer()
                
                Button {
                    isEmailValidated = true
                } label: {
                    Text("다음").font(.Body04).frame(maxWidth: .infinity).frame(height: 56).foregroundStyle(.sponusWhite).background((userID.wholeMatch(of: emailRegexPattern)?.output == nil) ? .sponusGrey600 : .sponusPrimary).padding(.bottom, 16)
                }.disabled(userID.wholeMatch(of: emailRegexPattern)?.output == nil)
                
            }.padding(.horizontal, 20)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: CustomBackButton())
        }
    }
}

#Preview {
    RegisterIDView()
}
