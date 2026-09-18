//
//  ExpenseViewModel.swift
//  ExpenseViewer
//
//  Created by chada bhavani on 17/09/26.
//

import Foundation
import Combine
@MainActor
class ExpenseViewModel:ObservableObject {
    @Published var isLoading:Bool = false
    @Published var expenses:[Expense] = []
    @Published var errorMessage:String?
    
    private let fetcher = ExpenseFetcher()
    
    func loadExpenses() {
        isLoading = true
        fetcher.fetchExpenses{ [weak self] data,error in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.isLoading = false
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    return
                }
                guard let data = data else {return}
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data)
                    let decoded = try JSONDecoder().decode([Expense].self, from: jsonData)
                    self.expenses = decoded.sorted{$0.date > $1.date
                    }
                }
                catch {
                    self.errorMessage = error.localizedDescription
                }
            }
            
        }
    }
}
