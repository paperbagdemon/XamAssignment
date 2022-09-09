//
//  TagsApiService.swift
//  Xass
//
//  Created by Ryan Dale Apo on 9/9/22.
//

import Foundation

struct Tag: Codable {
    var id: Int
    var name: String
    var year: Int
    var color: String
    var pantone_value: String
}

struct TagApiResponse: Codable {
    var page: Int
    var per_page: Int
    var total: Int
    var total_pages: Int
    var data: [Tag]
}

class TagsApiService: APIService<TagApiResponse> {
    override var endpoint: String {
        return "/api/tags"
    }
}

extension Tag: Selectable {
    var selectionTitle: String {
        return name
    }
}
