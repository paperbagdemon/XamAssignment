//
//  DiaryApiService.swift
//  Xass
//
//  Created by Ryan Dale Apo on 9/8/22.
//

import Foundation
import Alamofire


class DiaryApiService: APIService<EmptyData> {
    
    var coordinate: Coordinates?
    var photos: [PhotoScrollItem]?
    var shouldIncludeInGallery: Bool?// i have no idea with this
    var comments: String?
    var date: Date?
    var area: Area?
    var category: DiaryCategory?
    var tags: [Tag]?
    var event: Event?
    
    init(coordinate: Coordinates?, photos: [PhotoScrollItem]?, shouldIncludeInGallery: Bool?, comments: String?, date: Date?, area: Area?, category: DiaryCategory?, tags: [Tag]?, event: Event?, client: APIClient = APIClient.defaultClient) {
        super.init(client: client)
        self.coordinate = coordinate
        self.photos = photos
        self.shouldIncludeInGallery = shouldIncludeInGallery
        self.comments = comments
        self.date = date
        self.area = area
        self.category = category
        self.tags = tags
        self.event = event
    }
    
    override var parameters: Parameters {
        var parameters: Parameters = [:]
        
        parameters["latitude"] = coordinate?.latitude
        parameters["longitude"] = coordinate?.longitude
        parameters["shouldIncludeInGallery"] = shouldIncludeInGallery
        parameters["comments"] = comments
        parameters["date"] = date?.toApiDate
        parameters["area"] = area
        parameters["category"] = category?.id
        parameters["tags"] = tags
        parameters["event"] = event
        var paramImages = [String]()
        photos?.forEach({ photo in
            paramImages.append(photo.image?.jpegData(compressionQuality: 0.8)?.base64EncodedString() ?? "")
        })
        parameters["photos"] = paramImages

        
        
        return parameters
    }
    
    override var httpMethod: Alamofire.HTTPMethod {
        return Alamofire.HTTPMethod.post
    }
    
    override var endpoint: String {
        return "/api/diary"
    }
}
