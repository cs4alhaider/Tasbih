//
//  CountersList.swift
//  Tasbih
//
//  Created by Abdullah Alhaider on 09/03/2024.
//

import SwiftUI
import CounterKit
import SwiftData

struct CountersList: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Counter.createdAt, order: .reverse) private var counters: [Counter]
    @State private var selection: Counter?
    @State private var showCreateCounter: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                if counters.isEmpty {
                    ContentUnavailableView {
                        Image(systemName: "note.text")
                    } description: {
                        Text("There is no counter yet, try to create one now!")
                    } actions: {
                        Button {
                            showCreateCounter.toggle()
                        } label: {
                            Label("Create New Counter", systemImage: "note.text.badge.plus")
                        }
                    }
                    .listRowSeparator(.hidden)
                } else {
                    ForEach(counters) { counter in
                        CounterCard(counter: counter)
                            .onTapGesture {
                                selection = counter
                            }
                            .contextMenu {
                                Button("Edit") {
                                    print("Edit counter tapped")
                                }
                            }
                    }
                    .onDelete(perform: deleteItems)
                    .listRowInsets(EdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 5))
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Tasbih")
            .navigationDestination(item: $selection) { counter in
                CounterDetails(counter: counter)
            }
            .toolbar {
                if !counters.isEmpty {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showCreateCounter.toggle()
                        } label: {
                            Image(systemName: "note.text.badge.plus")
                        }
                    }
                    
                    ToolbarItem(placement: .topBarLeading) {
                        EditButton()
                    }
                }
            }
            .sheet(isPresented: $showCreateCounter) {
                CreateCounterView()
                //                CounterProgressView(progressPercentage: .constant(40), color: .constant(.pink))
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(counters[index])
            }
        }
    }
}
