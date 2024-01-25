//
//  NewPostView.swift
//  Spon-us
//
//  Created by 김수민 on 1/22/24.
//

import SwiftUI
import PopupView
import UniformTypeIdentifiers
import MobileCoreServices


struct NewPostView: View {
    
    @State private var postTitle = ""
    @State private var selectedImages: [UIImage] = []
    @State private var postSelectedCategory = ""
    @State private var postSelectedField = ""
    @State private var postDetail = ""
    
    @State var showingPopup = false
    @State var showingPreviewAlert = false
    @State var goToPreview = false
    @Binding var popup: Bool
    
    @Environment(\.presentationMode) var presentationMode
    func createPopup() -> some View {
        HStack {
            Text("작성이 완료되었습니다").font(.Body03).foregroundStyle(.sponusPrimary)
        }.frame(height: 56).frame(maxWidth: .infinity).background(Color.sponusSecondary)
    }
    
    let postCategory = ["협찬", "제휴", "연계프로젝트"]
    let postField = ["기획/아이디어", "광고/마케팅", "디자인", "사진/영상", "IT/소프트웨어/게임", "기타"]
    let postField1 = ["기획/아이디어", "광고/마케팅", "디자인"]
    let postField2 = ["사진/영상", "IT/소프트웨어/게임", "기타"]
    
    var body: some View {
        //        NavigationView {
        VStack(spacing: 0) {
            var compleBtnInActive = postTitle.isEmpty || selectedImages.isEmpty || postSelectedCategory.isEmpty || postSelectedField.isEmpty || postDetail.isEmpty
            ScrollView {
                VStack(alignment: .leading, spacing: 16){
                    
                    SponUsPostCell(text: "공고 제목", isComplete: $postTitle).padding(.top, 10)
                    
                    TextField("ex. 스포대학교 대학생 협찬", text: $postTitle)
                        .textFieldStyle(SponUsTextfieldStyle())
                        .frame(height: 56)
                        .padding(.bottom, 16)
                    
                    SponUsPostImageCell(text: "공고 이미지", selectedImages: $selectedImages)
                    
                    //                SponUsDivider()
                    
                    MultipleImagePicker(selectedImages: $selectedImages)
                        .padding(.bottom, 16)
                    
                    SponUsPostCell(text: "유형", isComplete: $postSelectedCategory)
                    
                    HStack(spacing: 8) {
                        ForEach(postCategory, id: \.self) { item in
                            PostRectangleCell(item: item, selectedString: $postSelectedCategory)
                        }
                    }
                    .padding(.bottom, 16)
                    
                    SponUsPostCell(text: "분야", isComplete: $postSelectedField)
                    
                    HStack(spacing: 8) {
                        ForEach(postField1, id: \.self) { item in
                            PostRectangleCell(item: item, selectedString: $postSelectedField)
                        }
                    }
                    
                    HStack(spacing: 8) {
                        ForEach(postField2, id: \.self) { item in
                            PostRectangleCell(item: item, selectedString: $postSelectedField)
                        }
                    }
                    .padding(.bottom, 16)
                    
                    SponUsPostCell(text: "공고 내용", isComplete: $postDetail)
                    
                    ZStack {
                        
                        Rectangle()
                            .stroke(Color.sponusGrey100, lineWidth: 1)
                            .fill(Color.clear)
                            .frame(maxWidth: .infinity, minHeight: 225)
                            .overlay(
                                VStack {
                                    Text("공고에 대한 자세한 내용을 적어주세요.\nex. 진행 배경, 진행 내용, 기대 효과, 희망 사항")
                                        .font(.Caption02)
                                        .padding(.top, 20)
                                        .foregroundColor(postDetail.isEmpty ? Color.sponusGrey600 : Color.clear)
                                    
                                    Spacer()
                                }
                            )
                            .zIndex(1.0)
                        
                        TextEditor(text: $postDetail)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 8)
                        
                    }
                    
                    HStack {
                        Spacer()
                        Button {
                            if (compleBtnInActive == true) {
                                showingPreviewAlert = true
                            }
                            else {
                                goToPreview = true
                            }
                        }
                    label: {
                        Text("미리보기").font(.Body10).foregroundStyle(.sponusGrey700).frame(width: 73, height: 37)
                    }.border(.sponusGrey700)
                        Spacer()
                    }.padding(.top, 32)
                    
                    Spacer().frame(height: 127)
                    
                }
                .font(.Heading09)
                .foregroundColor(Color.sponusBlack)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
            
            Button(action: {
//                self.presentationMode.wrappedValue.dismiss()
                showingPopup = true
            }, label: {
                Text("작성 완료")
                    .font(.Body01)
                    .foregroundColor(compleBtnInActive ? Color.sponusGrey200 : Color.sponusPrimaryDarkmode)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 20)
                    .background(compleBtnInActive ? Color.sponusGrey600 : Color.sponusBlack)
            }).disabled(compleBtnInActive)
            .navigationDestination(isPresented: $goToPreview) {
                    
            }
        }.popup(isPresented: $showingPopup) {
            createPopup().onDisappear(){
                self.presentationMode.wrappedValue.dismiss()
            }
        } customize: {
            $0.type(.floater(verticalPadding: 16))
              .position(.bottom)
              .animation(.spring)
              .closeOnTap(true)
              .closeOnTapOutside(true)
              .autohideIn(2)
        }
        .navigationTitle("새 공고 작성").font(.Body01)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton())
        .toolbar(.hidden, for: .tabBar)
        .onDisappear{
            print("disappear")
        }
    }
}
#Preview {
    NewPostView(popup: .constant(false))
}

