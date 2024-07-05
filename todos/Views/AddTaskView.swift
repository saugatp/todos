//
//  AddTaskView.swift
//  todos
//
//  Created by Saugat Poudel on 03/07/2024.
//

import SwiftUI

struct AddTaskView: View {
    enum FocusableField:Hashable{
        case todo
    }
    
    @FocusState
    private var focusedField: FocusableField?
    
    @State private var newTodo = ""
    @Environment(\.dismiss)
      private var dismiss
    var onCommit: (_ task: String) -> Void
    private func commit() {
        onCommit(newTodo)
        dismiss()
    }
    private func cancel(){
        dismiss()
    }

     var body: some View {
       NavigationStack {
         Form {
             TextField("Your task", text: $newTodo).focused($focusedField, equals: .todo)
         }
         .navigationTitle("New Task")
         .navigationBarTitleDisplayMode(.inline)
         .toolbar {
           ToolbarItem(placement: .confirmationAction) {
             Button(action: commit) {
               Text("Add")
             }.disabled(newTodo.isEmpty)
           }
             ToolbarItem(placement: .cancellationAction){
                 Button(action:cancel){
                     Text("Cancel")
                 }
             }
         }
       }.onAppear{
           focusedField = .todo
       }
     }
   }
