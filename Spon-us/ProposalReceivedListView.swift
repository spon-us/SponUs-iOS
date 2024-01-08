//
//  ProposalReceivedListView.swift
//  Spon-us
//
//  Created by 황인성 on 2024/01/09.
//

import SwiftUI

struct ProposalReceivedListView: View {
    
    
    
    var body: some View {
        // Korean/Body/Body06
        //        Text("현재 받은 제안이 없습니다")
        //            .font(.Body06)
        //          .foregroundColor(Constants.sponusGrey900) //색깔 수정
        
        
        
        VStack(spacing: 0){
            
            ScrollView{
                Rectangle()
                    .foregroundColor(.blue)
                    .frame(width: 335, height: 56)
                //          .background(Constants.sponusSecondary)
                    .overlay(
                        Text("확인하지 않은 제안이 2건 있습니다")
                            .font(.Body06)
                        //                      .foregroundColor(Constants.sponusBlack)
                    )
                
                Text("12.24 SUN")
                    .font(.English01)
                    .frame(maxWidth: .infinity, alignment: .leading)
                //              .foregroundColor(Constants.sponusBlack)
                
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 1)
                //                    .frame(width: 335, height: 1)
                //              .background(Constants.sponusBlack)
                
//                ProposalReceivedCell()
                
                HStack(spacing: 0){
                    Image("ic_sponus")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 158, height: 158)
                        .padding(.trailing, 20)
                    
//                    ZStack{
//                        Rectangle()
////                            .frame(width: 158, height: 158)
//                            .padding(.trailing, 20)
//                            .foregroundColor(.clear)
                        
                    LazyVStack(alignment: .leading){
                            // Korean/Caption/Caption02
                            Text("협찬")
                                .font(.Caption02)
            //                  .foregroundColor(Constants.sponusGrey700)
            //                  .frame(width: 137, alignment: .topLeading)
                        }.padding(.trailing, 20)
//                    }
                    
                    
                }
                .padding(.trailing, 20)
                
            }
            .padding(.horizontal, 20)
            
        }
    }
}


struct ProposalReceivedCell: View {
    var body: some View {
        HStack{
            Image("ic_sponus")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 158, height: 158)
                .padding(.trailing, 20)
            
            VStack{
                // Korean/Caption/Caption02
                Text("협찬")
                    .font(.Caption02)
//                  .foregroundColor(Constants.sponusGrey700)
//                  .frame(width: 137, alignment: .topLeading)
            }
            
            
        }
        .padding(.trailing, 20)
    }
}

#Preview {
    ProposalReceivedListView()
    
}

#Preview {
    ProposalReceivedCell()
}


