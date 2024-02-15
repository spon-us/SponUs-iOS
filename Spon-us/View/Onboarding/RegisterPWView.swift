//
//  RegisterPWView.swift
//  Spon-us
//
//  Created by 박현수 on 2/3/24.
//

import SwiftUI

struct RegisterPWView: View {
    @State var userID: String
    @State private var userPW = ""
    @State private var userPWConfirm = ""
    @State private var isPWSecure = true
    @State private var isPWConfirmSecure = true
    @FocusState var PWSecureFieldFocused: Bool
    @FocusState var PWTextFieldFocused: Bool
    @FocusState var PWConfirmSecureFieldFocused: Bool
    @FocusState var PWConfirmTextFieldFocused: Bool
    
    let PWRegex = /^(?=.*[a-z])(?=.*\d).{10,20}$/
    
    var body: some View {
        @State var isValidPW = (userPW == userPWConfirm) && (userPW.wholeMatch(of: PWRegex)?.output != nil)
        let PWSecureField = SecureField("", text: $userPW, prompt: Text("비밀번호 입력").font(.Body06).foregroundStyle(.sponusGrey600)).focused($PWSecureFieldFocused)
            .font(.English08)
            .padding(.vertical, 16)
            .padding(.horizontal, 20)
            
        let PWTextField = TextField("", text: $userPW, prompt: Text("비밀번호 입력").font(.Body06).foregroundStyle(.sponusGrey600)).focused($PWTextFieldFocused)
            .font(.English08)
            .padding(.vertical, 16)
            .padding(.horizontal, 20)
            
        let PWConfirmSecureField = SecureField("", text: $userPWConfirm, prompt: Text("비밀번호 확인").font(.Body06).foregroundStyle(.sponusGrey600)).focused($PWConfirmSecureFieldFocused)
            .font(.English08)
            .padding(.vertical, 16)
            .padding(.horizontal, 20)
            
        let PWConfirmTextField = TextField("", text: $userPWConfirm, prompt: Text("비밀번호 확인").font(.Body06).foregroundStyle(.sponusGrey600)).focused($PWConfirmTextFieldFocused)
            .font(.English08)
            .padding(.vertical, 16)
            .padding(.horizontal, 20)
            
        
        VStack(spacing: 0) {
            ZStack {
                Rectangle().frame(height: 1).foregroundStyle(.sponusGrey100)
                HStack {
                    Rectangle().frame(width: 252, height: 1).foregroundStyle(.sponusBlack)
                    Spacer()
                }
            }.padding(.top, 8)
            HStack(spacing: 0) {
                Text("로그인에 사용할\n비밀번호를 입력해주세요")
                    .font(.Heading06)
                    .lineSpacing(6)
                    .padding(.top, 28)
                Spacer()
            }
            HStack(spacing: 0) {
                switch isPWSecure {
                case true:
                    PWSecureField
                case false:
                    PWTextField
                }
                Button {
                    isPWSecure.toggle()
                } label: {
                    Image(isPWSecure ? .icEyeOff : .icEyeSmall).resizable()
                        .frame(width: 20, height: 20)
                }.padding(.trailing, 16)
            }.border((PWTextFieldFocused || PWSecureFieldFocused) ? .sponusPrimary : .sponusGrey100).padding(.top, 16).padding(.top, 32)
            HStack(spacing: 0) {
                Text("*영문, 숫자 포함 10-20자 이내").font(.system(size: 12)).foregroundStyle(.sponusGrey900)
                Spacer()
            }.padding(.top, 12)
            HStack(spacing: 0) {
                switch isPWConfirmSecure {
                case true:
                    PWConfirmSecureField
                case false:
                    PWConfirmTextField
                }
                Button {
                    isPWConfirmSecure.toggle()
                } label: {
                    Image(isPWConfirmSecure ? .icEyeOff : .icEyeSmall).resizable()
                        .frame(width: 20, height: 20)
                }.padding(.trailing, 16)
            }.border((PWConfirmTextFieldFocused || PWConfirmSecureFieldFocused) ? .sponusPrimary : ((userPW != userPWConfirm) && !userPWConfirm.isEmpty ? .sponusRed : .sponusGrey100)).padding(.top, 16)
            if !userPWConfirm.isEmpty && !PWTextFieldFocused && !PWSecureFieldFocused && !PWConfirmTextFieldFocused && !PWConfirmSecureFieldFocused && (userPW != userPWConfirm) {
                HStack(spacing: 0) {
                    Image(.icWarning).resizable().frame(width: 16, height: 16).padding(.trailing, 2)
                    Text("비밀번호가 일치하지 않습니다").font(.system(size: 12)).foregroundStyle(.sponusRed)
                    Spacer()
                }.padding(.top, 12)
            }
            Spacer()
            NavigationLink {
                SelectUserTypeView(userID: userID, userPW: userPW)
            } label: {
                Text("다음").font(.Body04).frame(maxWidth: .infinity).frame(height: 56).foregroundStyle(.sponusWhite).background(!isValidPW ? .sponusGrey600 : .sponusPrimary).padding(.bottom, 16)
            }.disabled(!isValidPW)
        }.padding(.horizontal, 20)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackButton())
    }
}

#Preview {
    RegisterPWView(userID: "temp")
}
