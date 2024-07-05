//
//  TodoListView.swift
//  todos
//
//  Created by Saugat Poudel on 05/07/2024.
//

import SwiftUI

struct TodoListView: View {
    @StateObject private var viewModel = TodoViewModel()
    @State private var activeOnly = true
    var filteredTodos : [TodoItem] {
        viewModel.todos.filter{ todo in
            (!activeOnly || todo.isCompleted==false)
        }
    }
    @State private var newTodo = ""
    @State private var isAddReminderDialogPresented = false
    private func presentAddReminderView() {
        isAddReminderDialogPresented.toggle()
      }
    
    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $activeOnly, label: {
                    Text("Show Active Only")
                })
                    ForEach(filteredTodos){ todo in
                        TodoView(todo: todo)
                            .onTapGesture {
                            Task {
                                await viewModel.updateTask(id:todo.id!)
                            }
                        }
                        
                    }
            }.animation(.smooth, value: filteredTodos)
            .navigationTitle("Todo List")
            .toolbar {
                 ToolbarItemGroup(placement: .bottomBar) {
                   Button(action: presentAddReminderView) {
                       HStack(alignment:.center) {
                       Image(systemName: "plus.circle.fill")
                       Text("New Task")
                     }
                   }
                   Spacer()
                 }
               }
            .task {
                await viewModel.fetchItems()
            }
            .sheet(isPresented:$isAddReminderDialogPresented){
                AddTaskView { newtodo in
                    Task {
                        await viewModel.addItem(task: newtodo)
                    }
                      }
                
            }
            .alert("Error", isPresented: .constant(viewModel.errorMessage != nil), actions: {
                Button("OK") { viewModel.errorMessage = nil }
            }, message: {
                Text(viewModel.errorMessage ?? "")
            })
        }
    }
}
