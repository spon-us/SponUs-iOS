//
//  Order.swift
//  Spon-us
//
//  Created by 황인성 on 2/5/24.
//

import Foundation
import Then
import SwiftUI

class Order: ObservableObject, Then {
    var userCode = PubData()
    var payMethod = PubData()
    var pg = PubData()
    var orderName = PubData()
    var price = PubData()
    var name = PubData()
    var appScheme = PubData()
    var merchantUid = PubData()
    var digital = PubData()
    var cardCode = PubData()
}
