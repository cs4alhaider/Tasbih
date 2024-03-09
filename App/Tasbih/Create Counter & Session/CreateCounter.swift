//
//  CreateCounter.swift
//  Tasbih
//
//  Created by Abdullah Alhaider on 09/03/2024.
//

import SwiftUI
import CounterKit
import Helper4Swift
import ViewsKit
// Represents the data needed to create a new counter entity.
struct CreateCounterEntity {
    var name: String = ""
    var desc: String = ""
    var color: Color = .accentColor // Default to the accent color of the app.
    var isFavorite: Bool = false
    var showCreateSessionView: Bool = false // Controls the visibility of the session creation view.
}

// The view for creating a new counter, including its sessions.
struct CreateCounterView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var entity: CreateCounterEntity = .init()
    @State private var sessions: [CounterSession] = []
    @FocusState private var isTitleFocused: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                // Section for entering tasbih name and description.
                Section {
                    TextField("Tasbih Short Name", text: $entity.name, axis: .vertical)
                        .focused($isTitleFocused) // Focuses this text field when the view appears.
                    TextField("Tasbih full text (optional)..", text: $entity.desc, axis: .vertical)
                } header: {
                    Text("Tasbih Info")
                }
                
                // Section for selecting the color and marking the counter as favorite.
                Section {
                    ColorPicker(selection: $entity.color) {
                        Label {
                            Text("Color")
                        } icon: {
                            Image(systemName: "paintpalette")
                                .foregroundStyle(entity.color)
                                .animation(.smooth, value: entity.isFavorite)
                        }
                    }
                    Toggle(isOn: $entity.isFavorite) {
                        Label {
                            Text("Mark it as favorite")
                        } icon: {
                            Image(systemName: entity.isFavorite ? "star.fill" : "star")
                                .foregroundStyle(entity.isFavorite ? Color.orange : Color.accentColor)
                                .animation(.smooth, value: entity.isFavorite)
                        }
                    }
                }
                
                // Dynamically adds sections for each session.
                ForEach($sessions) { $newSession in
                    Section {
                        CreateCounterSession(session: $newSession)
                        if newSession == sessions.last {
                            withAnimation {
                                Button("Add another session..", action: addNewSession)
                            }
                        }
                    } header: {
                        Text("Session")
                    }
                }
                
                // Button to add the first session if none exist.
                if sessions.isEmpty {
                    Section {
                        Button("Add new session..", action: addNewSession)
                    } header: {
                        Text("Session")
                    }
                }
                
                // Button to create the counter with the entered details.
                Section {
                    Button("Create", action: createCounter)
                        .disabled(entity.name.isEmpty || sessions.isEmpty) // Disable if required details are missing.
                }
            }
            .dismissButton(placement: .topBarLeading)
            .navigationTitle("Create New Tasbih")
            .navigationBarTitleDisplayMode(.inline)
            .interactiveDismissDisabled() // Prevents dismissal without completing the creation.
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    isTitleFocused = true // Focus the title field shortly after appearing.
                }
            }
        }
    }
    
    // Adds a new blank session to the sessions array.
    private func addNewSession() {
        let session: CounterSession = .init()
        withAnimation {
            sessions.append(session)
        }
    }
    
    // Creates a new counter object and adds it to the model context, then dismisses the view.
    private func createCounter() {
        let counter = Counter(
            name: entity.name,
            color: entity.color.toHexString() ?? "#000000",
            isFavorite: entity.isFavorite,
            sessions: sessions
        )
        withAnimation {
            modelContext.insert(counter)
        }
        dismiss()
    }
}
