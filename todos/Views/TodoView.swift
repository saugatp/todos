//
//  TodoView.swift
//  todos
//
//  Created by Saugat Poudel on 05/07/2024.
//

import SwiftUI

struct TodoView: View {
    var todo: TodoItem
    
    var body: some View {
        Text(todo.task)
            .strikethrough(todo.isCompleted)
            .foregroundColor(todo.isCompleted ? .gray : .black)
    }
}
