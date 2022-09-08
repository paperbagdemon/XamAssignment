//
//  HomeViewModel.swift
//  Xass
//
//  Created by Ryan Dale Apo on 9/8/22.
//

import Foundation
import Alamofire
import Combine

class HomeViewModel: ObservableObject {
    var bag = Set<AnyCancellable>()
    @Published private var locationService = LocationService.defaultService
    
    @Published var coordinate = Coordinates(latitude: 0, longitude: 0)
    @Published var currentLocation = ""
    @Published var photos = [PhotoScrollItem]()
    @Published var shouldIncludeInGallery = false
    @Published var comments = ""
    @Published var date = Date()
    @Published var area = ""
    @Published var category = ""
    @Published var tags: [String]?
    @Published var event: String?
    @Published var shouldLinkToEvent = false
    
    @Published var selectionAreas: [String] = [String]()
    @Published var selectionCategories: [String] = [String]()
    @Published var selectionTags: [String] = [String]()
    @Published var selectionEvents: [String] = [String]()
    
    init() {
        locationService.objectWillChange.sink { [weak self] _ in
            guard let myself = self else {
                return
            }
            myself.coordinate = myself.locationService.coordinates ?? Coordinates(latitude: 0, longitude: 0)
            myself.currentLocation = "\(myself.locationService.coordinates?.latitude ?? 0),\(myself.locationService.coordinates?.longitude ?? 0)"
            myself.objectWillChange.send()
        }.store(in: &bag)
        locationService.startService()
    }
    
    // MARK: Webservices
    @discardableResult func submitDiary() -> Future<EmptyData?, Error>? {
        return DiaryApiService.init(coordinate: coordinate, photos: photos, shouldIncludeInGallery: shouldIncludeInGallery, comments: comments, date: date, area: area, category: category, tags: tags, event: shouldLinkToEvent == true ? event : nil).request()
    }
    
    func fetchCoordinates() {
        locationService.startService()
    }
}
