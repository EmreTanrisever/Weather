//
//  MapViewModelTests.swift
//  WeatherTests
//
//  Created by Emre Tanrısever on 21.07.2024.
//

import XCTest
@testable import Weather

final class MapViewModelTests: XCTestCase {
    
    private var mockMapView: MockMapView!
    private var viewModel: MapViewModelProtocol!
    
    override func setUp() {
        super.setUp()
        
        self.mockMapView = .init()
        self.viewModel = MapViewModel(view: mockMapView)
    }
    
    override func tearDown() {
        super.tearDown()
        self.mockMapView = nil
        self.viewModel = nil
    }
    
    func test_viewModel_Configure() {
        XCTAssertFalse(mockMapView.invokedConfigure)
        XCTAssertEqual(mockMapView.invokedConfigureCount, 0)
        
        viewModel.viewDidLoad()
        
        XCTAssertTrue(mockMapView.invokedConfigure)
        XCTAssertEqual(mockMapView.invokedConfigureCount, 1)
    }
}
