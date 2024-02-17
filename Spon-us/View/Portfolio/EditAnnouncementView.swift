//
//  EditAnnouncementView.swift
//  Spon-us
//
//  Created by 박현수 on 2/16/24.
//

import SwiftUI
import PhotosUI
import Moya

struct EditAnnouncementView: View {
    @StateObject var editAnnouncementViewModel = EditAnnouncementViewModel()
    @State var announcementID: Int?
    @State private var postTitle = ""
    @State private var selectedImages: [UIImage] = []
    @State private var postSelectedCategory = ""
    @State private var postSelectedField = ""
    @State private var postDetail = ""
    
    
    @Binding var popup: Bool
    
    @Environment(\.presentationMode) var presentationMode
    
    let postCategory = ["협찬", "제휴", "연계프로젝트"]
    let postField = ["기획/아이디어", "광고/마케팅", "디자인", "사진/영상", "IT/소프트웨어/게임", "기타"]
    let postField1 = ["기획/아이디어", "광고/마케팅", "디자인"]
    let postField2 = ["사진/영상", "IT/소프트웨어/게임", "기타"]
    
    var body: some View {
        //        NavigationView {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 16){

                    SponUsPostCell(text: "공고 제목", isComplete: $postTitle)
                    
                    TextField("ex. 스포대학교 대학생 협찬", text: $postTitle)
                        .textFieldStyle(SponUsTextfieldStyle())
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
                                        .font(.caption2)
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
                    
                }
                .font(.Heading09)
                .foregroundColor(Color.sponusBlack)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
            
            var compleBtnInActive = postTitle.isEmpty || selectedImages.isEmpty || postSelectedCategory.isEmpty || postSelectedField.isEmpty || postDetail.isEmpty
            
            //                NavigationLink(destination: EmptyView(), label: {
            //                    Text("수정완료")
            //                        .font(.Body01)
            //                        .foregroundColor(compleBtnInActive ? Color.sponusGrey200 : Color.sponusPrimaryDarkmode)
            //                      .frame(maxWidth: .infinity)
            //                      .padding(.top, 20)
            //                      .background(compleBtnInActive ? Color.sponusGrey600 : Color.sponusBlack)
            //                })
            //                .disabled(compleBtnInActive)
            
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
                popup = true
            }, label: {
                Text("수정완료")
                    .font(.Body01)
                    .foregroundColor(compleBtnInActive ? Color.sponusGrey200 : Color.sponusPrimaryDarkmode)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 20)
                    .background(compleBtnInActive ? Color.sponusGrey600 : Color.sponusBlack)
            }).disabled(compleBtnInActive)
        }
        .navigationTitle("게시글 수정").font(.Body01)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton())
        .onDisappear{
            editAnnouncementViewModel.modifyAnnouncement(announcementId: announcementID ?? 0, title: postTitle, type: changeToEnglish(type: postSelectedCategory), category: changeToEnglish(category: postSelectedField), content: postDetail)
            print("disappear")
        }.onAppear() {
            let provider = MoyaProvider<SponusAPI>(plugins: [NetworkLoggerPlugin()])
            
            provider.request(.getAnnouncement(announcementId: self.announcementID ?? 0)) { result in
                switch result {
                case let .success(response):
                    do {
                        let announcementModel = try response.map(AnnouncementModel.self)
                        self.postTitle = announcementModel.content.title
                        self.postSelectedCategory = changeToKorean(type: announcementModel.content.type) ?? "nil"
                        self.postSelectedField = changeToKorean(category: announcementModel.content.category) ?? "nil"
                        self.postDetail = announcementModel.content.content
                    } catch {
                        print(error)
                        print("error")
                        //self.errorMessage = "Error parsing response: \(error)"
                    }

                case let .failure(error):
                    print(error.localizedDescription)
                    print("error")
                }
            }
            
        }
        //        }
    }
}
