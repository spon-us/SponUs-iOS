//
//  SearchOrganizationModel.swift
//  Spon-us
//
//  Created by 김수민 on 2/17/24.
//

import Foundation

struct SearchOrganizationModel: Codable {
    let statusCode: String
    let message: String
    let content: [SearchOrganizationContent]
}

struct SearchOrganizationContent: Codable, Hashable, Equatable,Identifiable {
    static func == (lhs: SearchOrganizationContent, rhs: SearchOrganizationContent) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: Int
    let name: String
    let image: String?
    let tags: [SearchOrganizationTags]
}

struct SearchOrganizationTags: Codable, Hashable, Equatable, Identifiable {
    static func == (lhs: SearchOrganizationTags, rhs: SearchOrganizationTags) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    let id: Int
    let name: String
}
