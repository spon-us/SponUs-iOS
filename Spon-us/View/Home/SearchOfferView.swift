//
//  SearchOfferView.swift
//  Spon-us
//
//  Created by 김수민 on 1/22/24.
//

import SwiftUI
import PopupView
import UniformTypeIdentifiers
import MobileCoreServices
import Moya

struct SearchOfferView: View {
    let announcementId: Int
    
    @State private var postTitle = ""
    @State private var postDetail = ""
    @State private var selectedURLsFile1: [URL] = []
    @State private var selectedURLsFile2: [URL] = []
    @State private var selectedURLsFile3: [URL] = []
    @State private var isDocumentPicker1Presented = false
    @State private var isDocumentPicker2Presented = false
    @State private var isDocumentPicker3Presented = false
    @State private var fileButton1Text = "파일 선택"
    @State private var fileButton2Text = "파일 선택"
    @State private var fileButton3Text = "파일 선택"
    
    @State var showingPopup = false
    @State var showingPreviewAlert = false
    @State var goToPreview = false
    
    @FocusState var focusTitleTextEditor: Bool
    @FocusState var focusContentsTextEditor: Bool
    
    
    @Environment(\.presentationMode) var presentationMode

    func createPopup() -> some View {
        HStack {
            Text("작성이 완료되었습니다").font(.Body03).foregroundStyle(.sponusPrimary)
        }.frame(height: 56).frame(maxWidth: .infinity).background(Color.sponusSecondary)
    }
    
    var body: some View {
        let postTitleTextEditor = TextEditor(text: $postTitle)
                                    .font(.Body06)
                                    .frame(height: 24)
        let postContentsTextEditor = TextEditor(text: $postDetail)
                                        .frame(minHeight: 130)
                                        .font(.Caption02)
        let compleBtnInActive = postTitle.isEmpty || postDetail.isEmpty
        
        ZStack {
            VStack(spacing: 0) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16){
                        
                        SponUsPostCell(text: "제안서 제목", isComplete: $postTitle).padding(.top, 16)
                        
                        ZStack (alignment: .leading) {
                            HStack{
                                Text("").frame(maxWidth: .infinity).frame(height: 56)
                            }
                            VStack {
                                Spacer()
                                postTitleTextEditor.focused($focusTitleTextEditor, equals: true).padding(.horizontal, 12)
                                Spacer()
                            }
                            VStack {
                                Spacer()
                                if postTitle.isEmpty {
                                    Button(action: {
                                        focusTitleTextEditor = true
                                        print("focusTitle")
                                    }) {
                                        VStack {
                                            Text("ex. 대동제 협찬 보고서")
                                                .font(.Body06)
                                                .foregroundStyle(.sponusGrey600)
                                        }
                                    }.buttonStyle(CustomButtonStyle())
                                        .padding(.horizontal)
                                }
                                Spacer()
                            }
                            
                        }.border(.sponusGrey100)
                    
                        SponUsPostCell(text: "제안서 내용", isComplete: $postDetail).padding(.top, 16)
                        
                        ZStack (alignment: .leading) {
                            
                            HStack{
                                Text("").frame(maxWidth: .infinity).frame(minHeight: 162)
                            }
                            VStack {
                                Spacer()
                                postContentsTextEditor.focused($focusContentsTextEditor, equals: true).padding(.horizontal, 12).lineSpacing(5)
                                Spacer()
                            }
                            VStack {
                                if postDetail.isEmpty {
                                    Button(action: {
                                        focusContentsTextEditor = true
                                        print("focusContents")
                                    }) {
                                        VStack {
                                            Text("제안서에 대한 자세한 내용을 적어주세요.\nex. 진행 배경, 진행 내용, 기대 효과, 희망 사항")
                                                .font(.Caption02)
                                                .foregroundStyle(.sponusGrey600)
                                                .lineSpacing(5)
                                        }
                                    }.buttonStyle(CustomButtonStyle())
                                        .padding(.top, 12)
                                        .padding(.horizontal)
                                }
                                Spacer()
                            }
                        }.border(.sponusGrey100)
                        
                        SponUsPostFileCell(text: "파일 첨부", selectedURLsFile1: $selectedURLsFile1, selectedURLsFile2: $selectedURLsFile2, selectedURLsFile3: $selectedURLsFile3).padding(.top, 16)
                     
                        HStack {
                            Text(fileButton1Text).font(.Body10).foregroundStyle(fileButton1Text == "파일 선택" ? .sponusGrey700 : .sponusBlack).padding(.leading, 20)
                            Spacer()
                            Button {
                                if (fileButton1Text != "파일 선택") {
                                    fileButton1Text = "파일 선택"
                                }
                                else {
                                    isDocumentPicker1Presented.toggle()
                                }
                                selectedURLsFile1 = []
                            }
                            label: {
                                Image(fileButton1Text == "파일 선택" ? .icUpload : .icCancel).resizable().frame(width: 24, height: 24)
                            }.fileImporter(
                                isPresented: $isDocumentPicker1Presented,
                                allowedContentTypes: [UTType.pdf,
                                                      UTType.doc,
                                                      UTType.docx,
                                                      UTType.hwp,
                                                      UTType.hwpx,
                                                      UTType.ppt,
                                                      UTType.pptx],
                                allowsMultipleSelection: false,
                                onCompletion: { result in
                                    do {
                                        selectedURLsFile1 = try result.get()
                                        fileButton1Text = selectedURLsFile1[0].lastPathComponent
                                    } catch {
                                        print(error.localizedDescription)
                                    }
                                }
                            )
                            .padding(.trailing, 20)
                        }.padding(.vertical, 16).border(.sponusGrey100)
                        HStack {
                            Text(fileButton2Text).font(.Body10).foregroundStyle(fileButton2Text == "파일 선택" ? .sponusGrey700 : .sponusBlack).padding(.leading, 20)
                            Spacer()
                            Button {
                                if (fileButton2Text != "파일 선택") {
                                    fileButton2Text = "파일 선택"
                                }
                                else {
                                    isDocumentPicker2Presented.toggle()
                                }
                                selectedURLsFile2 = []
                            }
                            label: {
                                Image(fileButton2Text == "파일 선택" ? .icUpload : .icCancel).resizable().frame(width: 24, height: 24)
                            }.fileImporter(
                                isPresented: $isDocumentPicker2Presented,
                                allowedContentTypes: [UTType.pdf,
                                                      UTType.doc,
                                                      UTType.docx,
                                                      UTType.hwp,
                                                      UTType.hwpx,
                                                      UTType.ppt,
                                                      UTType.pptx],
                                allowsMultipleSelection: false,
                                onCompletion: { result in
                                    do {
                                        selectedURLsFile2 = try result.get()
                                        fileButton2Text = selectedURLsFile2[0].lastPathComponent
                                    } catch {
                                        print(error.localizedDescription)
                                    }
                                }
                            ).padding(.trailing, 20)
                        }.padding(.vertical, 16).border(.sponusGrey100)
                        HStack {
                            Text(fileButton3Text).font(.Body10).foregroundStyle(fileButton3Text == "파일 선택" ? .sponusGrey700 : .sponusBlack).padding(.leading, 20)
                            Spacer()
                            Button {
                                if (fileButton3Text != "파일 선택") {
                                    fileButton3Text = "파일 선택"
                                }
                                else {
                                    isDocumentPicker3Presented.toggle()
                                }
                                selectedURLsFile3 = []
                            }
                            label: {
                                Image(fileButton3Text == "파일 선택" ? .icUpload : .icCancel).resizable().frame(width: 24, height: 24)
                            }.fileImporter(
                                isPresented: $isDocumentPicker3Presented,
                                allowedContentTypes: [UTType.pdf,
                                                      UTType.doc,
                                                      UTType.docx,
                                                      UTType.hwp,
                                                      UTType.hwpx,
                                                      UTType.ppt,
                                                      UTType.pptx],
                                allowsMultipleSelection: false,
                                onCompletion: { result in
                                    do {
                                        selectedURLsFile3 = try result.get()
                                        fileButton3Text = selectedURLsFile3[0].lastPathComponent
                                    } catch {
                                        print(error.localizedDescription)
                                    }
                                }
                            ).padding(.trailing, 20)
                        }.padding(.vertical, 16).border(.sponusGrey100)

                        Text("도움이 될 만한 자료를 첨부해주세요. (word, hwp, pdf, ppt)")
                            .font(.Caption02)
                            .foregroundStyle(.sponusGrey600)
                            .padding(.bottom, 16)
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
                        }.padding(.bottom, 55)
                        
                        Spacer().frame(height: 62)
                    }
                    .font(.Heading09)
                    .foregroundColor(Color.sponusBlack)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
                Button(action: {
                    showingPopup = true
                    sendAPI()
                }, label: {
                    Text("작성완료")
                        .font(.Body01)
                        .foregroundColor(compleBtnInActive ? Color.sponusGrey200 : Color.sponusPrimaryDarkmode)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 20)
                        .background(compleBtnInActive ? Color.sponusGrey600 : Color.sponusBlack)
                }).disabled(compleBtnInActive)
                
            }
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
        .alert(isPresented: $showingPreviewAlert) {
            Alert(
                title: Text("필수기입란 미입력"),
                message: Text("필수기입란을 모두 입력하세요.")
            )
        }
        .navigationTitle("제안하기").font(.Body01)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton())
    }
}

extension SearchOfferView {
    func sendAPI() {
        let provider = MoyaProvider<SponusAPI>(session: Session(interceptor: AuthInterceptor.shared))
        provider.request(.propose(title: postTitle, content: postDetail, announcementId: announcementId, attachments: selectedURLsFile1 + selectedURLsFile2 + selectedURLsFile3)) { result in
            print(announcementId)
            switch result {
            case .success(let response):
                print("Success: \(response)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
