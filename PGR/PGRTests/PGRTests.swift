//
//  PGRTests.swift
//  PGRTests
//
//  Created by Ibram on 26/11/2020.
//  Copyright © 2020 Ibram. All rights reserved.
//

import XCTest
@testable import PGR

class PGRTests: XCTestCase {

    func testAPIHitSuccessful() throws {
        let mocaDataCount = 100
        let expectatin = XCTestExpectation(description: "Request repos from Github")
        let url = URL(string: "\(Bundle.main.baseURL)")
        let task = URLSession.shared.dataTask(with: url!){(data, response, _) in
            if let responseHTTP = response as? HTTPURLResponse{
                XCTAssertEqual(responseHTTP.statusCode, 200)
                if let data = data {
                    do {
                        let model = try JSONDecoder().decode([ReposModel].self, from: data)
                        XCTAssertEqual(model.count, mocaDataCount)
                    }
                    catch {
                        print(error)
                    }
                }
                expectatin.fulfill()
            }
        }
        task.resume()
        wait(for: [expectatin], timeout: 10.0)/// to wait while response back if test failed please increace time in seconds.
    }

}
