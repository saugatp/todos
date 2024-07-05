//
//  ApiServicee.swift
//  todos
//
//  Created by Saugat Poudel on 03/07/2024.
//

import Foundation

class ApiServicee{
    func fetchTodos() async throws -> [TodoItem]{
        let url = URL(string: "https://saugat45.pythonanywhere.com/todos")!
                let (data, _) = try await URLSession.shared.data(from: url)
                let todos = try JSONDecoder().decode([TodoItem].self, from: data)
                return todos
    }
    func addTodo(_ todo: TodoItem) async throws {
            let url = URL(string: "https://saugat45.pythonanywhere.com/todos")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(todo)
            let (_, response) = try await URLSession.shared.data(for: request)
            guard (response as? HTTPURLResponse)?.statusCode == 201 else {
                throw URLError(.badServerResponse)
            }
        }
    
    func updateTodo(id: Int, isCompleted:Bool) async throws {
            let url = URL(string: "https://saugat45.pythonanywhere.com/todos/\(id)")!
            var request = URLRequest(url: url)
            request.httpMethod = "PATCH"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
            let jsonBody: [String:Bool]=[
                "isCompleted": isCompleted
            ]
        
            let jsonData = try JSONSerialization.data(withJSONObject: jsonBody, options: [])
            request.httpBody = jsonData
            let (_, response) = try await URLSession.shared.data(for: request)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
        }
}
