
import XCTest

final class ExpenseViewerUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch() 
    }
    
    override func tearDownWithError() throws {
        // cleanup if needed
    }
    
    @MainActor
    func testNavigationTitleExists() throws {
        let navigationTitle = app.navigationBars["Expenses"]
        XCTAssertTrue(
            navigationTitle.waitForExistence(timeout: 5.0),
            "Expenses navigation title should appear"
        )
    }
    
    @MainActor
    func testExpenseListLoadsAndDisplaysItems() throws {
        let firstExpense = app.staticTexts["Flight to SF"]
        XCTAssertTrue(
            firstExpense.waitForExistence(timeout: 5.0),
            "Flight to SF should be visible"
        )
    }
    
    @MainActor
    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
