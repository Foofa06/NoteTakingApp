//
// ContentView.swift
// NoteTakingApp
//
// Created by Fawzia Jassim on 2/09/26.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = NotesViewModel()
    @State private var showingAddView = false
    
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
                
                List {
                    ForEach(viewModel.notes) { note in
                        
                        NavigationLink(
                            destination: NoteDetailView(note: note, viewModel: viewModel)
                        ) {
                            
                            HStack {
                                
                                VStack(alignment: .leading, spacing: 6) {
                                    
                                    Text(note.title)
                                        .font(.headline)
                                        .foregroundColor(.purple)
                                        .strikethrough(note.isCompleted)
                                    
                                    Text(note.content)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .lineLimit(1)
                                }
                                
                                Spacer()
                                
                                if note.isCompleted {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.pink)
                                }
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.white)
                                    .shadow(color: .purple.opacity(0.3), radius: 5)
                            )
                            .padding(.vertical, 6)
                        }
                        .listRowBackground(Color.clear)
                    }
                    .onDelete(perform: viewModel.deleteNote)
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("My Notes 🎀")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddView = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.pink)
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddEditNoteView(viewModel: viewModel)
            }
        }
        .tint(.purple)
    }
}

