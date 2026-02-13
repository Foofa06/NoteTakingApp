//
//  NoteDetailView.swift
//  NoteTakingApp
//
//  Created by Fawzia Jassim on 2/09/26.
//

import SwiftUI

struct NoteDetailView: View {
    
    var note: AppNote
    @ObservedObject var viewModel: NotesViewModel
    
    @State private var showingEditView = false
    
    var body: some View {
        ZStack {
            
            // 💜 Pink → Purple Gradient Background
            LinearGradient(
                colors: [Color.pink.opacity(0.3), Color.purple.opacity(0.3)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                
                Text(note.title)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.purple)
                    .strikethrough(note.isCompleted)
                
                Text(note.content)
                    .font(.body)
                    .foregroundColor(.black)
                    .strikethrough(note.isCompleted)
                
                Button(action: {
                    viewModel.toggleCompletion(note: note)
                }) {
                    Text(note.isCompleted ? "Mark as Incomplete 💗" : "Mark as Completed 💜")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(note.isCompleted ? Color.pink : Color.purple)
                        .cornerRadius(12)
                        .shadow(color: .purple.opacity(0.3), radius: 5)
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Note Details 🎀")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Edit") {
                    showingEditView = true
                }
                .foregroundColor(.purple)
            }
        }
        .sheet(isPresented: $showingEditView) {
            AddEditNoteView(viewModel: viewModel, existingNote: note)
        }
        .tint(.purple)
    }
}


