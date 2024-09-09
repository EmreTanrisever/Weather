//
//  SplashViewModelTests.swift
//  WeatherTests
//
//  Created by Emre Tanrısever on 15.07.2024.
//

import XCTest
@testable import Weather

final class SplashViewModelTests: XCTestCase {

    private var splashViewModel: SplashViewModelProtocol!
    private var view: MockSplashViewController!
    
    override func setUp() {
        super.setUp()
        self.view = MockSplashViewController()
        self.splashViewModel = SplashViewModel(view: view)
    }
    
    override func tearDown() {
        super.tearDown()
        self.splashViewModel = nil
        self.view = nil
    }
    
    func test_viewDidLoad_Configure() {
        XCTAssertFalse(view.invokedConfigure)
        XCTAssertEqual(view.invokedConfigureCount, 0)
        splashViewModel.viewDidLoad()
        XCTAssertTrue(view.invokedConfigure)
        XCTAssertEqual(view.invokedConfigureCount, 1)
    }
    
    func test_viewDidLoad_PrepareLocation() {
        XCTAssertFalse(view.invokedPrepareLocation)
        XCTAssertEqual(view.invokedPrepareLocationCount, 0)
        splashViewModel.viewDidLoad()
        XCTAssertTrue(view.invokedConfigure)
        XCTAssertEqual(view.invokedPrepareLocationCount, 1)
    }
    
    func test_splashViewModel_ReturnLocation() {
        XCTAssertEqual(splashViewModel.returnLocation(), [:])
    }
    
    func test_splashViewModel_Alert() {
        XCTAssertFalse(view.invokedAlert)
        XCTAssertEqual(view.invokedAlertCount, 0)
        
        splashViewModel.alert()
        
        XCTAssertTrue(view.invokedAlert)
        XCTAssertEqual(view.invokedAlertCount, 1)
    }
    
    func test_splashViewModel_ConfigureAnimation() {
        XCTAssertFalse(view.invokedConfigureAnimation)
        XCTAssertEqual(view.invokedConfigureCount, 0)
        
        splashViewModel.viewDidLoad()
        
        XCTAssertTrue(view.invokedConfigureAnimation)
        XCTAssertEqual(view.invokedConfigureAnimationCount, 1)
    }
    
    func test_splashViewModel_PlayAnimation() {
        XCTAssertFalse(view.invokedPlayAnimation)
        XCTAssertEqual(view.invokedPlayAnimationCount, 0)
        
        splashViewModel.viewDidLoad()
        
        XCTAssertTrue(view.invokedPlayAnimation)
        XCTAssertEqual(view.invokedPlayAnimationCount, 1)
    }
    
    func test_splashViewModel_StopAnimation() {
        XCTAssertFalse(view.invokedStopAnimation)
        XCTAssertEqual(view.invokedStopAnimationCount, 0)
        
        splashViewModel.viewDidLoad()
        
        XCTAssertTrue(view.invokedStopAnimation)
        XCTAssertEqual(view.invokedStopAnimationCount, 1)
    }
    
    func test_splashViewModel_ShowAlert() {
        XCTAssertFalse(view.invokedAlert)
        XCTAssertEqual(view.invokedAlertCount, 0)
        
        splashViewModel.alert()
        
        XCTAssertTrue(view.invokedAlert)
        XCTAssertEqual(view.invokedAlertCount, 1)
    }
}
