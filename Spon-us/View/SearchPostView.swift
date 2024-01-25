//
// SearchPostView.swift
// Spon-us
//
// Created by 김수민 on 1/21/24.
//
import SwiftUI
struct SearchPostView: View {
  @State private var selectedSaveButton: Bool = false
  @State private var isShowingActivityView = false
  @State private var activityItems: [Any] = [URL(string: "https://example.com")!]
  var body: some View {
    VStack(spacing: 0) {
      ScrollView {
        LazyVStack(spacing: 0) {
          ScrollView(.horizontal) {
            LazyHStack(spacing: 10) {
              ForEach(4...6, id: \.self) { index in
                Image("post\(index)")
                  .resizable()
                  .scaledToFill()
                  .frame(width: 335, height: 335)
                  .containerRelativeFrame(.horizontal)
                  .scrollTransition(.animated, axis: .horizontal) { content, phase in
                    content
                      .opacity(phase.isIdentity ? 1.0 : 0.8)
                      .scaleEffect(phase.isIdentity ? 1.0 : 0.8)
                  }
              }
            }
            .scrollTargetLayout()
          }
          .scrollTargetBehavior(.viewAligned)
          .safeAreaPadding(.horizontal, 40.0)
          LazyVStack(alignment: .leading, spacing: 0) {
            HStack(){
              Spacer()
              HStack(spacing: 1){
                Image("ic_eye_small")
                Text("989").font(.English16).foregroundColor(.sponusGrey700)
              }
              HStack(spacing: 1){
                Image("ic_saved_small")
                Text("34").font(.English16).foregroundColor(.sponusGrey700)
              }.padding(.leading, 16)
            }
            NavigationLink {
            } label: {
              HStack {
                Text("무신사")
                  .font(.Body10)
                  .foregroundColor(Color.sponusPrimary)
                Image("ic_go_blue")
                  .frame(width: 16, height: 16)
              }
            }.padding(.top, 23)
            Text("무신사 글로벌 마케팅\n연계 프로젝트")
              .font(.Heading05)
              .foregroundColor(Color.sponusBlack)
              .padding(.top, 16)
            Rectangle()
              .fill(Color.sponusGrey200)
              .frame(maxWidth: .infinity, maxHeight: 1)
              .padding(.top, 16)
            HStack(spacing: 16){
              HStack(){
                Text("유형").font(.Body10).foregroundColor(.sponusGrey700)
                Spacer()
                Text("연계프로젝트").font(.Body10).foregroundColor(.sponusBlack)
              }
              Rectangle()
                .fill(Color.sponusGrey200)
                .frame(width: 1, height: 49)
              HStack(){
                Text("분야").font(.Body10).foregroundColor(.sponusGrey700)
                Spacer()
                Text("기획/아이디어").font(.Body10).foregroundColor(.sponusBlack)
              }
            }.padding(0)
            Rectangle()
              .fill(Color.sponusGrey200)
              .frame(maxWidth: .infinity, maxHeight: 1)
              .padding(0)
            HStack(){
              Text("산업").font(.Body10).foregroundColor(.sponusGrey700)
              Spacer()
              Text("IT 패션 유통").font(.Body10).foregroundColor(.sponusBlack)
              Spacer()
            }.padding(.top, 16)
            SponUsDivider().foregroundColor(.sponusGrey200)
              .padding(.top, 14)
            Text("공고 상세")
              .font(.Body10)
              .foregroundColor(Color.sponusGrey700)
              .padding(.top, 24)
            Text("""
               안녕하세요. 무신사입니다. 글로벌 마케팅 전략 수립을 위해 대학생과의 협업을 진행하려고 합니다. \n \n
               활동기간: 2023년 12월 29일 ~ 2024년 12월 29일
               활동 내용: 카드뉴스 제작, 홍보 영상 제작 등
               자세한 내용은 협의 후에 결정하려고 합니다. 관심 있는 대학생 분들은 제안 부탁드립니다.
               """)
              .font(.Body10)
              .foregroundColor(.sponusBlack)
              .padding(.top, 14)
            SponUsDivider().foregroundColor(.sponusGrey200)
              .padding(.top, 24)
            Spacer().frame(height: 82)
          }
          .padding(.horizontal, 20)
        }
        .padding(.bottom, 20)
      }
      HStack(){
        HStack(spacing: 16){
          Button(action: {
            isShowingActivityView = true
          }) {
            Image("ic_share_white")
              .frame(width: 24, height: 24)
              .padding(.top, 20)
          }.sheet(isPresented: $isShowingActivityView) {
            ActivityView(activityItems: activityItems)
          }
          Button(action: {
            selectedSaveButton.toggle()
          }) {
            Image(selectedSaveButton == true ? "ic_saved_check" : "ic_saved_white")
              .frame(width: 24, height: 24)
              .padding(.top, 20)
          }
        }.padding(.leading, 36)
        NavigationLink(destination: SearchOfferView()){
          Text("제안하기")
            .font(.Body01)
            .foregroundColor(Color.sponusPrimaryDarkmode)
            .frame(maxWidth: .infinity)
            .padding(.top, 20)
        }
      }.background(Color.sponusBlack)
    }
    .navigationTitle("기업 공고").font(.Body01)
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarBackButtonHidden(true)
    .navigationBarItems(leading: CustomBackButton(), trailing: Image("ic_home_black"))
  }
}
struct ActivityView: UIViewControllerRepresentable {
  var activityItems: [Any]
  var applicationActivities: [UIActivity]? = nil
  func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityView>) -> UIActivityViewController {
    let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
    return controller
  }
  func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityView>) {
  }
}
#Preview {
  SearchPostView()
}
