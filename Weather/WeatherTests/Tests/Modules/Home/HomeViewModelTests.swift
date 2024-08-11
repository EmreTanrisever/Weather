//
//  HomeViewModelTests.swift
//  WeatherTests
//
//  Created by Emre Tanrısever on 15.07.2024.
//

import XCTest
@testable import Weather

final class HomeViewModelTests: XCTestCase {

    private var homeViewModel: HomeViewModelProtocol!
    private var view: MockHomeViewController!
    
    override func setUp() {
        super.setUp()
        self.view = MockHomeViewController()
        self.homeViewModel = HomeViewModel(view: view)
    }
    
    override func tearDown() {
        super.tearDown()
        self.homeViewModel = nil
        self.view = nil
    }
    
    func test_viewDidLoad_Configure() {
        XCTAssertFalse(view.invokedConfigure)
        XCTAssertEqual(view.invokedConfigureCount, 0)
        homeViewModel.viewDidLoad()
        XCTAssertTrue(view.invokedConfigure)
        XCTAssertEqual(view.invokedConfigureCount, 1)
    }
    
    func test_viewDidLoad_PrepareLocation() {
        XCTAssertFalse(view.invokedPrepareLocation)
        XCTAssertEqual(view.invokedPrepareLocationCount, 0)
        homeViewModel.viewDidLoad()
        XCTAssertTrue(view.invokedConfigure)
        XCTAssertEqual(view.invokedPrepareLocationCount, 1)
    }
    
    func test_homeViewModel_ReturnLocation() {
        XCTAssertEqual(homeViewModel.returnLocation(), [:]) 
    }
}
