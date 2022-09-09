//
//  CategoriesApiService.swift
//  Xass
//
//  Created by Ryan Dale Apo on 9/9/22.
//

import Foundation
import Alamofire

struct DiaryCategory: Codable {
    var id: Int
    var name: String
    var year: Int
    var color: String
    var pantone_value: String
}

struct CategoriesApiResponse: Codable {
    var page: Int
    var per_page: Int
    var total: Int
    var total_pages: Int
    var data: [DiaryCategory]
}

class CategoriesApiService: APIService<CategoriesApiResponse> {
    override var endpoint: String {
        return "/api/categories"
    }
}

extension DiaryCategory: Selectable {
    var selectionTitle: String {
        return name
    }
}
