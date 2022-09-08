//
//  Selectable.swift
//  Xass
//
//  Created by Ryan Dale Apo on 9/8/22.
//

import Foundation

protocol Selectable {
    var selectionTitle: String { get }
}

extension String: Selectable {
    var selectionTitle: String {
        return self
    }
}

extension Date: Selectable {
    var selectionTitle: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd yyyy"
        return dateFormatter.string(from: self)
    }
}
