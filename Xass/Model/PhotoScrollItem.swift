//
//  PhotoScrollItem.swift
//  Xass
//
//  Created by Ryan Dale Apo on 9/9/22.
//

import Foundation
import UIKit

struct PhotoScrollItem: PhotoScrollItemable {
    var uuid: UUID = UUID()
    var image: UIImage?
    
    static func ==(lhs: PhotoScrollItem, rhs: PhotoScrollItem) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
