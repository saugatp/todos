//
//  TodoItem.swift
//  todos
//
//  Created by Saugat Poudel on 03/07/2024.
//

import Foundation

struct TodoItem: Hashable, Codable, Identifiable {
    var id: Int? = 0
    var priority: String = "low"
    var isCompleted: Bool = false
    var task: String
}
