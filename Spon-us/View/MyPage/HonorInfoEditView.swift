//
//  HonorInfoEditView.swift
//  Spon-us
//
//  Created by yubin on 2/4/24.
//

import SwiftUI

struct HonorInfoEditView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var time: String = ""
    @State private var selectedDays: Set<String> = []
    @State private var selectedContact: Set<String> = []
    @State var showingInfoPopup = false
    
    let daysOfWeek = ["월", "화", "수", "목", "금", "토", "일"]
    let contact = ["이메일", "전화", "화상 미팅", "대면 미팅"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ScrollView {
                Text("협력 성사 시에 보이게 될\n컨택 담당자의 정보를 등록합니다.")
                    .font(.Body10)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.sponusBlack)
                    .frame(height: 82)
                    .frame(maxWidth: .infinity)
                    .background(Color.sponusGrey50)
                    .padding(.top, 16)
                    .padding(.bottom, 28)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("연락처")
                        .font(.Heading09)
                        .foregroundColor(Color.sponusBlack)
                    
                    SponUsDivider()
                        .padding(.top, 16)
                    
                    HStack {
                        Text("e-mail")
                            .font(.English08)
                            .foregroundColor(Color.sponusGrey800)
                            .padding(.trailing, 17)
                        
                        TextField("", text: $email, prompt: Text(verbatim: "ex.sponus@gmail.com"))
                            .font(.English08)
                            .padding(.horizontal, 20)
                            .foregroundColor(Color.sponusBlack)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .overlay(
                                Rectangle()
                                    .inset(by: 0.5)
                                    .stroke(Color.sponusGrey100, lineWidth: 1)
                            )
                    }
                    .padding(.top, 24)
                    
                    HStack {
                        Text("phone")
                            .font(.English08)
                            .foregroundColor(Color.sponusGrey800)
                            .padding(.trailing, 20)
                        
                        TextField("", text: $phone, prompt: Text(verbatim: "ex.010-1234-5678"))
                            .font(.English08)
                            .padding(.horizontal, 20)
                            .foregroundColor(Color.sponusBlack)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .overlay(
                                Rectangle()
                                    .inset(by: 0.5)
                                    .stroke(Color.sponusGrey100, lineWidth: 1)
                            )
                    }
                    .padding(.top, 16)
                    
                    Text("연락 가능 시간")
                        .font(.Heading09)
                        .foregroundColor(Color.sponusBlack)
                        .padding(.top, 32)
                    
                    SponUsDivider()
                        .padding(.top, 16)
                    
                    HStack {
                        Text("day")
                            .font(.English08)
                            .foregroundColor(Color.sponusGrey800)
                            .padding(.trailing, 38)
                        
                        ForEach(daysOfWeek, id: \.self) { day in
                            Button(action: {
                                selectDay(day)
                            }) {
                                Text(day)
                                    .font(.Body10)
                                    .foregroundColor(selectedDays.contains(day) ? Color.sponusBlack : Color.sponusGrey600)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 18)
                                    .overlay(
                                        Rectangle()
                                            .stroke(selectedDays.contains(day) ? Color.sponusBlack : Color.sponusGrey100, lineWidth: 1)
                                    )
                            }
                        }
                    }
                    .padding(.top, 24)
                    
                    HStack {
                        Text("time")
                            .font(.English08)
                            .foregroundColor(Color.sponusGrey800)
                            .padding(.trailing, 33)
                        
                        TextField("", text: $time, prompt: Text(verbatim: "ex.14:00 - 18:00"))
                            .font(.English08)
                            .padding(.horizontal, 20)
                            .foregroundColor(Color.sponusBlack)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .overlay(
                                Rectangle()
                                    .inset(by: 0.5)
                                    .stroke(Color.sponusGrey100, lineWidth: 1)
                            )
                    }
                    .padding(.top, 24)
                    
                    Text("선호 연락 방법")
                        .font(.Heading09)
                        .foregroundColor(Color.sponusBlack)
                        .padding(.top, 32)
                    
                    SponUsDivider()
                        .padding(.top, 16)
                    
                    HStack {
                        Text("contact")
                            .font(.English08)
                            .foregroundColor(Color.sponusGrey800)
                            .padding(.trailing, 11)
                        
                        ForEach(contact, id: \.self) { contact in
                            Button(action: {
                                selectContact(contact)
                            }) {
                                Text(contact)
                                    .font(.Body10)
                                    .foregroundColor(selectedContact.contains(contact) ? Color.sponusBlack : Color.sponusGrey600)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 18)
                                    .overlay(
                                        Rectangle()
                                            .stroke(selectedContact.contains(contact) ? Color.sponusBlack : Color.sponusGrey100, lineWidth: 1)
                                    )
                            }
                        }
                    }
                    .padding(.top, 24)
                    .padding(.bottom, 52)
                }
            }
            .padding(.horizontal, 20)
            
            Button {
                showingInfoPopup = true
            } label: {
                Text("확인").font(.Body01)
                    .foregroundStyle(.sponusPrimaryDarkmode)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 20)
            }.background(.sponusBlack)
        }
        .popup(isPresented: $showingInfoPopup) {
            registerInfoToastMessage()
        } customize: {
            $0.type(.floater(verticalPadding: 56))
                .position(.bottom)
                .animation(.spring)
                .closeOnTap(false)
                .closeOnTapOutside(true)
                .autohideIn(2)
        }
        .navigationTitle("담당자 정보 수정하기").font(.Body01)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton())
        .toolbar(.hidden, for: .tabBar)
    }
    
    func selectDay(_ day: String) {
        if selectedDays.contains(day) {
            selectedDays.remove(day)
        } else {
            selectedDays.insert(day)
        }
    }
    
    func selectContact(_ contact: String) {
        if selectedContact.contains(contact) {
            selectedContact.remove(contact)
        } else {
            selectedContact.insert(contact)
        }
    }
    
    func registerInfoToastMessage() -> some View {
        Text("수정이 완료되었습니다")
            .font(.Body03)
            .foregroundStyle(.sponusPrimary)
            .frame(height: 56)
            .frame(maxWidth: .infinity)
            .background(Color.sponusSecondary)
            .onDisappear {
                presentationMode.wrappedValue.dismiss()
            }
            .padding(.horizontal, 20)
    }
}

#Preview {
    HonorInfoEditView()
}
