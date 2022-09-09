//
//  Constants.swift
//  Xass
//
//  Created by Ryan Dale Apo on 9/8/22.
//

import Foundation
import Alamofire

protocol APIClientProtocol {
    var baseUrl: URL { get set }
    var session: Alamofire.Session { get set }
}

class APIClient: APIClientProtocol {
    static let defaultClient = APIClient(baseURL: URL(string: Constants.baseUrl)!)
    
    var baseUrl: URL
    
    lazy var session: Alamofire.Session = {
        var headers = HTTPHeaders.default
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = headers.dictionary
        return Alamofire.Session(configuration: configuration)
    }()
    
    init(baseURL: URL) {
        self.baseUrl = baseURL
    }
    
}
