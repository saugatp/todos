//
//  TodoViewModel.swift
//  todos
//
//  Created by Saugat Poudel on 03/07/2024.
//

import Foundation

@MainActor
class TodoViewModel: ObservableObject{
    @Published var todos: [TodoItem] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let apiService = ApiServicee()
    
    func fetchItems() async {
           isLoading = true
           do {
               todos = try await apiService.fetchTodos()
           } catch {
               errorMessage = "Failed to fetch items: \(error.localizedDescription)"
           }
           isLoading = false
       }
    
    func addItem(task: String) async {
            let newItem = TodoItem(task: task)
            do {
                try await apiService.addTodo(newItem)
                await fetchItems()
            } catch {
                errorMessage = "Failed to add item: \(error.localizedDescription)"
            }
        }
    func updateTask(id: Int) async{
        if let index = todos.firstIndex(where: { $0.id == id} ) {
            let completed = !todos[index].isCompleted
            do {
                try await apiService.updateTodo(id: id, isCompleted: completed)
                await fetchItems()
            } catch {
                errorMessage = "Failed to update item: \(error.localizedDescription)"
            }
        }
    }
}
