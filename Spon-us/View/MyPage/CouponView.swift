//
//  CouponView.swift
//  Spon-us
//
//  Created by yubin on 2/3/24.
//

import SwiftUI

struct CouponView: View {
    @State private var couponNumber: String = ""
    @State private var isCouponNumberEntered: Bool = false
    @State private var couponList: [Coupon] = []
    @State var showingCouponPopup = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .firstTextBaseline) {
                TextField("등록할 쿠폰번호를 입력해주세요", text: $couponNumber)
                    .font(.Body06)
                    .padding(.leading, 20)
                    .foregroundColor(Color.sponusBlack)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .overlay(
                        Rectangle()
                            .inset(by: 0.5)
                            .stroke(Color.sponusGrey100, lineWidth: 1)
                    )
                
                Button {
                    showingCouponPopup = true
                    registerCoupon()
                } label: {
                    Text("등록")
                        .font(.Body06)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 18.5)
                        .foregroundColor(isCouponNumberEntered ? Color.sponusWhite : Color.sponusGrey600)
                        .background(isCouponNumberEntered ? Color.sponusBlack : Color.sponusWhite)
                        .overlay(
                            Rectangle()
                                .inset(by: 0.5)
                                .stroke(Color.sponusGrey100, lineWidth: 1)
                        )
                }
                .disabled(couponNumber.isEmpty)
            }
            .padding(.top, 20)
            .onChange(of: couponNumber) { newValue in
                isCouponNumberEntered = !newValue.isEmpty
            }
            
            ScrollView {
                ForEach(couponList, id: \.id) { coupon in
                    CouponItemView(coupon: coupon)
                        .padding(.vertical, 8)
                }
            }
            .padding(.top, 20)
        }
        .popup(isPresented: $showingCouponPopup) {
            registerCouponToastMessage()
        } customize: {
            $0.type(.floater(verticalPadding: 16))
                .position(.bottom)
                .animation(.spring)
                .closeOnTap(false)
                .closeOnTapOutside(true)
                .autohideIn(2)
        }
        .padding(.horizontal, 20)
        .navigationTitle("쿠폰함").font(.Body01)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton())
        .toolbar(.hidden, for: .tabBar)
    }
    
    func registerCouponToastMessage() -> some View {
        Text("쿠폰이 등록 되었습니다")
            .font(.Body03)
            .foregroundStyle(.sponusPrimary)
            .frame(height: 56)
            .frame(maxWidth: .infinity)
            .background(Color.sponusSecondary)
    }
    
    func registerCoupon() {
        guard !couponNumber.isEmpty else { return }
        
        let newCoupon = Coupon(id: UUID(), code: couponNumber)
        couponList.append(newCoupon)
        
        couponNumber = ""
        isCouponNumberEntered = false
    }
}

struct Coupon: Identifiable {
    var id: UUID
    var code: String
}

struct CouponItemView: View {
    let coupon: Coupon
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                Text("1,400")
                    .font(
                        Font.custom("SUIT", size: 30)
                            .weight(.semibold)
                    )
                    .foregroundColor(Color.sponusBlack)
                
                Text("원")
                    .font(Font.custom("Pretendard", size: 14))
                    .foregroundColor(Color.sponusBlack)
                    .padding(.leading, 2)
                    .padding(.top, 10)
            }
            
            Text("스포너스 신규 런칭 이벤트 100% 할인 COUPON")
                .font(
                    Font.custom("Pretendard", size: 12)
                        .weight(.medium)
                )
                .foregroundColor(Color.sponusBlack)
                .padding([.top, .bottom], 4)
            
            Text("사용기한: 2024.12.31 23:59까지")
                .font(Font.custom("Pretendard", size: 12))
                .foregroundColor(Color.sponusGrey700)
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .frame(height: 131)
        .background(Color.sponusWhite)
        .overlay(
            Rectangle()
                .inset(by: 0.5)
                .stroke(Color.sponusBlack, lineWidth: 1)
        )
    }
}

#Preview {
    CouponView()
}
