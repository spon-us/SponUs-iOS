//
//  EditPostView.swift
//  Spon-us
//
//  Created by 황인성 on 2024/01/15.
//

import SwiftUI
import PhotosUI

struct EditPostView: View {
    
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
            print("disappear")
        }
        //        }
    }
}


struct SponUsTextfieldStyle: TextFieldStyle {
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        
        ZStack {
            Rectangle()
                .fill(Color.clear)
                .stroke(Color.sponusGrey100, lineWidth: 1)
                .frame(maxWidth: .infinity, maxHeight: 56)
            
            // 텍스트필드
            configuration
                .font(.Body06)
                .padding(.horizontal, 20)
                .padding(.vertical, 8)
        }
    }
}


struct SponUsPostCell: View {
    
    var text: String
    @Binding var isComplete: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(text)
                
                if isComplete.isEmpty{
                    Image("ic_check")
                }
                else{
                    Text("")
                }
            }
            
            SponUsDivider()
        }
        
    }
}

struct SponUsPostImageCell: View {
    
    var text: String
    @Binding var selectedImages: [UIImage]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(text)
                
                if selectedImages.isEmpty{
                    Image("ic_check")
                }
                else{
                    Text("")
                }
            }
            
            SponUsDivider()
        }
        
    }
}

//struct SponUsDivider: View {
//    var body: some View {
//        Rectangle()
//            .fill(Color.sponusBlack)
//            .frame(maxWidth: .infinity, maxHeight: 1)
//    }
//}

struct PostRectangleCell: View {
    
    var item: String
    @Binding var selectedString: String
    
    var body: some View {
        
        Button(action: {
            selectedString = item
            print(selectedString)
        }, label: {
            Text(item)
                .font(.Body06)
                .foregroundColor(item == selectedString ? Color.sponusBlack : Color.sponusGrey600)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .lineLimit(1)
                .overlay(
                    Rectangle()
                        .stroke(item == selectedString ? Color.sponusBlack : Color.sponusGrey600, lineWidth: 1)
                        .frame(maxWidth: .infinity)
                )
        })
    }
}



#Preview {
    EditPostView(popup: .constant(false))
}

