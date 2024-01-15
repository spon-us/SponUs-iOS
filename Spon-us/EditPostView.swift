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
    @State private var postDetail = ""
    
    let postCategory = ["협찬", "제휴", "연계프로젝트"]
    let postField = ["기획/아이디어", "광고/마케팅", "디자인", "사진/영상", "IT/소프트웨어/게임", "기타"]
    let postField1 = ["기획/아이디어", "광고/마케팅", "디자인"]
    let postField2 = ["사진/영상", "IT/소프트웨어/게임", "기타"]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16){
                
                Text("공고 제목")
                
                SponUsDivider()
                
                TextField("ex. 스포대학교 대학생 협찬", text: $postTitle)
                    .textFieldStyle(SponUsTextfieldStyle())
                    .padding(.bottom, 16)
                
                Text("공고 이미지")
                
                SponUsDivider()
                
                MultipleImagePicker()
                    .padding(.bottom, 16)
                
                Text("유형")
                
                SponUsDivider()
                
                HStack(spacing: 8) {
                    ForEach(postCategory, id: \.self) { item in
                        PostRectangleCell(item: item)
                    }
                }
                .padding(.bottom, 16)
                
                Text("분야")
                
                SponUsDivider()
                
                HStack(spacing: 8) {
                    ForEach(postField1, id: \.self) { item in
                        PostRectangleCell(item: item)
                    }
                }
                
                HStack(spacing: 8) {
                    ForEach(postField2, id: \.self) { item in
                        PostRectangleCell(item: item)
                    }
                }
                .padding(.bottom, 16)
                
                Text("공고 내용")
                
                SponUsDivider()
                
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
        }
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


struct SponUsDivider: View {
    var body: some View {
        Rectangle()
            .fill(Color.sponusBlack)
            .frame(maxWidth: .infinity, maxHeight: 1)
    }
}

struct PostRectangleCell: View {
    
    var item: String
    
    var body: some View {
        Text(item)
            .font(.Body06)
            .foregroundColor(Color.sponusGrey600)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .lineLimit(1)
            .overlay(
                Rectangle()
                    .stroke(Color.sponusGrey600, lineWidth: 1)
                    .frame(maxWidth: .infinity)
            )
    }
}



#Preview {
    EditPostView()
}

