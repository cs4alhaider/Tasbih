//
//  ContentView.swift
//  Tasbih
//
//  Created by Abdullah Alhaider on 09/03/2024.
//

import SwiftUI
import SwiftData
import CounterKit

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    // @Query private var items: [Item]

    var body: some View {
        CountersList()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Counter.self, inMemory: true)
}
