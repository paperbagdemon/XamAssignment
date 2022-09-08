//
//  Api+Extensions.swift
//  Xass
//
//  Created by Ryan Dale Apo on 9/8/22.
//

import Foundation

extension Date {
    var toApiDate: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        return dateFormatter.string(from: self)
    }
}
