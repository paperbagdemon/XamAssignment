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
    @Published var area: Area?
    @Published var category: DiaryCategory?
    @Published var tags: [Tag]?
    @Published var event: Event?
    @Published var shouldLinkToEvent = false
    
    @Published var selectionAreas: [Area] = [Area]()
    @Published var selectionCategories: [DiaryCategory] = [DiaryCategory]()
    @Published var selectionTags: [Tag] = [Tag]()
    @Published var selectionEvents: [Event] = [Event]()
    
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
        return DiaryApiService(coordinate: coordinate, photos: photos, shouldIncludeInGallery: shouldIncludeInGallery, comments: comments, date: date, area: area, category: category, tags: tags, event: shouldLinkToEvent == true ? event : nil).request()
    }
    
    @discardableResult func fetchCategories() -> Future<CategoriesApiResponse?, Error>? {
        let request = CategoriesApiService().request()
        request.sink { [weak self] error in
            switch error {
            case .failure(_):
                self?.selectionCategories = [DiaryCategory]()
            case .finished: ()
            }
        } receiveValue: { [weak self] response in
            self?.selectionCategories = response?.data ?? [DiaryCategory]()
        }.store(in: &bag)
        return request
    }
    
    @discardableResult func fetchAreas() -> Future<AreaApiResponse?, Error>? {
        let request = AreaApiService().request()
        request.sink { [weak self] error in
            switch error {
            case .failure(_):
                self?.selectionAreas = [Area]()
            case .finished: ()
            }
        } receiveValue: { [weak self] response in
            self?.selectionAreas = response?.data ?? [Area]()
        }.store(in: &bag)
        return request
    }
    
    @discardableResult func fetchEvents() -> Future<EventApiResponse?, Error>? {
        let request = EventsApiService().request()
        request.sink { [weak self] error in
            switch error {
            case .failure(_):
                self?.selectionEvents = [Event]()
            case .finished: ()
            }
        } receiveValue: { [weak self] response in
            self?.selectionEvents = response?.data ?? [Event]()
        }.store(in: &bag)
        return request
    }
    
    @discardableResult func fetchTags() -> Future<TagApiResponse?, Error>? {
        let request = TagsApiService().request()
        request.sink { [weak self] error in
            switch error {
            case .failure(_):
                self?.selectionTags = [Tag]()
            case .finished: ()
            }
        } receiveValue: { [weak self] response in
            self?.selectionTags = response?.data ?? [Tag]()
        }.store(in: &bag)
        return request
    }
    
    func fetchSelections() {
        fetchCategories()
        fetchAreas()
        fetchEvents()
        fetchTags()
    }
    
    func fetchCoordinates() {
        locationService.startService()
    }
}
