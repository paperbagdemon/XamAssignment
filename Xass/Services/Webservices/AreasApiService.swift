//
//  AreaApiService.swift
//  Xass
//
//  Created by Ryan Dale Apo on 9/9/22.
//

import Foundation
import Alamofire

struct Area: Codable {
    var id: Int
    var name: String
    var year: Int
    var color: String
    var pantone_value: String
}

struct AreaApiResponse: Codable {
    var page: Int
    var per_page: Int
    var total: Int
    var total_pages: Int
    var data: [Area]
}

class AreaApiService: APIService<AreaApiResponse> {
    override var endpoint: String {
        return "/api/areas"
    }
}

extension Area: Selectable {
    var selectionTitle: String {
        return name
    }
}
