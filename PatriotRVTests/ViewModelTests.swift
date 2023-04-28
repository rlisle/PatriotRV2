//
//  ViewModelTests.swift
//  PatriotRVTests
//
//  Created by Ron Lisle on 2/4/23.
//

import XCTest
@testable import PatriotRV

@MainActor
final class ViewModelTests: XCTestCase {

    var model: ViewModel!
    
    override func setUpWithError() throws {
        model = ViewModel()
    }
    
    func test_init() throws {
        XCTAssertNotNil(model)
    }
    
}
