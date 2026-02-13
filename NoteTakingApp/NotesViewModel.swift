//
//  NotesViewModel.swift
//  NoteTakingApp
//
//  Created by Fawzia Jassim on 2/09/26.
//

import Foundation
import Combine
import SwiftUI

class NotesViewModel: ObservableObject {
    
    @Published var notes: [AppNote] = []
    
    @AppStorage("savedNotes") private var savedNotesData: Data = Data()
    
    init() {
        loadNotes()
    }
    
    func addNote(title: String, content: String) {
        let newNote = AppNote(title: title, content: content)
        notes.append(newNote)
        saveNotes()
    }
    
    func updateNote(note: AppNote) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index] = note
            saveNotes()
        }
    }
    
    func toggleCompletion(note: AppNote) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index].isCompleted.toggle()
            saveNotes()
        }
    }
    
    func deleteNote(at offsets: IndexSet) {
        notes.remove(atOffsets: offsets)
        saveNotes()
    }
    
    private func saveNotes() {
        if let encoded = try? JSONEncoder().encode(notes) {
            savedNotesData = encoded
        }
    }
    
    private func loadNotes() {
        if let decoded = try? JSONDecoder().decode([AppNote].self, from: savedNotesData) {
            notes = decoded
        }
    }
}
