//
//  WeatherViewModelTets.swift
//  WeatherTests
//
//  Created by Emre Tanrısever on 15.07.2024.
//

import XCTest
@testable import Weather

final class WeatherViewModelTest: XCTestCase {
    
    private var view: MockWeatherViewController!
    private var weatherViewModel: WeatherViewModelProtocol!
    private var mockViewModel: MockWeatherViewModel!
    
    override func setUp() {
        super.setUp()
        view = .init()
        weatherViewModel = WeatherViewModel(view: view)
        mockViewModel = .init()
    }
    
    override func tearDown() {
        super.tearDown()
        view = nil
        weatherViewModel = nil
    }
    
    func test_configure() {
        XCTAssertFalse(view.invokedConfigure)
        XCTAssertEqual(view.invokedConfigureCount, 0)
        view.configure(apiKey: "", location: ["key" : 0.0])
        XCTAssertTrue(view.invokedConfigure)
        XCTAssertEqual(view.invokedConfigureCount, 1)
    }
    
    func test_fetchWeatherData_StartSpinnerAnimation() {
        XCTAssertFalse(view.invokedStartSpinnerAnimation)
        XCTAssertEqual(view.invokedStartSpinnerAnimationCount, 0)
        weatherViewModel.fetchWeatherData(apiKey: "", location: ["key": 0.0])
        XCTAssertTrue(view.invokedStartSpinnerAnimation)
        XCTAssertEqual(view.invokedStartSpinnerAnimationCount, 1)
    }
    
    func test_viewDidLoad_SetTitle() {
        XCTAssertFalse(view.invokedSetTitle)
        XCTAssertEqual(view.invokedSetTitleCount, 0)
        weatherViewModel.viewDidLoad()
        XCTAssertTrue(view.invokedSetTitle)
        XCTAssertEqual(view.invokedSetTitleCount, 1)
    }
    
    func test_fetchWeatherData_ReloadTableView() {
        XCTAssertFalse(view.invokedReloadTableView)
        XCTAssertEqual(view.invokedReloadTableViewCount, 0)
    }
    
    func test_weatherViewModel_ViewDidLoad() {
        XCTAssertFalse(mockViewModel.invokedViewDidLoad)
        XCTAssertEqual(mockViewModel.invokedViewDidLoadCount, 0)
        mockViewModel.viewDidLoad()
        XCTAssertTrue(mockViewModel.invokedViewDidLoad)
        XCTAssertEqual(mockViewModel.invokedViewDidLoadCount, 1)
    }
    
    func test_weatherViewModel_FetchWeatherData() {
        XCTAssertFalse(mockViewModel.invokedFetchWeatherData)
        XCTAssertEqual(mockViewModel.invokedFetchWeatherDataCount, 0)
        mockViewModel.fetchWeatherData(apiKey: "", location: ["lat": 0.0])
        XCTAssertTrue(mockViewModel.invokedFetchWeatherData)
        XCTAssertEqual(mockViewModel.invokedFetchWeatherDataCount, 1)
    }
    
    func test_weatherViewModel_FetchWeatherDataStartAnimation() {
        XCTAssertFalse(view.invokedStartSpinnerAnimation)
        XCTAssertEqual(view.invokedStartSpinnerAnimationCount, 0)
        view.startSpinnerAnimation()
        XCTAssertTrue(view.invokedStartSpinnerAnimation)
        XCTAssertEqual(view.invokedStartSpinnerAnimationCount, 1)
    }
    
    func test_weatherViewModel_FetchWeatherDataStopAnimation() {
        XCTAssertFalse(view.invokedStopSpinnerAnimation)
        XCTAssertEqual(view.invokedStopSpinnerAnimationCount, 0)
        view.stopSpinnerAnimation()
        XCTAssertTrue(view.invokedStopSpinnerAnimation)
        XCTAssertEqual(view.invokedStopSpinnerAnimationCount, 1)
    }
    
    func test_weatherViewModel_NumberOfRowInSection() {
        XCTAssertFalse(mockViewModel.invokedNumberOfRowsInSection)
        XCTAssertEqual(mockViewModel.invokedNumberOfRowsInSectionCount, 0)
        let numberOfRowsInSection = mockViewModel.numberOfRowsInSection()
        XCTAssertEqual(numberOfRowsInSection, 0)
        XCTAssertEqual(weatherViewModel.numberOfRowsInSection(), 0)
        XCTAssertTrue(mockViewModel.invokedNumberOfRowsInSection)
        XCTAssertEqual(mockViewModel.invokedNumberOfRowsInSectionCount, 1)
    }
    
    func test_weatherViewModel_ReturnTodayImage() {
        XCTAssertFalse(mockViewModel.invokedReturnTodayImage)
        XCTAssertEqual(mockViewModel.invokedReturnTodayImageCount, 0)
        let _ = mockViewModel.returnTodayImage()
        let _ = weatherViewModel.returnTodayImage()
        XCTAssertTrue(mockViewModel.invokedReturnTodayImage)
        XCTAssertEqual(mockViewModel.invokedReturnTodayImageCount, 1)
    }
    
    func test_weatherViewModel_ReturnImages() {
        XCTAssertFalse(mockViewModel.invokedReturnImages)
        XCTAssertEqual(mockViewModel.invokedReturnImagesCount, 0)
        let images = mockViewModel.returnImages()
        XCTAssertNil(images)
        XCTAssertTrue(mockViewModel.invokedReturnImages)
        XCTAssertEqual(mockViewModel.invokedReturnImagesCount, 1)
    }
    
    func test_weatherViewModel_ReturnLocation() {
        XCTAssertFalse(mockViewModel.invokedReturnLocation)
        XCTAssertEqual(mockViewModel.invokedReturnLocationCount, 0)
        
        mockViewModel.returnLocation(apiKey: "", location: ["lat": 0.0, "lon": 0.0])
        weatherViewModel.returnLocation(apiKey: "", location: ["lat": 0.0, "lon": 0.0])
        
        XCTAssertTrue(mockViewModel.invokedReturnLocation)
        XCTAssertEqual(mockViewModel.invokedReturnLocationCount, 1)
    }
    
    func test_weatherViewModel_ReturnLocationTitle() {
        XCTAssertFalse(mockViewModel.invokedReturnLocationTitle)
        XCTAssertEqual(mockViewModel.invokedReturnLocationCount, 0)
        let title = mockViewModel.returnLocationTitle()
        let nilTitle = weatherViewModel.returnLocationTitle()
        XCTAssertEqual(title, "")
        XCTAssertEqual(nilTitle, ", ")
        XCTAssertTrue(mockViewModel.invokedReturnLocationTitle)
        XCTAssertEqual(mockViewModel.invokedReturnLocationTitleCount, 1)
    }
}
