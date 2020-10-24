//
//  CodeChallengeTests.swift
//  CodeChallengeTests
//
//  Created by Mounika Jakkampudi on 10/12/20.
//  Copyright © 2020 MVVM. All rights reserved.
//

import XCTest
@testable import CodeChallenge

class CodeChallengeTests: XCTestCase {
    var dataTableVC : DataTableViewController!
    let model = DataViewModel()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        dataTableVC = DataTableViewController()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTableviewDelegates() {
        XCTAssertEqual(self.dataTableVC.numberOfSections(in: self.dataTableVC.tableView), 1)
        XCTAssertEqual(self.dataTableVC.tableView(self.dataTableVC.tableView, numberOfRowsInSection: 1), self.dataTableVC.dataViewModel.getChildrenObjectCount())
    }
    func testAsyncAPICall() {
        let asyncExpectation = expectation(description: "Getting json Dictionary from REST")
        model.fetchChildrensList { (result) in
            switch result {
            case .failure(let error) :
                XCTAssertNil(error)
            case .success(let success) :
                XCTAssertTrue(success)
            }
            asyncExpectation.fulfill()
        }
         // after fulfillment
        waitForExpectations(timeout: 10) { (error:Error?) in
            XCTAssertNil(error)
            self.dataTableVC.dataViewModel = self.model
            self.testTableviewDelegates()
        }
    }
    func testAPIPerformance() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            testAsyncAPICall()
        }
    }

}
