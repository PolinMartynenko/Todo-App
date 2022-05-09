//
//  Entry.swift
//  TodoApp
//
//  Created by Polina Martynenko on 16.04.2022.
//

import Foundation

struct Entry: Codable {
    var id = UUID()
    var isCompleted : Bool
    var text: String
    var date: Date?
}
