//
//  ExpenseListView.swift
//  ExpenseViewer
//
//  Created by chada bhavani on 17/09/26.
//



import SwiftUI

struct ExpenseListView: View {
    @StateObject private var vm = ExpenseViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if vm.isLoading {
                    ProgressView("Fetching Expenses...")
                } else if let error = vm.errorMessage {
                    VStack(spacing: 12) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.orange)
                        Text(error)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                        Button("Retry") {
                            vm.loadExpenses()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                } else if vm.expenses.isEmpty {
                    ContentUnavailableView("No Expenses Found", systemImage: "tray")
                } else {
                    List(vm.expenses) { expense in
                        ExpenseRowView(expense: expense)
                    }
                    .listStyle(.plain)
                    .background(Color(.systemGroupedBackground))
                }
            }
            .navigationTitle("Expenses")
        }
        .task {
            vm.loadExpenses()
        }
    }
}
