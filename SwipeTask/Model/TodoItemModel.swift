//
//  TodoItemModel.swift
//  SwipeTask
//
//  Created by Nils on 3/29/24.
//

import Foundation

struct TodoItemModel: Identifiable {
    let id: String = UUID().uuidString;
    var title: String;
    var timeSpend: String;
    var dueDate: String;
    var priority: Int;
    var completed: Bool;
    var completedDate: String;
}

