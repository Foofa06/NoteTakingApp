//
//  AppNote.swift
//  NoteTakingApp
//
//  Created by Fawzia Jassim on 2/09/26.
//

import Foundation

struct AppNote: Identifiable, Codable {
    let id: UUID
    var title: String
    var content: String
    var isCompleted: Bool
    
    init(id: UUID = UUID(), title: String, content: String, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.content = content
        self.isCompleted = isCompleted
    }
}

