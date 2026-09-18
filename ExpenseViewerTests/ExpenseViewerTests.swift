

import XCTest

@testable import ExpenseViewer
final class ExpenseViewModelTests: XCTestCase {
    
    func testExpenseSortedByDate() throws {
        let expenses = [
            Expense(id: "2", title: "Hotel",
                   amount: 550.0,
                   date: "2021-08-03T01:50:00+01:00"),
            Expense(id: "1", title: "Flight",
                   amount: 230.5,
                   date: "2021-07-03T01:50:00+01:00")
        ]
        
        let sorted = expenses.sorted { $0.date < $1.date }
        
        XCTAssertEqual(sorted.first?.title, "Flight") 
    }
    
    func testExpenseDecoding() throws {
        let json = """
        [{"id":"1","title":"Flight","amount":230.5,
        "date":"2021-07-03T01:50:00+01:00"}]
        """.data(using: .utf8)!
        
        let expenses = try JSONDecoder().decode([Expense].self, from: json)
        
        XCTAssertEqual(expenses.count, 1)
        XCTAssertEqual(expenses[0].title, "Flight")
        XCTAssertEqual(expenses[0].amount, 230.5)
    }
   
    func testEmptyExpenses() {
        let expenses: [Expense] = []
        let sorted = expenses.sorted { $0.date < $1.date }
        XCTAssertTrue(sorted.isEmpty)
    }

   
    func testSingleExpense() throws {
        let json = """
        [{"id":"1","title":"Flight","amount":230.5,
        "date":"2021-07-03T01:50:00+01:00"}]
        """.data(using: .utf8)!
        
        let expenses = try JSONDecoder().decode([Expense].self, from: json)
        XCTAssertEqual(expenses.count, 1)
    }

   
    func testExpenseAmount() throws {
        let json = """
        [{"id":"1","title":"Flight","amount":230.5,
        "date":"2021-07-03T01:50:00+01:00"}]
        """.data(using: .utf8)!
        
        let expenses = try JSONDecoder().decode([Expense].self, from: json)
        XCTAssertEqual(expenses[0].amount, 230.5)
    }

    func testInvalidJSONDecoding() {
        let invalidJSON = "invalid json".data(using: .utf8)!
        XCTAssertThrowsError(
            try JSONDecoder().decode([Expense].self, from: invalidJSON)
        )
    }

    func testSortOrderMultipleExpenses() {
        let expenses = [
            Expense(id: "3", title: "Taxi",
                   amount: 50.0,
                   date: "2021-09-03T01:50:00+01:00"),
            Expense(id: "1", title: "Flight",
                   amount: 230.5,
                   date: "2021-07-03T01:50:00+01:00"),
            Expense(id: "2", title: "Hotel",
                   amount: 550.0,
                   date: "2021-08-03T01:50:00+01:00")
        ]
        
        let sorted = expenses.sorted { $0.date < $1.date }
        
        XCTAssertEqual(sorted[0].title, "Flight")  // earliest
        XCTAssertEqual(sorted[1].title, "Hotel")   // middle
        XCTAssertEqual(sorted[2].title, "Taxi")    // latest
    }
}
