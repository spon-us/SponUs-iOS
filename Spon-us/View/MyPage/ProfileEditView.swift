//
//  ProfileEditView.swift
//  Spon-us
//
//  Created by yubin on 2/4/24.
//

import SwiftUI

struct ProfileEditView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name: String = ""
    @State private var introduction: String = ""
    @State var showingEditPopup = false
    
    @State private var link: [Introduction] = []
    
    @State private var openPhoto = false
    @State private var image = UIImage()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ScrollView {
                ZStack {
                    Image("profile_test")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipped()
                    .padding(.top, 36)
                    
                    Image(uiImage: self.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipped()
                        .padding(.top, 36)
                }
                
                Button(action: {
                    self.openPhoto = true
                }) {
                    Text("이미지 수정")
                        .font(.Body10)
                        .foregroundColor(Color.sponusBlack)
                        .padding(.vertical, 12)
                        .frame(width: 100)
                        .overlay(
                            Rectangle()
                                .inset(by: 0.5)
                                .stroke(Color.sponusBlack, lineWidth: 1)
                        )
                }
                .padding(.top, 8)
                .padding(.bottom, 63)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("단체 이름")
                        .font(.Heading09)
                        .foregroundColor(Color.sponusBlack)
                    
                    SponUsDivider()
                        .padding([.top, .bottom], 16)
                    
                    TextField("스포대학교 총학생회", text: $name)
                        .font(.Body06)
                        .padding(.horizontal, 20)
                        .foregroundColor(Color.sponusBlack)
                        //.frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .overlay(
                            Rectangle()
                                .inset(by: 0.5)
                                .stroke(Color.sponusGrey100, lineWidth: 1)
                        )
                    
                    Text("단체 소개")
                        .font(.Heading09)
                        .foregroundColor(Color.sponusBlack)
                        .padding(.top, 32)
                    
                    SponUsDivider()
                        .padding([.top, .bottom], 16)
                    
                    TextField("단체 소개를 작성해 주세요.", text: $introduction, axis: .vertical)
                        .font(.Caption02)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 20)
                        .foregroundColor(Color.sponusBlack)
                        //.frame(maxWidth: .infinity)
                        .overlay(
                            Rectangle()
                                .inset(by: 0.5)
                                .stroke(Color.sponusGrey100, lineWidth: 1)
                        )
                    
                    Text("URL 등록하기")
                        .font(.Heading09)
                        .foregroundColor(Color.sponusBlack)
                        .padding(.top, 32)
                    
                    SponUsDivider()
                        .padding([.top, .bottom], 16)
                    
                    ForEach(link.indices, id: \.self) { index in
                        if link[index].isVisible {
                            HStack {
                                TextField("링크 제목 입력", text: $link[index].title)
                                    .font(.Caption02)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color.sponusBlack)
                                    .padding(.horizontal, 10)
                                    .frame(width: 122, height: 40)
                                    .overlay(
                                        Rectangle()
                                            .inset(by: 0.5)
                                            .stroke(Color.sponusGrey100, lineWidth: 1)
                                    )
                                
                                TextField("URL 입력", text: $link[index].url)
                                    .font(.Caption02)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color.sponusBlack)
                                    .padding(.horizontal, 10)
                                    //.frame(maxWidth: .infinity)
                                    .frame(height: 40)
                                    .overlay(
                                        Rectangle()
                                            .inset(by: 0.5)
                                            .stroke(Color.sponusGrey100, lineWidth: 1)
                                    )
                                
                                Button(action: {
                                    link[index].title = ""
                                    link[index].url = ""
                                    link[index].isVisible = false
                                }) {
                                    Image("ic_x")
                                        .foregroundColor(Color.sponusGrey600)
                                }
                            }
                            .padding(.bottom, 8)
                        }
                    }
                    
                    Button(action: {
                        addIntroduction()
                    }) {
                        Text("추가")
                            .font(.Caption02)
                            .foregroundColor(Color.sponusBlack)
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .overlay(
                                Rectangle()
                                    .inset(by: 0.5)
                                    .stroke(Color.sponusGrey100, lineWidth: 1)
                            )
                    }
                    .padding(.bottom, 47)
                }
            }
            .padding(.horizontal, 20)
            
            Button {
                showingEditPopup = true
            } label: {
                Text("확인").font(.Body01)
                    .foregroundStyle(.sponusPrimaryDarkmode)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 20)
            }.background(.sponusBlack)
        }
        .popup(isPresented: $showingEditPopup) {
            profileEditToastMessage()
        } customize: {
            $0.type(.floater(verticalPadding: 56))
                .position(.bottom)
                .animation(.spring)
                .closeOnTap(false)
                .closeOnTapOutside(true)
                .autohideIn(2)
        }
        .navigationTitle("프로필 수정").font(.Body01)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton())
        .toolbar(.hidden, for: .tabBar)
        .sheet(isPresented: $openPhoto) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
        }
    }
    
    func profileEditToastMessage() -> some View {
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
    
    func addIntroduction() {
        if let hiddenIndex = link.firstIndex(where: { !$0.isVisible }) {
            link[hiddenIndex].isVisible = true
        } else {
            let newIntroduction = Introduction(id: UUID(), title: "", url: "", isVisible: true)
            link.append(newIntroduction)
        }
    }
}

struct Introduction: Identifiable {
    var id: UUID
    var title: String
    var url: String
    var isVisible: Bool
}

#Preview {
    ProfileEditView()
}
