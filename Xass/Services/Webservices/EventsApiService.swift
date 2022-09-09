//
//  EventsApiService.swift
//  Xass
//
//  Created by Ryan Dale Apo on 9/9/22.
//

import Foundation

struct Event: Codable {
    var id: Int
    var name: String
    var year: Int
    var color: String
    var pantone_value: String
}

struct EventApiResponse: Codable {
    var page: Int
    var per_page: Int
    var total: Int
    var total_pages: Int
    var data: [Event]
}

class EventsApiService: APIService<EventApiResponse> {
    override var endpoint: String {
        return "/api/events"
    }
}

extension Event: Selectable {
    var selectionTitle: String {
        return name
    }
}
