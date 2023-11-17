//
//  ProfileTwitterFilter.swift
//  Twitter-NC1
//
//  Created by Edgar Ernesto Vergara Montiel on 17/11/23.
//

import Foundation

enum ProfileTwitterFilter: Int, CaseIterable, Identifiable {
    case posts // = 0
    case likes // = 1
    
    var title: String {
        switch self {
        case .posts: return "Posts"
        case .likes: return "Likes"
        }
    }
    
    var id: Int { return self.rawValue}
}
