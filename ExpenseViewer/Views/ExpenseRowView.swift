//
//  ExpenseRowView.swift
//  ExpenseViewer
//
//  Created by chada bhavani on 17/09/26.
//
import SwiftUI

struct ExpenseRowView: View {
    let expense: Expense
    var formattedDateWithDay: String {
            struct Formatters {
                static let iso8601 = ISO8601DateFormatter()
                static let display: DateFormatter = {
                    let df = DateFormatter()
                    df.dateFormat = "EEEE, d MMM yyyy"
                    return df
                }()
            }
            
            if let date = Formatters.iso8601.date(from: expense.date) {
                return Formatters.display.string(from: date)
            }
            return expense.date
        }
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(expense.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Text(expense.amount, format: .currency(code: "USD"))
                    .font(.headline)
                    .foregroundColor(.red)
            }
            HStack(spacing: 4) { 
                            Image(systemName: "calendar")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            Text(formattedDateWithDay)
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            Spacer()
                        }
        }
        .padding()
        //.background(Color(.secondarySystemGroupedBackground))
        .background(Color(.systemBackground))  
        .cornerRadius(12)
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .padding(.vertical, 2)
    }
}
