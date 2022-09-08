//
//  XassTests.swift
//  XassTests
//
//  Created by Ryan Dale Apo on 9/8/22.
//

import XCTest
@testable import Xass
import Combine

class XassTests: XCTestCase {
    var bag = Set<AnyCancellable>()
    
    func testPostDiaryApi() {
        let expect = expectation(description: "webservice")
        let service = DiaryApiService(coordinate: Coordinates(latitude: 0.0, longitude: 0.0),
                                      photos: [PhotoScrollItem(image: UIImage(systemName: "questionmark"))],
                                      shouldIncludeInGallery: true, comments: "comments",
                                      date: Date(), area: "area", category: "category", tags: ["tag"], event: "event")
        var serviceError: Error?
        var serviceResult: EmptyData?

        service.request()
        .sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                serviceError = error
            case .finished: ()
            }
            expect.fulfill()
        }, receiveValue: { value in
            serviceResult = value
        })
        .store(in: &bag)

        waitForExpectations(timeout: 10.0, handler: nil)
        XCTAssertNil(serviceError, serviceError?.localizedDescription ?? "")
        XCTAssertNotNil(serviceResult, "testPostDiaryApi call failed")
    }
    

}
