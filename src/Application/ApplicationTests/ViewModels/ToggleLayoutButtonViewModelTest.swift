//
//  ToggleLayoutButtonViewModelTest.swift
//  ApplicationTests
//
//  Created by Irving Huang on 2023/8/26.
//

import XCTest

import TMDB_User_Core

@testable import Application

class ToggleLayoutButtonViewModelTest: XCTestCase {
    
    var viewModel: ToggleLayoutButtonViewModel!
    var mockSettingService: MockSettingService!
    
    override func setUp() {
        
        super.setUp()
        
        mockSettingService = MockSettingService()
        
        viewModel = ToggleLayoutButtonViewModel()
        viewModel.settingService = mockSettingService
        
    }
    
    func testCheckRowCount_ReturnsRowCount() {

        let expectation = self.expectation(description: "Check count expectation")
        
        try? mockSettingService.set(key: "LayoutStyle", value: "3")
        
        viewModel.checkRowCount {
            
            XCTAssertEqual(self.viewModel.isBlock, true)
            expectation.fulfill()
            
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
        
    }
    
    func testSetBlock_SetCorrectly() {

        viewModel.isBlock = false
        viewModel.setBlock(isBlock: true)

        XCTAssertEqual(viewModel.isBlock, true)
        XCTAssertEqual(mockSettingService.settings["LayoutStyle"], "3")
        
    }
    
    func testNotificationHandler_ChangesLayout() {

        viewModel.isBlock = false

        NotificationCenter.default.post(name: .DidUpdateLayout, object: nil, userInfo: ["rowCount": 3])

        XCTAssertEqual(viewModel.isBlock, true)
        
    }
    
    override func tearDown() {
        viewModel = nil
        mockSettingService = nil
        super.tearDown()
    }
    
}
