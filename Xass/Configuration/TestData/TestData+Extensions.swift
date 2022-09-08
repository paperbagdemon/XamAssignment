//
//  TestData+Extensions.swift
//  Xass
//
//  Created by Ryan Dale Apo on 9/9/22.
//

import Foundation

extension HomeViewModel {
    //MARK: mock data
    func loadTestData() {
        selectionAreas = loadJson("areas") ?? [String]()
        selectionCategories = loadJson("categories") ?? [String]()
        selectionTags = loadJson("tags") ?? [String]()
        selectionEvents = loadJson("events") ?? [String]()
        
    }
    
    func loadJson<T: Decodable>(_ fileName: String) -> T? {
        if let areaUrl = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: areaUrl)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(T.self, from: data)
                return jsonData
            } catch {
                return nil
            }
        }
        return nil
    }
}
