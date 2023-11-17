//
//  Timestamp.swift
//  Twitter-NC1
//
//  Created by Edgar Ernesto Vergara Montiel on 17/11/23.
//

import Foundation
import FirebaseFirestore

extension Timestamp {
    func timestampString() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        
        return formatter.string(from: self.dateValue(), to: Date()) ?? ""
    }
}
