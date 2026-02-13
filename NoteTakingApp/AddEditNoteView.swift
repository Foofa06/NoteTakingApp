//
//  AddEditNoteView.swift
//  NoteTakingApp
//
//  Created by Fawzia Jassim on 2/09/26.
//

import SwiftUI

struct AddEditNoteView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: NotesViewModel
    
    var existingNote: AppNote?
    
    @State private var title: String = ""
    @State private var content: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                // 💜 Pink → Purple Gradient Background
                LinearGradient(
                    colors: [Color.pink.opacity(0.3), Color.purple.opacity(0.3)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                Form {
                    
                    Section(header:
                        Text("Title")
                            .foregroundColor(.purple)
                            .font(.headline)
                    ) {
                        TextField("Enter title", text: $title)
                    }
                    
                    Section(header:
                        Text("Content")
                            .foregroundColor(.purple)
                            .font(.headline)
                    ) {
                        TextEditor(text: $content)
                            .frame(height: 200)
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle(existingNote == nil ? "Add Note 🎀" : "Edit Note 🎀")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        saveNote()
                    } label: {
                        Text("Save")
                            .bold()
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.purple)
                            .cornerRadius(8)
                    }
                }
            }
            .onAppear {
                if let note = existingNote {
                    title = note.title
                    content = note.content
                }
            }
        }
        .tint(.purple)
    }
    
    private func saveNote() {
        if let note = existingNote {
            var updatedNote = note
            updatedNote.title = title
            updatedNote.content = content
            viewModel.updateNote(note: updatedNote)
        } else {
            viewModel.addNote(title: title, content: content)
        }
        
        dismiss()
    }
}


